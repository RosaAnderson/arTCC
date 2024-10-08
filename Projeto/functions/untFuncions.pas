unit untFuncions;

interface

uses
    Winapi.ShellAPI, Winapi.Messages, Winapi.Windows,

    System.SysUtils, System.Variants, System.Classes, System.DateUtils,

    Vcl.Graphics, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Forms,
    Vcl.Buttons,

//    Datasnap.DBClient,
//    Datasnap.Provider,

    Data.DB,

    FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
    FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
    FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
    FireDAC.Comp.UI, FireDAC.FMXUI.Wait, FireDAC.Comp.Client, FireDAC.Stan.Param,
    FireDAC.Comp.DataSet, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,

    jpeg
    ;

    // decaração das funções
    function GetBuildInfo(ProgamName: string): string;

var
    qryAuxiliar: TFDQuery;

implementation

uses untConstants;

function GetBuildInfo(ProgamName: string): string;
var
    VerInfoSize: DWORD;
    VerInfo: Pointer;
    VerValueSize: DWORD;
    VerValue: PVSFixedFileInfo;
    Dummy: DWORD;
    V1, V2, V3, V4: Word;
begin
    try
        VerInfoSize := GetFileVersionInfoSize(PChar(ProgamName), Dummy);
        GetMem(VerInfo, VerInfoSize);
        GetFileVersionInfo(PChar(ProgamName), 0, VerInfoSize, VerInfo);
        VerQueryValue(VerInfo, '', Pointer(VerValue), VerValueSize);

        with (VerValue^) do
        begin
            V1 := dwFileVersionMS shr 16;
            V2 := dwFileVersionMS and $FFFF;
            V3 := dwFileVersionLS shr 16;
            V4 := dwFileVersionLS and $FFFF;
        end;

        FreeMem(VerInfo, VerInfoSize);
        Result := Format('%d.%d.%d.%d', [v1, v2, v3, v4]);
    except
        Result := '0.0.999.1';
    end;
end;

end.

//##############################################################################
//##############################################################################
    LoadMessage({janela de ogigem}    Self.Caption,
                {título da mensagem}  '',
                {mensagem ao usuário} '',
                {caminho do ícone}    '', {check/error/question/exclamation}
                {botão}               '', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                {nome do link}        '',
                {link}                ''
               );

    SingleResult({DB TzConnection}        ,
                 {campo retornado}      '',
                 {tabela}               '',
                 {campo de filtro}      '',
                 {operador da pesquisa} '',
                 {valor do filtro}      '',
                 {where composto}       '',
                 {ordenação (order by)} '');

    SingleUpdate({DB TzConnection}        ,
                 {campo atualizado}     '',
                 {valor atualizado}     '',
                 {tabela}               '',
                 {campo de filtro}      '',
                 {operador da pesquisa} '',
                 {valor do filtro}      '',
                 {where composto}       '',
                 {ordenação (order by)} '');

    AddMensagemBO({codigo do registro}      vpCodReg,
                  {cod usuario origem}      vpCodOri,
                  {cod usuario destino}     vpCodDes,
                  {cod usuario alternativo} vpCodAlt,
                  {Descritivo 01}           vpDesT01,
                  {Descritivo 02}           vpDesT02,
                  {Descritivo 03}           vpDesT03,
                  {Data}                    vpDtPrev,
                  {Tipo de mensagem}        vpType);

//##############################################################################
//##############################################################################
WITH (NOLOCK)


//##############################################################################
//##############################################################################
//##############################################################################
unit untFuncao;

interface

uses
  Winapi.ShellAPI, Winapi.Messages, Winapi.Windows,

  System.SysUtils, System.Variants, System.Classes, System.DateUtils,

  Vcl.Graphics, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Forms,
  Vcl.Buttons,

  VCLTee.TeeData,

  ZConnection,
  ZDataset,

  Datasnap.DBClient, Datasnap.Provider,

  Data.DB,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.FMXUI.Wait, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.Comp.DataSet, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,

  jpeg
  ;

  type ThCarrFoto = class(TThread)
    protected
      FImage: TImage;
      FDiretorio: String;
      FStream: TStream;
      procedure Execute; override;
    public
      Property Image: TImage Read FImage Write FImage;
      property Diretorio: String Read FDiretorio Write FDiretorio;
      property Stream: TStream Read FStream Write FStream;
      constructor Create;
      destructor Destroy; override;
    end;

    type TSecaoGiro = class
    protected
      FSecaoGiro: String;
      FQtdeGiro: Integer;
    public
      property SecaoGiro: String Read FSecaoGiro;
      property QtdeGiro: Integer Read FQtdeGiro;
      constructor Create(SecaoGiro: string; QtdeGiro: Integer);
      destructor destroy;
    end;

    TTipoDado = (tdInteger, tdFloat, tdString, tdChar, tdDate, tdTime, tdDateTime, tdBoolean);



    // decaração das funções
    function sysUpdatingCheck():Boolean;

    function LoadMessage(vfTituloJan, vfTituloMen, vfMensagem, vfIcone, vfButton, vfNameLink, vfLink: string): boolean;
    function LoadBallon(vfLeft, vfTop: Integer; vfPosition, vfMessage: string): boolean;
    function LoadPopUp(vfMessage: string): boolean;
    function OnlyBusinessDay(vfStartDate: TDateTime): TDateTime;

    function SingleResult(vfConnection: TzConnection; vfReturnField, vfTable, vfFilterField, vfOperator, vfValue, vfWhere, vfOrder: string): string;
    function SingleUpdate(vfConnection: TzConnection; vfUpdateField, vfUpdateValue, vfTable, vfSearchField, vfOperator, vfSearchValue, vfWhere, vfOrder: string): Boolean;

    function NameCase(vfName: string): string;
    function FormatDocs(vfDoc: string): string;
    function lineBreak(vfText, vfCaption: string; vfLineLength :Integer): string;
    function MessagePopUp(vfTitulo, vfDescricao: string): string;
    function FriendlyTime(vfDateTime: TDateTime): string;

    function ValidateMail(vfMail: string):Boolean;
    function ValidateCel(vfCell: string):Boolean;
    function ValidatePass(vfPass: string):Boolean;

    function ISpace(vfFields, vfPos: string; vfChar: Char; vfSize: Integer): string;
    function getTimeProcess(vfNome, vfLocal, vfCiclo: string; vfArray, vfArrayE: SmallInt): Double;

    // declaração dos procedimentos
    procedure execPath(vpOperator, vpURL: PWideChar);
    procedure RequiredField(vpForm: TForm);
    procedure txtExport(vpArqName, vpLineDesc, vpText: string);

    procedure DoCarrImagDire(Image: TImage; Diretorio: String = '');
    procedure PopularGrafico(Query: TZQuery; Gcds: TChartDataSet);
    procedure CarregaSecoes(ForcaRefresh:Boolean = False);



    function SimInputBox(Titulo: string;
                         Descricao : string;
                         ValorPadrao: string = '';
                         QtdeMini: Integer = 0;
                         QtdeMaxi: Integer = 0;
                         CharCase:  TEditCharCase = ecUpperCase;
                         MemoHeight: Integer = 22;
                         TipoDado: TTipoDado = tdString): String;

    function Criptografar(wStri: string): String;
    function getGiro(Ficha: Integer; Secao: String): Integer;
    function getSecaoGiro(Ficha: Integer; GrupoSecaoId: Integer): String;
    function getFichaGiro(Ficha: Integer; GrupoSecaoId: Integer): TSecaoGiro;
    function getOrder(vfBO: Integer): Integer;

    function AddFichaPlanoGiro(Ficha: Integer; Plano: String): Boolean;

    function ValidarPhone(vfNumero: string): string;

    procedure AddMensagemBO(vpCodReg, vpCodOri, vpCodDes, vpCodAlt: Integer;
                            vpDesT01, vpDesT02, vpDesT03, vpDtPrev, vpType: string);

//    procedure postMessage; /// eliminar depois de testar

var
    lth_CarrFoto              : ThCarrFoto;
    gs_FiltroPlano            : string;
    gs_SecaoCorte             : string;
    gb_GiroHabilitado         : Boolean;
    gdt_UltiProcGiro          : TDateTime; // Ultimo Processamento de giro
    gi_TempMinuRefrGiro       : Integer;   // Tempo em minutos para o refresh do giro
    gi_CodigoPedidoPrioritario: Integer;   // Tipo de contato do follow up do pedido

    qryAuxiliar: TZQuery;

    //
    vLocal    : array[1..255] of string;
    vTime     : array[1..255] of Double;
    vTimeTotal: array[1..255] of Double;

 implementation

 uses
    untSimInputBox, untDm, untMessage, untBalloon, untConstantes, untPopUp;


// Procedure carrega imagem do aquivo
Procedure DoCarrImagDire(Image: TImage; Diretorio: String = '');
begin
    lth_CarrFoto                 := ThCarrFoto.Create;
    lth_CarrFoto.Image           := Image;
    lth_CarrFoto.Diretorio       := Diretorio;
    lth_CarrFoto.FreeOnTerminate := True;
    lth_CarrFoto.Start;
end;

{ ThCarrFoto }

constructor ThCarrFoto.Create;
begin
    inherited Create(True);
end;

destructor ThCarrFoto.Destroy;
begin
  inherited;
  FDiretorio := '';
end;

procedure ThCarrFoto.Execute;
var
 JPEGImage: TJPEGImage;
begin
  inherited;
  // Executando o carregamento da foto
  FImage.Picture := nil;
  if Assigned(FStream) or (FDiretorio <> '') then
  begin
    if FDiretorio <> '' then
    begin
      // Verificando se o arquivo existe
      if FileExists (FDiretorio) then
      begin
        try
          FImage.Picture.LoadFromFile(Diretorio);
        except
          // Ocultamos erros
        end;
      end;
    end
    else
    begin
      if Assigned(FStream) then
      begin
        try
          JPEGImage := TJPEGImage.Create;
          JPEGImage.LoadFromStream(FStream);
          FImage.Picture.Assign(JPEGImage);
        finally
          JPEGImage := nil;
        end;
      end;
    end;
  end;
end;

// Popular Grafico
Procedure PopularGrafico(Query : TZQuery; Gcds : TChartDataSet);
var
  i : Integer;
begin
  // Excluindo registros atuais
  Gcds.Close;
  Gcds.Open;

  Query.First;

  while not (Query.Eof) do
  begin
    Gcds.Append;
    for I := 0 to Query.FieldCount - 1 do
    begin
      Gcds.Fields[I].Value := Query.FieldByName(Gcds.Fields[I].FieldName).Value;
    end;
    gcds.Post;
    Query.Next;
  end;
end;

function SimInputBox(Titulo: string;
                     Descricao : string;
                     ValorPadrao: string = '';
                     QtdeMini: Integer = 0;
                     QtdeMaxi: Integer = 0;
                     CharCase:  TEditCharCase = ecUpperCase;
                     MemoHeight: Integer = 22;
                     TipoDado: TTipoDado = tdString) : String;
begin
  // Criando a tela para a inserção dos dados
  try
    frmSIMInputBox := TfrmSIMInputBox.Create(nil);
    frmSIMInputBox.Height := frmSIMInputBox.Height + (MemoHeight - frmSIMInputBox.mmoTexto.Height);
    frmSIMInputBox.lblTitulo.Caption := Titulo;
    frmSIMInputBox.Descricao := Descricao;
    frmSIMInputBox.pi_QtdeMiniCara := QtdeMini;
    frmSIMInputBox.pi_QtdeMaxiCara := QtdeMaxi;
    frmSIMInputBox.mmoTexto.Text := ValorPadrao;
    frmSIMInputBox.CharCase := CharCase;
    frmSIMInputBox.TipoDado := TipoDado;


    if frmSIMInputBox.ShowModal = mrOk then
    begin
      Result := frmSIMInputBox.mmoTexto.Text;
    end
    else
    begin
      Result := '';
    end;
  finally
    if Assigned(frmSIMInputBox) then
      frmSIMInputBox.Free;
  end;
end;


{ Retorna a string Criptografa ou Descriptografada }
function Criptografar(wStri: string): String;
var
    Simbolos: array [0..4] of String;
    x: Integer;
begin
    Simbolos[1] := 'ABCDEFGHIJLMNOPQRSTUVXZYWK ~!@#$%^&*()\|Ã';
    Simbolos[2] := 'ÂÀ©çêùÿ5Üø£úñÑªº¿®¬¼ëèïÙýÄÅÉæÆôöò»Øû×ƒÁ"Ê';
    Simbolos[3] := 'abcdefghijlmnopqrstuvxzywk1234567890.:ã_';
    Simbolos[4] := 'àåíóÇüé¾¶§÷ÎÏ-+ÌÓß¸°¨·¹³²Õµþîì¡«½áâä.¢ã_';

    Result := '';

    for x := 1 to Length(Trim(wStri)) do
    begin
        if pos(copy(wStri, x, 1),Simbolos[1]) > 0 then
            Result := Result+copy(Simbolos[2], pos(copy(wStri,x,1), Simbolos[1]),1)
        else if pos(copy(wStri, x, 1),Simbolos[2]) > 0 then
            Result := Result+copy(Simbolos[1], pos(copy(wStri,x,1), Simbolos[2]),1)
        else if pos(copy(wStri, x, 1),Simbolos[3]) > 0 then
            Result := Result+copy(Simbolos[4], pos(copy(wStri,x,1), Simbolos[3]),1)
        else if pos(copy(wStri, x, 1),Simbolos[4]) > 0 then
            Result := Result+copy(Simbolos[3], pos(copy(wStri,x,1), Simbolos[4]),1);
    end;
end;

procedure CarregaSecoes(ForcaRefresh:Boolean = False);
var
    qrySecoes: TZQuery;
    li_SecaoOrdem: Integer;
    ls_Auxi: string;
begin
    // Carregando as seções ordenadas por grupo em cds
    if (dm.qrySecaoGrupo.Active) And (dm.cdsSecoes.Active) and (ForcaRefresh = False) then
    begin
        Exit;
    end;

    dm.qrySecaoGrupo.Close;
    dm.qrySecaoGrupo.Open;
    dm.cdsSecoes.Close;
    dm.cdsSecoes.CreateDataSet;

    try
        qrySecoes := TZQuery.Create(nil);
        qrySecoes.Connection :=dm.ConnPlug;
        qrySecoes.SQL.Add('SELECT SECCOD,              ');
        qrySecoes.SQL.Add('       SECDES               ');
        qrySecoes.SQL.Add('  FROM TSEC01 WITH (NOLOCK) ');
        qrySecoes.SQL.Add(' WHERE SECSITUACAO = ''A''  ');
        qrySecoes.SQL.Add('   AND SECCOD = :CODIGO     ');

        while not(dm.qrySecaoGrupo.Eof) do
        begin
            // Buscando as secoes do grupo
            ls_Auxi := dm.qrySecaoGrupo.FieldByName('SECOES').AsString;
            li_SecaoOrdem := 1;

            while ls_Auxi <> '' do
            begin
                qrySecoes.Close;

                if Pos(',', ls_Auxi) > 0 then
                begin
                    qrySecoes.ParamByName('CODIGO').AsString := Copy(ls_Auxi, 1, Pos(',', ls_Auxi) -1);
                    Delete(ls_Auxi, 1, Pos(',',ls_Auxi));
                end
                else
                begin
                    qrySecoes.ParamByName('CODIGO').AsString := ls_Auxi;
                    ls_Auxi := '';
                end;

                qrySecoes.Open;

                if qrySecoes.IsEmpty = False then
                begin
                    dm.cdsSecoes.Append;
                    dm.cdsSecoes.FieldByName('GRUPOORDEM').AsInteger := dm.qrySecaoGrupo.FieldByName('ORDEM').AsInteger;
                    dm.cdsSecoes.FieldByName('GRUPOSECAOID').AsInteger := dm.qrySecaoGrupo.FieldByName('ID').AsInteger;
                    dm.cdsSecoes.FieldByName('GRUPOSECAODESC').AsString := dm.qrySecaoGrupo.FieldByName('DESCRICAO').AsString;
                    dm.cdsSecoes.FieldByName('GRUPOSECAOPROXGRUPID').AsInteger := dm.qrySecaoGrupo.FieldByName('PROXSECAOGRUPOID').AsInteger;
                    dm.cdsSecoes.FieldByName('SECAOORDEM').AsInteger := li_SecaoOrdem;
                    dm.cdsSecoes.FieldByName('SECAO').AsString := qrySecoes.FieldByName('SECCOD').AsString;
                    dm.cdsSecoes.FieldByName('SECAODESC').AsString := qrySecoes.FieldByName('SECDES').AsString;

                    // Verificando se é uma seção paralela ao giro
                    dm.cdsSecoes.FieldByName('SECAOPARALELA').AsBoolean :=
                                                Pos(',' + qrySecoes.FieldByName('SECCOD').AsString + ',' ,
                                                ',' + dm.qrySecaoGrupo.FieldByName('SECOESPARALELAS').AsString + ',') > 0;

                    dm.cdsSecoes.FieldByName('SECOESSEGUINTES').AsString := ls_Auxi;

                    dm.cdsSecoes.Post;

                    li_SecaoOrdem := li_SecaoOrdem + 1;
                end;
            end;

            dm.qrySecaoGrupo.Next;
        end;

    finally
        qrySecoes.Close;
        qrySecoes.Free;
    end;
end;

function getGiro(Ficha : Integer; Secao: String) : Integer;
begin
  if gb_GiroHabilitado = False then
  begin
    Result := 0;
    Exit;
  end;

  // Buscando se a ficha já tem o giro processado
  while True do
  begin
    if dm.cdsGiro.Locate('FICHA;SECAO',VarArrayOf([Ficha,Secao]),[]) then
    begin
      // Se localizou retornamos o valor
      Result := dm.cdsGiro.FieldByName('GIRO').AsInteger;
      break;
    end
    else
    begin
      // Verificando se a ficha já foi processada
      if dm.cdsGiro.Locate('FICHA',Ficha,[]) then
      begin
        // Ficha foi processada porém não usa a seção específica
        Result := 0;
        break;
      end
      else
      begin
        // Ficha não processada, vamos realizar o giro da mesma
        If AddFichaPlanoGiro(Ficha, '') = False then
        begin
          Break;
        end;
      end;
    end;
  end;
end;

function AddFichaPlanoGiro(Ficha: Integer; Plano: String): Boolean;
var
    qryFichaSecoes: TZQuery;
    cdsSecoes: TClientDataSet;
    li_Ficha: Integer;
    li_GrupoId: Integer;
    li_QtdeBaixa: Integer;
    li_QtdeGiro: Integer;
    lb_giro: Boolean;
    li_NReg: Integer;
begin
//*
{40}getTimeProcess('', 'Full', 'i', 40, 0); //###############
    if gb_GiroHabilitado = False then
    begin
        Result := False;
        Exit;
    end;

    if (Ficha = 0) and (Plano = '') then
    begin
        LoadMessage({janela de ogigem}    'AddFichaPlanoGiro',
                    {título da mensagem}  'Erro ao processar giro',
                    {mensagem ao usuário} 'Ficha e plano não informados!',
                    {caminho do ícone}    'error', {check/error/question/exclamation}
                    {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                    {nome do link}        '',
                    {link}                ''
                   );
//        raise exception.Create('Erro ao processar giro, ficha e plano não informados');
    end;

    // Carregando a estrutura de componentes e seções;
    CarregaSecoes(False);

    try
        qryFichaSecoes := TZQuery.Create(nil);
        qryFichaSecoes.Connection :=dm.ConnPlug;

        With qryFichaSecoes.SQL do
        begin
            Add(' SELECT FX.FXPFIC AS FICHA,                                          ');
            Add('        FX.FXPTFIC AS QTDE,                                          ');
            Add('        PLG.CPRSECCOD AS SECAOCOD,                                   ');
            Add('        (SELECT COALESCE(SUM(RFXTFIC), 0)                            ');
            Add('           FROM TRFX01 WITH (NOLOCK)                                 ');
            Add('          WHERE RFXFIC = FX.FXPFIC                                   ');
            Add('            AND RFXSEC = PLG.CPRSECCOD) AS QTDEBAIXA                 ');
            Add('   FROM TFXP01   FX WITH (NOLOCK)                                    ');
            Add('   JOIN TCPR011 PLG WITH (NOLOCK) ON PLG.CPRPLA = FX.PLAPLANO        ');
            Add('   JOIN TMOD05   MS WITH (NOLOCK) ON MS.MODMOD = FX.FXPMOD           ');
            Add('                                 AND MS.MODNUMCOD = FX.FXPNUM        ');
            Add('                                 AND MS.SECCOD = PLG.CPRSECCOD       ');

            if Ficha > 0 then
            begin
                Add('  WHERE FX.FXPFIC = :FICHA                                       ');

                qryFichaSecoes.ParamByName('FICHA').AsInteger := Ficha;
            end
            else
            begin
                Add('  WHERE FX.PLAPLANO = :PLANO                                     ');

                qryFichaSecoes.ParamByName('PLANO').AsString := Plano;
            end;

            Add('    AND COALESCE(MS.MODSUSA, ''N'') = ''S''                          ');
            Add('  ORDER BY FX.FXPFIC,                                                ');
            Add('           PLG.CPRSECCOD                                             ');
        end;

        qryFichaSecoes.Open;

        if qryFichaSecoes.IsEmpty then
        begin
            Result := False;
            Exit;
        end;

        // Percorrendo a qryFichas e processando as fichas na cds giro
        while (qryFichaSecoes.Eof = False) do
        begin
            li_Ficha := qryFichaSecoes.FieldByName('FICHA').AsInteger;
            lb_giro := False;

            // Excluindo os dados de giro da ficha
            while dm.cdsGiro.Locate('FICHA', li_Ficha, []) do
            begin
                dm.cdsGiro.Delete;
            end;

            try
                cdsSecoes := TClientDataSet.Create(nil);
                cdsSecoes.FieldDefs := dm.cdsSecoes.FieldDefs;
                cdsSecoes.Data := dm.cdsSecoes.Data;

                // Alimentando a cds com os dados da ficha
                while (qryFichaSecoes.FieldByName('FICHA').AsInteger = li_Ficha) and (qryFichaSecoes.Eof = False) do
                begin
                    if cdsSecoes.Locate('SECAO', qryFichaSecoes.FieldByName('SECAOCOD').AsString, []) then
                    begin
                        cdsSecoes.Edit;
                        cdsSecoes.FieldByName('Qtde').AsInteger := qryFichaSecoes.FieldByName('Qtde').AsInteger;
                        cdsSecoes.FieldByName('QtdeBaixa').AsInteger := qryFichaSecoes.FieldByName('QtdeBaixa').AsInteger;
                        cdsSecoes.Post;
                    end;

                    qryFichaSecoes.Next;
                end;

                // Excluindo as secoes não utilizadas
                cdsSecoes.First;

                while not (cdsSecoes.Eof) do
                begin
                    if cdsSecoes.FieldByName('Qtde').AsInteger = 0 then
                    begin
                        cdsSecoes.Delete;
                    end
                    else
                    begin
                        cdsSecoes.Next;
                    end;
                end;

                // Cds ficou somente com as secoes utilizadas e em sequencia
                // Verificando se o ultimo grupo de componente teve baixa,
                // se sim marcamos todas as anteriores como sem giro
                cdsSecoes.Last;
                li_GrupoId := cdsSecoes.FieldByName('GrupoSecaoId').AsInteger;

                while (cdsSecoes.FieldByName('GrupoSecaoId').AsInteger = li_GrupoId) and (cdsSecoes.Bof = False) do
                begin
                    if cdsSecoes.FieldByName('Qtde').AsInteger - cdsSecoes.FieldByName('QtdeBaixa').AsInteger = 0 then
                    begin
                        li_QtdeBaixa := cdsSecoes.FieldByName('QtdeBaixa').AsInteger;

                        // Marcando a próxima secao como a de giro
                        cdsSecoes.Next;

                        if cdsSecoes.Eof then
                        begin
                            // Não existe mais seções, então não existe mais giro para a ficha
                            // Incluímos uma seção ficticia de giro
                            dm.cdsGiro.Append;
                            dm.cdsGiro.FieldByName('FICHA').AsInteger := li_Ficha;
                            dm.cdsGiro.FieldByName('SECAO').AsString := '00';
                            dm.cdsGiro.FieldByName('FICHA_SECAO').AsString := IntToStr(li_Ficha) + '_00';
                            dm.cdsGiro.FieldByName('GRUPOSECAOID').AsInteger := 0;
                            dm.cdsGiro.Post;
                        end
                        else
                        begin
                            // Marcando esta seção como giro
                            dm.cdsGiro.Append;
                            dm.cdsGiro.FieldByName('FICHA').AsInteger := li_Ficha;
                            dm.cdsGiro.FieldByName('SECAO').AsString  := cdsSecoes.FieldByName('SECAO').AsString;
                            dm.cdsGiro.FieldByName('GIRO').AsInteger  := li_QtdeBaixa;
                            dm.cdsGiro.FieldByName('FICHA_SECAO').AsString := IntToStr(li_Ficha) + '_' +
                                                                              cdsSecoes.FieldByName('SECAO').AsString;
                            dm.cdsGiro.FieldByName('GRUPOSECAOID').AsInteger := cdsSecoes.FieldByName('GRUPOSECAOID').AsInteger;
                            dm.cdsGiro.Post;
                        end;

                        // Saindo do processmento da ficha
                        lb_giro := True;
                        Break;
                    end;

                    cdsSecoes.Prior;
                end;

                if lb_giro = False then
                begin
                    // Não foi definido giro no ultimo componente, então vamos processar
                    // a sequencia de seções
                    cdsSecoes.First;

                    while not(cdsSecoes.Eof) do
                    begin
                        li_GrupoId := cdsSecoes.FieldByName('GRUPOSECAOID').AsInteger;
                        li_NReg := cdsSecoes.RecNo;
                        li_QtdeBaixa := 0;

                        if cdsSecoes.FieldByName('GIRO').AsInteger = 0 then
                        begin
                            // Primeira seção do grupo colocamos a qtde no giro
                            li_QtdeGiro := cdsSecoes.FieldByName('QTDE').AsInteger;
                        end;

                        while (cdsSecoes.FieldByName('GRUPOSECAOID').AsInteger = li_GrupoId) and (cdsSecoes.Eof = False) do
                        begin
                            li_QtdeBaixa := cdsSecoes.FieldByName('QTDEBAIXA').AsInteger;

                            if li_QtdeBaixa <> li_QtdeGiro then
                            begin
                                if ((li_QtdeBaixa > 0) or (li_QtdeGiro > 0)) and (cdsSecoes.FieldByName('GIRO').AsInteger >= 0) then
                                begin
                                    cdsSecoes.Edit;
                                    cdsSecoes.FieldByName('GIRO').AsInteger := li_QtdeGiro - li_QtdeBaixa;
                                    cdsSecoes.Post;

                                    if (cdsSecoes.FieldByName('SECAOPARALELA').AsBoolean = False) or (li_QtdeGiro > li_QtdeBaixa) then
                                    begin
                                        li_QtdeGiro := li_QtdeBaixa;
                                    end;
                                end
                                else
                                begin
                                    li_QtdeGiro := 0;
                                end;
                            end;

                            li_NReg := cdsSecoes.RecNo;
                            cdsSecoes.Next;
                        end;

                        // Processando o giro inversamente, para acertar secoes posteriores que foram baixadas
                        // então removemos o giro de secoes anteriores
                        cdsSecoes.Prior;
                        li_QtdeGiro := cdsSecoes.FieldByName('GIRO').AsInteger;

                        if li_QtdeGiro <= 0 then
                        begin
                            li_QtdeGiro := cdsSecoes.FieldByName('QTDEBAIXA').AsInteger;
                        end;

                        cdsSecoes.Prior;

                        while (cdsSecoes.FieldByName('GRUPOSECAOID').AsInteger = li_GrupoId) and (cdsSecoes.Bof = False) do
                        begin
                            if (li_QtdeGiro > 0) then
                            begin
                                if (cdsSecoes.FieldByName('GIRO').AsInteger > 0) then
                                begin
                                    // Ajustando o giro
                                    cdsSecoes.Edit;
                                    cdsSecoes.FieldByName('GIRO').AsInteger := cdsSecoes.FieldByName('QTDE').AsInteger - li_QtdeGiro;
                                    cdsSecoes.Post;

                                    li_QtdeGiro := cdsSecoes.FieldByName('GIRO').AsInteger;
                                end;
                            end
                            else
                            begin
                                li_QtdeGiro := cdsSecoes.FieldByName('GIRO').AsInteger;
                            end;

                            cdsSecoes.prior;
                        end;

                        // Voltando ao final do grupo de seções que já foi processado
                        cdsSecoes.RecNo := li_NReg;
                        cdsSecoes.Next;

                        // Verificando se chegou no final da cds
                        if cdsSecoes.Eof = False then
                        begin
                            // Mudou o grupo de seção voltando uma seção
                            cdsSecoes.Prior;

                            // Pegando o próximo grupo de seções
                            li_GrupoId := cdsSecoes.FieldByName('GRUPOSECAOPROXGRUPID').AsInteger;

                            // Buscando a primeira seção do próximo grupo de componente
                            while (cdsSecoes.Locate('GRUPOSECAOID', li_GrupoId , []) = False)  and (li_GrupoId > 0) do
                            begin
                                // Não localizou nenhuma seção que tenha o próximo grupoid
                                // Buscamos o próximo grupo id do componente que deveria ter sido selecionado
                                if dm.cdsSecoes.Locate('GRUPOSECAOID', li_GrupoId , []) then
                                begin
                                    li_GrupoId := dm.cdsSecoes.FieldByName('GRUPOSECAOPROXGRUPID').AsInteger;
                                end
                                else
                                begin
                                    li_GrupoId := 0;
                                end;
                            end;

                            if (li_GrupoId > 0) then
                            begin
                                // Localizou a próxima seção de sequencia de componente,
                                // verificando se iremos inserir o giro aqui
                                if li_QtdeBaixa = 0 then
                                begin
                                    // Marcamos que a seção não pode ter giro
                                    cdsSecoes.Edit;
                                    cdsSecoes.FieldByName('GIRO').AsInteger := -1;
                                    cdsSecoes.Post;
                                end
                                else
                                begin
                                    if (cdsSecoes.FieldByName('GIRO').AsInteger >= li_QtdeBaixa) then
                                    begin
                                        cdsSecoes.Edit;
                                        cdsSecoes.FieldByName('GIRO').AsInteger := li_QtdeBaixa;
                                        cdsSecoes.Post;
                                    end;
                                end;
                            end;
                        end;

                        // Voltando para a última seção processada
                        cdsSecoes.RecNo := li_NReg;
                        cdsSecoes.Next;
                    end;

                    // Incluindo as seções que possuem giro na cdstemporária
                    cdsSecoes.First;

                    while not (cdsSecoes.Eof) do
                    begin
                        if cdsSecoes.FieldByName('GIRO').AsInteger > 0 then
                        begin
                            dm.cdsGiro.Append;
                            dm.cdsGiro.FieldByName('FICHA').AsInteger := li_Ficha;
                            dm.cdsGiro.FieldByName('SECAO').AsString  := cdsSecoes.FieldByName('SECAO').AsString;
                            dm.cdsGiro.FieldByName('GIRO').AsInteger  := cdsSecoes.FieldByName('GIRO').AsInteger;
                            dm.cdsGiro.FieldByName('FICHA_SECAO').AsString := IntToStr(li_Ficha) + '_' +
                                                                              cdsSecoes.FieldByName('SECAO').AsString;
                            dm.cdsGiro.FieldByName('GRUPOSECAOID').AsInteger := cdsSecoes.FieldByName('GRUPOSECAOID').AsInteger;
                            dm.cdsGiro.Post;
                        end;

                        if cdsSecoes.FieldByName('GIRO').AsInteger = -1 then
                        begin
                            // Incluimos um giro como seção 00 para indicar que não chegou neste componente
                            dm.cdsGiro.Append;
                            dm.cdsGiro.FieldByName('FICHA').AsInteger := li_Ficha;
                            dm.cdsGiro.FieldByName('SECAO').AsString  := '00';
                            dm.cdsGiro.FieldByName('GIRO').AsInteger  := 0;
                            dm.cdsGiro.FieldByName('FICHA_SECAO').AsString := IntToStr(li_Ficha) + '_00';
                            dm.cdsGiro.FieldByName('GRUPOSECAOID').AsInteger := cdsSecoes.FieldByName('GRUPOSECAOID').AsInteger;
                            dm.cdsGiro.Post;
                        end;

                        cdsSecoes.Next;
                    end;
                end;
            finally
                cdsSecoes.Close;
                cdsSecoes.Free;
            end;
        end;
    finally
        qryFichaSecoes.Close;
        qryFichaSecoes.Destroy;
    end;
{40}getTimeProcess('', 'Full', 'f', 40, 0); //###############
{exportar arquivo}getTimeProcess('__AddFichaPlanoGiro (function)', '', 'e', 31, 40); //###############
end;

// Função que devolve em qual seção está o giro referente ao componente
function getSecaoGiro(Ficha: Integer; GrupoSecaoId: Integer): String;
begin
    if gb_GiroHabilitado = False then
    begin
        Result := '--';
        Exit;
    end;

    // Buscando se a ficha já tem o giro processado
    while True do
    begin
        if dm.cdsGiro.Locate('FICHA;GRUPOSECAOID',VarArrayOf([Ficha,GrupoSecaoId]),[]) then
        begin
            // Se localizou retornamos o valor
            Result := dm.cdsGiro.FieldByName('SECAO').AsString;
            break;
        end
        else
        begin
            // Verificando se a ficha já foi processada
            if dm.cdsGiro.Locate('FICHA',Ficha,[]) then
            begin
                // Ficha foi processada porém não possui giro no grupo de seção solicitado
                Result := '';
                break;
            end
            else
            begin
                // Ficha não processada, vamos realizar o giro da mesma
                if AddFichaPlanoGiro(Ficha, '') = False then
                begin
                    Break;
                end;
            end;
        end;
    end;
end;

{ TSecaoGiro }
constructor TSecaoGiro.Create(SecaoGiro: string; QtdeGiro: Integer);
begin
  FSecaoGiro := SecaoGiro;
  FQtdeGiro := QtdeGiro;
end;


function getFichaGiro(Ficha: Integer; GrupoSecaoId: Integer): TSecaoGiro;
begin
    if gb_GiroHabilitado = False then
    begin
        Result := TSecaoGiro.Create('--', 0);
        Exit;
    end;

{30}getTimeProcess('', 'While', 'i', 30, 0); //###############
    // Buscando se a ficha já tem o giro processado
    while True do
    begin
        if dm.cdsGiro.Locate('FICHA;GRUPOSECAOID',VarArrayOf([Ficha,GrupoSecaoId]),[]) then
        begin
{------- 26}getTimeProcess('', 'FICHA;GRUPOSECAOID', 'i', 26, 0); //###############
            // Se localizou retornamos o valor
            Result := TSecaoGiro.Create(dm.cdsGiro.FieldByName('SECAO').AsString,
                                        dm.cdsGiro.FieldByName('GIRO').AsInteger);
            break;
{------- 26}getTimeProcess('', 'FICHA;GRUPOSECAOID', 'a', 26, 0); //###############
        end
        else
        begin
            // Verificando se a ficha já foi processada
            if dm.cdsGiro.Locate('FICHA',Ficha,[]) then
            begin
{----------- 28}getTimeProcess('', 'FICHA', 'i', 28, 0); //###############
                // Ficha foi processada porém não possui giro no grupo de seção solicitado
                Result := TSecaoGiro.Create('', 0);
                break;
{----------- 28}getTimeProcess('', 'FICHA', 'a', 28, 0); //###############
            end
            else
            begin
{------- 29}getTimeProcess('', 'FICHA', 'i', 29, 0); //###############
                // Ficha não processada, vamos realizar o giro da mesma
                if AddFichaPlanoGiro(Ficha, '') = False then
                begin
                    Break;
                end;
{------- 29}getTimeProcess('', 'FICHA', 'a', 29, 0); //###############
            end;
        end;
    end;
{30}getTimeProcess('', 'While', 'f', 30, 0); //###############
{exportar arquivo}getTimeProcess('__getFichaGiro (function)', '', 'e', 26, 30); //###############
end;
destructor TSecaoGiro.destroy;
begin
  // Não sei o que programar aqui
end;

//#################################################################################################################
//#################################################################################################################
//  AQUI COMEÇAM AS FUNÇÕES CRIADAS POR ANDERSON ROSA
//#################################################################################################################
//#################################################################################################################

function LoadMessage(vfTituloJan, vfTituloMen, vfMensagem, vfIcone, vfButton, vfNameLink, vfLink: string): boolean;
begin
    // se a janela já estiver aberta sai da função
    if Assigned(frmMessage) then
        Exit;

    // define o resultado inicial
    Result := False;

    // cria a janela
    frmMessage := TfrmMessage.Create(nil);

    // acrescenta espaçamento na variavel
    frmMessage.vTituloJan := vfTituloJan;
    frmMessage.vTituloMen := vfTituloMen;
    frmMessage.vMenssagem := vfMensagem;
    frmMessage.vIcone     := vfIcone;
    frmMessage.vButton    := vfButton;
    frmMessage.vNameLink  := vfNameLink;
    frmMessage.vLink      := vfLink;

    // abre a janela sobre todas
    frmMessage.ShowModal;

    // define o resultado final
    Result := frmMessage.rMessage;
end;

procedure execPath(vpOperator, vpURL: PWideChar);
begin
    // abre o navegador com a url informada
    ShellExecute(Application.Handle, vpOperator, vpURL, nil, nil, SW_SHOWMAXIMIZED);
end;

function SingleResult(vfConnection: TzConnection; vfReturnField, vfTable, vfFilterField, vfOperator, vfValue, vfWhere, vfOrder: string): string;
var
    vASpos: Integer;
begin
    // zera var
    Result := '';

    // verifica se o campo de resultado foi renomeado
    vASpos := Pos(' AS ', vfReturnField) + 4;

    try
        // cria a query
        qryAuxiliar := TZQuery.Create(nil);

        // define a conecção
        qryAuxiliar.Connection := vfConnection;

        // insere a pesquisa (ATENÇÃO: a pesquisa só pode trazer um resultado)
        qryAuxiliar.SQL.Add('SELECT             ');
        qryAuxiliar.SQL.Add(      vfReturnField  ); // campo retornado
        qryAuxiliar.SQL.Add('  FROM             ');
        qryAuxiliar.SQL.Add(      vfTable        ); // tabela

        // se os campos de filtro estiverem preenchidos
        if (vfWhere <> '') or ((vfFilterField <> '') and (vfValue <> '')) then
        begin
            qryAuxiliar.SQL.Add(' WHERE ');

            // se vfWhere esiver preenchido
            if vfWhere <> '' then
            begin
                qryAuxiliar.SQL.Add(vfWhere); // where mais implementado
            end
            else
            begin
                //se o poerador não estiver preenchido
                if vfOperator = '' then
                    vfOperator := '='; // usa o "igual" como operador padrão

                qryAuxiliar.SQL.Add(vfFilterField     ); // campo pesquisado
                qryAuxiliar.SQL.Add(vfOperator        ); //
                qryAuxiliar.SQL.Add(QuotedStr(vfValue)); // valor
            end;
        end;

        if vfOrder <> '' then
        begin
            //
            qryAuxiliar.SQL.Add(' ORDER BY ');
            qryAuxiliar.SQL.Add(vfOrder);
        end;

        // faz a pesquisa
        qryAuxiliar.Open;

        // se o valor da var for maior que 4
        if vASpos > 4 then
            vfReturnField := Copy(vfReturnField, vASpos, Length(vfReturnField)); // pega o nome do campo

        // se a query não estiver vazia
        if not qryAuxiliar.IsEmpty then
            Result := qryAuxiliar.FieldByName(vfReturnField).AsString; // coleta o resultado
    finally
        qryAuxiliar.Close; // fecha a query
        qryAuxiliar.Free;  // descarrega a query
    end;
end;

function SingleUpdate(vfConnection: TzConnection; vfUpdateField, vfUpdateValue, vfTable, vfSearchField, vfOperator, vfSearchValue, vfWhere, vfOrder: string): Boolean;
begin
    //
    Result := True;

    try
        try
            // cria a query
            qryAuxiliar := TZQuery.Create(nil);

            // define a conecção
            qryAuxiliar.Connection := vfConnection;

            // insere a atualização (ATENÇÃO: a atualziação só pode atualziar um campo)
            qryAuxiliar.SQL.Add(' UPDATE ' +       vfTable + ' SET ' );
            qryAuxiliar.SQL.Add(             vfUpdateField + ' =   ' );
            qryAuxiliar.SQL.Add(   QuotedStr(vfUpdateValue)          );
            qryAuxiliar.SQL.Add('  WHERE ' + vfSearchField           );
            qryAuxiliar.SQL.Add(                vfOperator           );
            qryAuxiliar.SQL.Add(             vfSearchValue           );
            qryAuxiliar.ExecSQL; // executa
        finally
            qryAuxiliar.Close; // fecha a query
            qryAuxiliar.Free;  // descarrega a query
        end;
    except
        Result := False;
    end;
end;

function NameCase(vfName: string): string;
const
    vIgnore: array[0..5] of string = (' da ', ' de ', ' do ', ' das ', ' dos ', ' e ');
var
    vLength, vJob: Integer;
    vLocal: byte;
begin
    Result  := AnsiLowerCase(vfName);
    vLength := Length(Result);

    for vJob := 1 to vLength do
        // Se é a primeira letra ou se o caracter anterior é um espaço
        if (vJob = 1) or ((vJob > 1) and (Result[vJob - 1] = Chr(32))) then
            Result[vJob] := AnsiUpperCase(Result[vJob])[1];

    for vLocal := 0 to Length(vIgnore) - 1 do
        Result := StringReplace(Result, vIgnore[vLocal], vIgnore[vLocal],[rfReplaceAll, rfIgnoreCase]);
end;

function LoadBallon(vfLeft, vfTop: Integer; vfPosition, vfMessage: string): boolean;
begin
    // se a janela já estiver aberta sai da função
    if Assigned(frmBalloon) then
        Exit;

    // define o resultado inicial
    Result := False;

    // cria a janela
    frmBalloon := TfrmBalloon.Create(nil);

    // acrescenta espaçamento na variavel
    frmBalloon.Left                  := vfLeft;
    frmBalloon.Top                   := vfTop;
    frmBalloon.lblMessage.Caption    := vfMessage;
    frmBalloon.lblMessage.Font.Color := sysColorEmpresaPri;

    // seleciona o balão correspondente
    if vfPosition <> '' then
        frmBalloon.imgBalloon.Picture.LoadFromFile(exePathRequest + '\images\balloon\_' + vfPosition + '.png'); // exibe a imagem correspondente

    // abre a janela sobre todas
    frmBalloon.Show;

    // define o resultado final
//    Result := frmBalloon.rMessage;
end;

function FormatDocs(vfDoc: string):string;
begin
    // Remove espaços em branco em qualquer lugar da string
    vfDoc := StringReplace(vfDoc, ' ', '', [rfReplaceAll]);

    // Verifica o comprimento do documento
    if Length(vfDoc) = 14 then // CNPJ
    begin
        // 41.735.280/0001-63
        Result := Copy(vfDoc, 1, 2) + '.' +
                  Copy(vfDoc, 3, 3) + '.' +
                  Copy(vfDoc, 6, 3) + '/' +
                  Copy(vfDoc, 9, 4) + '-' +
                  Copy(vfDoc, 13, 2);
    end
    else if Length(vfDoc) = 11 then // CPF
    begin
        // 265.194.348-76
        Result := Copy(vfDoc, 1, 3) + '.' +
                  Copy(vfDoc, 4, 3) + '.' +
                  Copy(vfDoc, 7, 3) + '-' +
                  Copy(vfDoc, 10, 2);
    end
    else
    begin
        // Documento inválido
        Result := '';
    end;
end;

function LoadPopUp(vfMessage: string): boolean;
begin
    //
end;

procedure RequiredField(vpForm : TForm);
var
    vI: integer;
begin
    // passa por todos os componentes do form
    for vI := 0 to vpForm.ComponentCount - 1 do
    begin
        // verifica se o campo está marcado
        if vpForm.Components[vI].Tag = 795400 then
        begin
            // verifica se é um campo edit
            if vpForm.Components[vI] is TEdit then
            begin
                // verifica se o hint do TEdit está preenchido
                if ((vpForm.Components[vI] as TEdit).Hint <> '') and
                    ((vpForm.Components[vI] as TEdit).Text = '')  then
                begin
                    // mostra a mensagem
                    LoadMessage({título da janela}    'Entrada Inválida',
                                {título da mensagem}  'Campo vazio',
                                {mensagem ao usuário} 'Campo de preenchimento obrigatório!' + sLineBreak + sLineBreak +
                                                      '[' + (vpForm.Components[vI] as TEdit).Hint + ']',
                                {caminho do ícone}    'exclamation', {check/error/question/exclamation}
                                {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                                {nome do link}        '',
                                {link}                ''
                               );
                    // envia o cursor para o campo
                    (vpForm.Components[vI] as TEdit).SetFocus;

                    // encerra o processo
                    Abort;
                end;
            end;
        end;
    end;
end;

function lineBreak(vfText, vfCaption: string; vfLineLength :Integer): string;
var
    vNoChar : Integer;
    vCutLine: string;
begin
    // inicializa as variáveis
    vCutLine := Trim(vfText);
    Result   := '';

    // conta quantos caracteres
    vNoChar := Length(vfText);

    // repete o laço enquanto o qtd de caracteres for maior que o tamanho da linha
    while vNoChar > (vfLineLength - Length(vfCaption)) do
    begin
        // separa a primeira linha
        vCutLine := vfCaption + Trim(Copy(vfText, 1, (vfLineLength - Length(vfCaption))));

        // remove a primeira parte da frase
        vfText := Trim(Copy(vfText, (Length(vCutLine) - Length(vfCaption)) + 1, Length(vfText)));

        // conta quantos caracteres
        vNoChar :=  Length(vfText);

        // limpa a variável
        vfCaption := '';

        // verifica se está vazio
        if Result = '' then
            Result := vCutLine // insere a primeira parte
        else
            Result := Result + sLineBreak + vCutLine; // insere proxima parte
    end;

    // verifica se está vazio
    if Result = '' then
        Result := vfCaption + vCutLine // insere o caption e o text
    else
        Result := Result + sLineBreak +
                  Trim(Copy(vfText, 1, (vfLineLength - Length(vfCaption)))); // define o resultado inserindo a ultima parte
end;

function ValidateMail(vfMail: string):Boolean;
var
    vArroba: integer;
    vString: string;
begin
    // inicializa as variaveis
    Result  := True;
    vfMail  := Trim(vfMail);
    vString := vfMail;
    vArroba := 0;

    // vefica se está vazio
    if vfMail = '' then Exit;

    // verifica se tem o simbolo '@' e quantos tem
    while (Pos('@',vString) > 0) do
    begin
        vArroba := vArroba + 1; // conta quantas vezes encontrou o '@'
        vString := Copy(vString, (Pos('@', vString )+ 1), Length(vString)); // remove a primeira parte da string até o '@'
    end;

    if (Pos(' ', vfMail) > 0) or // verifica se tem espaço
           (Pos('.', vfMail) = 0) or // verifica se tem ponto
               (vArroba <> 1) then // verifica se tem arroba
        Result := False; // define o resultado como negativo
end;

function ValidateCel(vfCell: string):Boolean;
begin
    // inicializa o resultado
    Result := True;
    vfCell := Trim(vfCell);

    // vefica se está vazio
    if vfCell = '' then Exit;

    if (Pos(' ', vfCell) > 0) or // verifica se tem espaço
           (Length(vfCell) <> gcCelLength) then // verifica se tem a quantidade de numeros correta
        Result := False; // define o resultado como negativo
end;

function ValidatePass(vfPass: string):Boolean;
begin
    // inicializa o resultado
    Result := False;
    vfPass := Trim(vfPass);

    // vefica se está vazio
    if vfPass = '' then Exit;

    // vefica se o minimo de caracteres foi digitado
    if Length(vfPass) < 5 then Exit;

    // define o resultado
    Result := True;
end;

function sysUpdatingCheck():Boolean;
begin
    // consulta o banco de dados
    Result := (SingleResult(dm.ConnSimp, 'CFG_STANDBY', 'TBLCONFIG', 'CFG_STANDBY', '=', '1', '', '') = '1');
end;

function OnlyBusinessDay(vfStartDate: TDateTime): TDateTime;
var
    DayOfWeek: Integer;
begin
    Result    := vfStartDate; // data inicial
    DayOfWeek := DayOfTheWeek(Result); // Obtém o dia da semana da data

    // verifica em que dia cai o dia final e acrecenta o necessário
    if (DayOfWeek = 1) or (DayOfWeek = 6) or (DayOfWeek = 7) then
        Result := Result + 2
    else if (DayOfWeek = 2) then
        Result := Result + 1;
end;

function MessagePopUp(vfTitulo, vfDescricao: string): string;
var
    vTSize, vMSize, vInicio: Integer;
    vSepara, vRetIni, vRetFin :string;
begin
    // remove espaços do inicio e do final
    vfTitulo    := Trim(vfTitulo);
    vfDescricao := Trim(vfDescricao);

    // calcula o ponto inicial
    vInicio := 1;

    //
    vSepara := '-----';
    vRetIni := '';
    vRetFin := '...';

    // guarda o tamanho na variavel
    vTSize := Length(vfTitulo);
    vMSize := Length(vfDescricao);

    // verifica o tamanho total da string
    if (vTSize + vMSize) > 180 then
        vfDescricao := Copy(vfDescricao, vInicio, (200 - vTSize));

    // forma o texto que será exibido
    Result := vfTitulo + sLineBreak + vSepara + sLineBreak + vRetIni + vfDescricao + vRetFin;

    // senão houver cararacter
    if (vTSize + vMSize) = 0 then
        Result := '';
end;

function FriendlyTime(vfDateTime: TDateTime): string;
var
    vMinuteA, vHourA: SmallInt;

    vTimeN, vTimeR: SmallInt;

    vDayN, vMonthN, vYearN: SmallInt;
    vDayR, vMonthR, vYearR: SmallInt;

    vHourN, vMinuteN, vSecondN: SmallInt;
    vHourR, vMinuteR, vSecondR: SmallInt;
begin
    // pega a data atual separada em dia, mes e ano
    vDayN   := StrToInt(FormatDateTime('dd'  , Now));
    vMonthN := StrToInt(FormatDateTime('mm'  , Now));
    vYearN  := StrToInt(FormatDateTime('yyyy', Now));

    // pega a data recebida separada em dia, mes e ano
    vDayR   := StrToInt(FormatDateTime('dd'  , vfDateTime));
    vMonthR := StrToInt(FormatDateTime('mm'  , vfDateTime));
    vYearR  := StrToInt(FormatDateTime('yyyy', vfDateTime));

    // pega a hora atual separada em hora, minuto e segundo
    vHourN   := StrToInt(FormatDateTime('hh', Now));
    vMinuteN := StrToInt(FormatDateTime('nn', Now));
    vSecondN := StrToInt(FormatDateTime('ss', Now));

    // pega a hora recebida separada em hora, minuto e segundo
    vHourR   := StrToInt(FormatDateTime('hh', vfDateTime));
    vMinuteR := StrToInt(FormatDateTime('nn', vfDateTime));
    vSecondR := StrToInt(FormatDateTime('ss', vfDateTime));


    // define a string de tempo inicial
    Result := FormatDateTime('d', vfDateTime) + ' de ' + FormatDateTime('mmm', vfDateTime) + ' de ' + FormatDateTime('yyyy', vfDateTime);

    // se o ano atual for igual ao ano recebido
    if vYearN = vYearR then
    begin
        // se o mes atual for igual ao mes recebido
        if vMonthN = vMonthR then
        begin
            // se o dia atual for igual ao dia recebido
            if vDayN = vDayR then
            begin
                // se a hora atual for igual a hora recebida
                if vHourN = vHourR then
                begin
                    // se o minuto atual for igual ao minuto recebido
                    if vMinuteN = vMinuteR then
                    begin
                        // mostra a string de tempo
                        Result := 'há menos de um minuto.';

                        // verifica se o tempo decorrido é menor que 10 segundos
                        if (vSecondN - vSecondR) < 10 then
                            Result := 'há pouco.' // mostra a string de tempo

                        // verifica se o tempo decorrido é menor que 20 seggundos
                        else if (vSecondN - vSecondR) < 20 then
                            Result := 'segundos atrás.'; // mostra a string de tempo
                    end
                    else
                    begin
                        // mostra a string de tempo
                        Result := 'há menos de um minuto.';

                        // define o tempo em segundos
                        vTimeN := (vMinuteN * 60) + vSecondN;
                        vTimeR := (vMinuteR * 60) + vSecondR;

                        // calcula o tempo passado
                        vMinuteA := Trunc((vTimeN - vTimeR) / 60);

                        // verifica se o tempo decorrido é igual a 1 minuto
                        if vMinuteA = 1 then
                            Result := 'um minuto atrás.' // mostra a string de tempo

                        // verifica se o tempo decorrido é maior que 1 minuto
                        else if vMinuteA > 1 then
                            Result := IntToStr(vMinuteA) + ' minutos atrás.'; // mostra a string de tempo
                    end;
                end
                else
                begin
                    // define o tempo em segundos
                    vTimeN := (vHourN * 60) + vMinuteN;
                    vTimeR := (vHourR * 60) + vMinuteR;

                    // calcula o tempo passado
                    vHourA := vTimeN - vTimeR;

                    // verifica se o tempo passado é menor que 1 hora
                    if vHourA < 60 then
                    begin
                        // define o tempo passado
                        vMinuteA := vHourA;

                        // verifica se o tempo decorrido é igual a 1 minuto
                        if vMinuteA = 1 then
                            Result := 'um minuto atrás.' // mostra a string de tempo

                        // verifica se o tempo decorrido é maior que 1 minuto
                        else if vMinuteA > 1 then
                            Result := IntToStr(vMinuteA) + ' minutos atrás.'; // mostra a string de tempo
                    end

                    // verifica se o tempo decorrido é igual a 60 minutos
                    else if vHourA = 60 then
                    begin
                        Result := 'uma hora atrás.'; // mostra a string de tempo
                    end

                    // verifica se o tempo passado é maior que 60 minutos
                    else if vHourA > 60 then
                    begin
                        // calcula o tempo em hora
                        vHourA := Trunc(vHourA / 60);

                        // mostra a string de tempo
                        Result := 'uma hora atrás.';

                        // verifica se o tempo decorrido é maior q 1 hora
                        if vHourA > 1 then
                            Result := IntToStr(vHourA) + ' horas atrás.';// mostra a string de tempo
                    end;
                end;
            end;
        end;
    end;
end;

function getOrder(vfBO: Integer): Integer;
begin
    // inicializa a var
    Result := 0;

    try
        qryAuxiliar            := TZQuery.Create(nil); // cria a query
        qryAuxiliar.Connection := dm.ConnSimp; // define a conecção

        // insere o sql
        qryAuxiliar.SQL.Add(' SELECT COUNT(BOL_ID)   ');
        qryAuxiliar.SQL.Add('   FROM TBLBOLOG        ');
        qryAuxiliar.SQL.Add('  WHERE BOL_BO = :BOL_BO');

        qryAuxiliar.ParamByName('BOL_BO').AsInteger := vfBO; // passa o parametro da pesquisa
        qryAuxiliar.Open; // abre a query
    finally
        Result := (qryAuxiliar.FieldByName('COUNT').AsInteger + 1); // incrementa a ordenação
        qryAuxiliar.Close; // fecha a query
        qryAuxiliar.Free;  // descarrega a query
    end;
end;

function ISpace(vfFields, vfPos: string; vfChar: Char; vfSize: Integer): string;
begin
    // verifica a posição onde será criado os espaços
    if vfPos = UpperCase('L') then
        Result := StringOfChar(vfChar, (vfSize) - Length(vfFields)) + vfFields // cria a string com espaços à esquerda
    else
        Result := vfFields + StringOfChar(vfChar, (vfSize) - Length(vfFields)); // cria a string com espaçoa à direita
end;

function getTimeProcess(vfNome, vfLocal, vfCiclo: string; vfArray, vfArrayE: SmallInt): Double;
    // vfNome    : nome do arquivo .txt
    // vfLocal   : local onde está sendo calculado
    // vfCliclo  : I => Inicio, F => Final, A => Acumulada, E=> Encerramento
    // vfArray   : índice do array
    // vfArrayE  : ultimo indice da lista referente ao local calculado
var
    I    : Integer;
    //vText: array[1..255] of TStringList;
    vList: TStringList;
    vDesc: string;
begin
    // se não for contar o tempo sai
    if not(dm.pvGetTime) then Exit;

    // inicializa a variável
    Result := 0;

    // se for um cliclo final de encerramento
    if UpperCase(vfCiclo) = 'E' then
    begin
        try
            // cria o obejto
            vList := TStringList.Create;
            //vText[1] := TStringList.Create;

            // passa por todos os índices
            for I := vfArray to vfArrayE do
            begin
                // verifica se o nome atual está vazio
                if not(vLocal[I].IsEmpty) then
                begin
                    // formata a descrição
                    vDesc := vLocal[I] + StringOfChar('.', 35 - Length(vLocal[I])) + ': ';

                    // verifica se o valor atual está vazio
                    if vTimeTotal[I] = 0 then
                    begin
                        // adicioa os campos na lista
                        vList.Add(vDesc + FloatToStr(vTime[I]/1000) + 's');
                        //vText[1].Add(vDesc + FloatToStr(vTime[I]/1000) + 's');
                    end
                    else
                    begin
                        // adicioa os campos na lista
                        vList.Add(vDesc + FloatToStr(vTimeTotal[I]/1000) + 's');
                        //vText[1].Add(vDesc + FloatToStr(vTimeTotal[I]/1000) + 's');
                    end;

                    // limpa os dados
                    vLocal[I]     := '';
                    vTime[I]      := 0 ;
                    vTimeTotal[I] := 0 ;
                end
                else
                begin
                    //
                    //Break;
                end;
            end;

            // salva o arquivo com os dados
            txtExport(vfNome, '', vList.Text);
            //txtExport(vfNome, '', vText[1].Text);
        finally
            // descarrega o objeto
            vList.Free;
        end;
    end
    else
    begin
        // seta o nome no array
        if vfLocal <> '' then
            vLocal[vfArray] := vfLocal;

        // se for um ciclo inicial
        if UpperCase(vfCiclo) = 'I' then
        begin
            // pega o tempo
            vTime[vfArray] := GetTickCount;
            vTimeTotal[vfArray] := 0;
        end
        // se for um ciclo final simples
        else if UpperCase(vfCiclo) = 'F' then
        begin
            // calcula o intervalo
            vTime[vfArray] := GetTickCount - vTime[vfArray];
        end
        // se for um ciclo final cumulativo
        else if UpperCase(vfCiclo) = 'A' then
        begin
            // calcula o intervalo
            vTime[vfArray] := GetTickCount - vTime[vfArray];

            // calcula o intervalo acumulado
            vTimeTotal[vfArray] := vTimeTotal[vfArray] + vTime[vfArray];
        end;
    end;

    // define o resultado final
    Result := vTime[vfArray];
end;

procedure txtExport(vpArqName, vpLineDesc, vpText: string);
var
    vFile: TextFile;
begin
    // define o caminho e o nome do arquivo
    vpArqName := ChangeFileExt(ParamStr(0), '_' + vpArqName + '.log');

    // cria o arquivo na memória
    AssignFile(vFile, vpArqName);

    // verifica se o arquivo existe
    if FileExists(vpArqName) then
        Append(vFile) // abre o arquivo
    else
        Rewrite(vFile); // cria e abre o arquivo

    // grava os dados no arquivo
    Writeln(vFile, vpLineDesc + vpText);
    Writeln(vFile, StringOfChar('=', 45) + sLineBreak);

    // fecha o arquivo
    CloseFile(vFile);
end;

procedure AddMensagemBO(vpCodReg, vpCodOri, vpCodDes, vpCodAlt: Integer;
                        vpDesT01, vpDesT02, vpDesT03, vpDtPrev, vpType: string);
var
    vNOrigem, vNDestino, vNAlternativo, vBody, vReferencial: string;
    qryMem: TZQuery;
begin


Exit;

    try
        qryMem := TZQuery.Create(nil); // cria a query

        with qryMem do
        begin
            Connection := dm.ConnSimp; // define o bando de dados

            SQL.Clear; // limpa a query
            Close;     // fecha a query

            // seleciona o usuario de origem
            vNOrigem      := SingleResult(dm.ConnSimp,  'USU_NSOCIAL',
                                         'TBLUSUARIOS', 'USU_ID', '=',
                                          IntToStr(vpCodOri),  '', '');

            // seleciona o usuario de destino
            vNDestino     := SingleResult(dm.ConnSimp,  'USU_NSOCIAL',
                                         'TBLUSUARIOS', 'USU_ID', '=',
                                          IntToStr(vpCodDes),  '', '');

            // seleciona o usuario alternativo
            vNAlternativo := SingleResult(dm.ConnSimp,  'USU_NSOCIAL',
                                         'TBLUSUARIOS', 'USU_ID', '=',
                                          IntToStr(vpCodAlt),  '', '');

            // Define o referencial originando-se do BO
            vReferencial := 'BO_' + IntToStr(vpCodReg);

            // cria o corpo da mensgem
            if vpType = 'N' then // corpo para cadastro de BO
                vBody := 'Olá ' + vNDestino + ', você foi indicado por ' + vNOrigem +
                         ' para resolver o BO nº ' + IntToStr(vpCodReg) + '.' + sLineBreak + sLineBreak +

                         '*' + vpDesT01 + '*' + sLineBreak +
                         vpDesT02 + sLineBreak + sLineBreak +

                         ISpace('','L', '=', 20) + sLineBreak +
                         'Por favor acesse o SFC para dar andamento.'
            else
            if vpType = 'A' then // corpo para BO aceito
                vBody := 'Olá ' + vNDestino + ', o BO nº ' + IntToStr(vpCodReg) +
                         ' *' + vpDesT01 + '* foi aceito por ' + vNOrigem +
                         ' com conclusão prevista para ' + vpDtPrev +
                         ' e tem  a seguinte informação:' + sLineBreak + sLineBreak +

                         vpDesT03 + sLineBreak + sLineBreak +

                         ISpace('','L', '=', 20) + sLineBreak +
                         'Se preferir acesse o SFC para ver os detalhes.'
            else
            if vpType = 'E' then // corpo para BO encaminhado para o novo destinatário
                vBody := 'Olá ' + vNDestino + ', ' + vNOrigem  +
                         ' encaminhou para você o BO nº ' +
                          IntToStr(vpCodReg) + '.' + sLineBreak + sLineBreak +

                         '*' + vpDesT01 + '*' + sLineBreak +
                          vpDesT02 + sLineBreak + sLineBreak +

                         ISpace('','L', '=', 20) + sLineBreak +
                         'Por favor acesse o SFC para dar andamento.'
            else
            if vpType = 'EC' then // corpo para BO encaminhado para avisar o criador do BO
                vBody := 'Olá ' + vNDestino + ', ' + vNOrigem  +
                         ' encaminhou o BO nº ' + IntToStr(vpCodReg) +
                         ' para ' + vNAlternativo + '.' + sLineBreak + sLineBreak +

                         '*' + vpDesT01 + '*'  + sLineBreak +
                          vpDesT02 + sLineBreak + sLineBreak +

                         ISpace('','L', '=', 20) + sLineBreak +
                         'Se preferir acesse o SFC para ver os detalhes.'
            else
            if vpType = 'F' then // corpo para BO finalizado
                vBody := 'Olá ' + vNDestino + ', ' + vNOrigem +
                         ' finalizou o BO nº ' + IntToStr(vpCodReg) + '.' +  sLineBreak + sLineBreak +

                         vpDesT03 + sLineBreak + sLineBreak +

                         ISpace('','L', '=', 20) + sLineBreak +
                         'Se preferir acesse o SFC para ver os detalhes.'
            else
            if vpType = 'C' then // corpo para BO cancelado
                vBody := 'Olá ' + vNDestino + ', ' + vNOrigem  +
                         ' cancelou o BO nº ' + IntToStr(vpCodReg) + '.' +  sLineBreak + sLineBreak +

                         vpDesT03 + sLineBreak + sLineBreak +

                         ISpace('','L', '=', 20) + sLineBreak +
                         'Por favor acesse o SFC para dar andamento.'
            else
            if vpType = 'NE' then // corpo para nova entrada de comentários no BO
                vBody := 'Olá ' + vNDestino + ', ' + vNOrigem +
                         ' adicionou um novo comentário ao BO nº ' + IntToStr(vpCodReg) +
                         ' e marcou para que você fosse notificado.' + sLineBreak + sLineBreak +

                         vpDesT03 + sLineBreak + sLineBreak +

                         ISpace('','L', '=', 20) + sLineBreak +
                         'Se preferir acesse o SFC para ver os detalhes.'
            else
            if vpType = 'AAC' then // corpo para BO ativado de forma automatica (ao criador)
                vBody := 'Olá ' + vNDestino + ', por falta de ação o BO nº ' + IntToStr(vpCodReg) +
                         ' foi automaticamente designado para ' + vNOrigem + sLineBreak + sLineBreak +

                         ISpace('','L', '=', 20) + sLineBreak +
                         'Para acompanhar o progresso por favor acesse o SFC.'
            else
            if vpType = 'AAD' then // corpo para BO ativado de forma automatica (ao destinatario)
                vBody := 'Olá ' + vNDestino + ', por falta de ação o BO nº ' + IntToStr(vpCodReg) +
                         ' foi automaticamente designado a você.' + sLineBreak + sLineBreak +

                         ISpace('','L', '=', 20) + sLineBreak +
                         'Por favor acesse o SFC para dar andamento.'
            else
            if vpType = 'IU' then // corpo para cadastro de usuário
            begin
                vBody := 'Olá ' + vNDestino + ', seja bem vindo(a) ao SFC, sistema ' +
                         'de controle eficiente e dinâmico de produção.' + sLineBreak + sLineBreak +
                         'Agora que você já tem um cadastro pode acessar o sistema, ' +
                         'para isso use os seguintes dados.' + sLineBreak + sLineBreak +

                         ' - Usuário: ' + vpDesT01 + sLineBreak +
                         ' - Senha..: ' + vpDesT02 + sLineBreak;

                //
                if Trim(vpDesT03) <> '' then
                    vBody := vBody + ' - Frase para Recuperação de Senha: ' + vpDesT03 + sLineBreak;

                //
                vBody := vBody + sLineBreak +

                         'Quando acessar o sistema pela primeira vez será solicitado ' +
                         'que informe uma senha pessoal definitiva, essa senha não deverá ' +
                         'ser passada a nenhuma outra pessoa.' + sLineBreak + sLineBreak +

                         'Nós da Simplim estamos felizes em ter você conosco.' + sLineBreak + sLineBreak +

                         ISpace('','L', '=', 20) + sLineBreak +

                         '* Essas mensagens do sistema não precisam ser respondidas pois ' +
                         'são enviadas por um robô que ainda não possui capacidade de ' +
                         'interação com o usuário.';

                //
                vReferencial := 'USU_' + IntToStr(vpCodReg);
            end
            else
            if vpType = 'RS' then // corpo para recuperação de senha de usuário
            begin
                vBody := 'Olá ' + vNDestino + ', seja bem vindo(a) ao SFC, sistema ' +
                         'de controle eficiente e dinâmico de produção.' + sLineBreak + sLineBreak +
                         'Agora que você já tem um cadastro pode acessar o sistema, ' +
                         'para isso use os seguintes dados.' + sLineBreak + sLineBreak +

                         ' - Usuário: ' + vpDesT02 + sLineBreak +
                         ' - Senha..: ' + vpDesT03 + sLineBreak + sLineBreak +

                         'Quando acessar o sistema pela primeira vez será solicitado ' +
                         'que informe uma senha pessoal definitiva, essa senha não deverá ' +
                         'ser passada a nenhuma outra pessoa.' + sLineBreak + sLineBreak +

                         'Nós da Simplim estamos felizes em ter você conosco.' + sLineBreak + sLineBreak +

                         ISpace('','L', '=', 20) + sLineBreak +

                         '* Essas mensagens do sistema não precisam ser respondidas pois ' +
                         'são enviadas por um robô que ainda não possui capacidade de ' +
                         'interação com o usuário.';

                vReferencial := 'USU_' + IntToStr(vpCodReg);
            end;

            // insere o registro no banco
            SQL.Add('  INSERT INTO TBLPOST                   ');
            SQL.Add(' ( POS_APP,  POS_CNPJ,  POS_NOME,       ');
            SQL.Add('   POS_REF,  POS_DESTINO,  POS_MENSAGEM)');
            SQL.Add('  VALUES                                ');
            SQL.Add(' (:POS_APP, :POS_CNPJ, :POS_NOME,       ');
            SQL.Add('  :POS_REF, :POS_DESTINO, :POS_MENSAGEM)');

            ParamByName('POS_APP').AsString      := AppName;      // nome do aplicativo
            ParamByName('POS_CNPJ').AsString     := dm.pbvCNPJ;   // CNPJ da empresa
            ParamByName('POS_NOME').AsString     := dm.pbvCNam;   // nome da empresa
            ParamByName('POS_REF').AsString      := vReferencial; // codigo do BO
            ParamByName('POS_DESTINO').AsInteger := vpCodDes;     // codigo do usuário destinatário
            ParamByName('POS_MENSAGEM').AsString := vBody;        // corpo da mensagem

            ExecSQL; // executa o SQL
        end;
    finally
        // descarrega o objeto
        qryMem.Free;
    end;
end;

function ValidarPhone(vfNumero: string): string;
begin
    // remove caracteres desnecessários
    vfNumero := StringReplace(vfNumero, ' ', '', [rfReplaceAll]);
    vfNumero := StringReplace(vfNumero, '-', '', [rfReplaceAll]);
    vfNumero := StringReplace(vfNumero, '(', '', [rfReplaceAll]);
    vfNumero := StringReplace(vfNumero, ')', '', [rfReplaceAll]);
    vfNumero := StringReplace(vfNumero, '.', '', [rfReplaceAll]);

    // verifica o telefone
    if Length(vfNumero) < 8 then
        vfNumero := '' // limpa a variavel
    else
    if Length(vfNumero) <= 9 then
        vfNumero := '5514' + vfNumero // adiciona pais e ddd
    else
    if Length(vfNumero) <= 11 then
        vfNumero := '55' + vfNumero; //adiciona pais

    Result := vfNumero;
end;

//###############################################################################################################
//###############################################################################################################
//###############################################################################################################
//###############################################################################################################
{
procedure postMessage;
var
    vInsert: Boolean;
    vPhone : string;
    dspGet : TDataSetProvider;
    cdsGet : TClientDataSet;
    dtsGet : TDataSource;
    qryUpd, qryAux, qryGet: TZQuery;
    qryPost: TFDQuery;
begin
    // verifica a conexão com o banco
    if not dm.DBConnect then
        Exit;

    try
        // cria os objetos
        dspGet  := TDataSetProvider.Create(nil);
        cdsGet  := TClientDataSet.Create(nil);
        dtsGet  := TDataSource.Create(nil);
        qryAux  := TZQuery.Create(nil);
        qryGet  := TZQuery.Create(nil);
        qryPost := TFDQuery.Create(nil);

        // define as conexões
        qryPost.Connection := dm.FDConnect;
        qryGet.Connection  := dm.ConnSimp;
        qryAux.Connection  := dm.ConnSimp;

        // insere o SQL
        qryGet.SQL.Add('SELECT * FROM TBLPOST WHERE POS_ENVIADO = 0');
        qryAux.SQL.Add('SELECT USU_NSOCIAL, USU_CELULAR, USU_EMAIL' );
        qryAux.SQL.Add('  FROM TBLUSUARIOS WHERE USU_ID = :USU_ID'  );

        // define as ligações
        dtsGet.DataSet := cdsGet;
        dspGet.DataSet := qryGet;
        cdsGet.SetProvider(dspGet);

        cdsGet.Close; // fecha a query
        cdsGet.Open;  // abre a query

        // passa por todos os registros
        while not cdsGet.Eof do
        begin
            // seleciona os dados do destinatario
            qryAux.Close; //
            qryAux.ParamByName('USU_ID').AsInteger := cdsGet.FieldByName('POS_DESTINO').AsInteger;
            qryAux.Open;

            // salva o conteudo na variavel
            vPhone := ValidarPhone(qryAux.FieldByName('USU_CELULAR').AsString);

            try
                // define a variavel para true
                vInsert := true;

                with qryPost do
                begin
                    // preenche os dados da query (SQL)
                    Close;
                    SQL.Clear;
                    SQL.Add('INSERT INTO tbl_registros                                                         ');
                    SQL.Add('   ( REG_ORIGEM_APP,      REG_ORIGEM_CNPJ,    REG_ORIGEM_NOME,  REG_DESTINO_NOME, ');
                    SQL.Add('     REG_DESTINO_NUMERO,  REG_DESTINO_EMAIL,  REG_MENSAGEM,     REG_ANEXO        )');
                    SQL.Add('     VALUES                                                                       ');
                    SQL.Add('   (:REG_ORIGEM_APP,     :REG_ORIGEM_CNPJ,   :REG_ORIGEM_NOME, :REG_DESTINO_NOME, ');
                    SQL.Add('    :REG_DESTINO_NUMERO, :REG_DESTINO_EMAIL, :REG_MENSAGEM,    :REG_ANEXO        )');

                    // passa os valores para os parametros
                    ParamByName('REG_ORIGEM_APP').AsString     := cdsGet.FieldByName('POS_APP').AsString;
                    ParamByName('REG_ORIGEM_CNPJ').AsString    := cdsGet.FieldByName('POS_CNPJ').AsString;
                    ParamByName('REG_ORIGEM_NOME').AsString    := cdsGet.FieldByName('POS_NOME').AsString;

                    ParamByName('REG_DESTINO_NOME').AsString   := qryAux.FieldByName('USU_NSOCIAL').AsString;
                    ParamByName('REG_DESTINO_NUMERO').AsString := vPhone;
                    ParamByName('REG_DESTINO_EMAIL').AsString  := qryAux.FieldByName('USU_EMAIL').AsString;

                    ParamByName('REG_MENSAGEM').AsString       := cdsGet.FieldByName('POS_MENSAGEM').AsString;
                    ParamByName('REG_ANEXO').AsWideString      := cdsGet.FieldByName('POS_ANEXO').AsWideString;

                    // executa o SQL
                    ExecSQL;
                end;
            except
                // define a variavel como false
                vInsert := False;
            end;

            // verifica se o registro foi adicionado
            if vInsert then
            begin
                try
                    // cria a query
                    qryUpd := TZQuery.Create(nil);

                    with qryUpd do
                    begin
                        // define a conexão
                        Connection := dm.ConnSimp;

                        // cria o sql
                        SQL.Add('UPDATE TBLPOST SET POS_ENVIADO = 1 WHERE POS_ID = ' + cdsGet.FieldByName('POS_ID').AsString);

                        // executa o sql
                        ExecSQL;
                    end;
                finally
                    // descarrega o objeto
                    qryUpd.Free;
                end;
            end;

            // move para o proximo registro
            cdsGet.Next;
        end;
    finally
        // descarrega os objetos
        dspGet.Free;
        cdsGet.Free;
        dtsGet.Free;
        qryGet.Free;
        qryPost.Free;
    end;
end;
}
//###############################################################################################################
//###############################################################################################################
//###############################################################################################################
//###############################################################################################################
end.
//##############################################################################
//##############################################################################
//##############################################################################


