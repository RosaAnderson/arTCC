unit untFunctions;

interface

uses
    Winapi.ShellAPI, Winapi.Messages, Winapi.Windows,

    System.SysUtils, System.Variants, System.Classes, System.DateUtils,

    Vcl.Graphics, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Forms,
    Vcl.Buttons,

    Data.DB,

    FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
    FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
    FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
    FireDAC.Comp.UI, FireDAC.FMXUI.Wait, FireDAC.Comp.Client, FireDAC.Stan.Param,
    FireDAC.Comp.DataSet, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,

    jpeg
    ;

    // declaração das procedures
    procedure ATime(vpHH, vpMM, vpSS: TLabel);
    procedure ToCreate(vpForm: TForm; vpTForm: TFormClass; vpParent: TComponent; vpPParent, vpPanel: TPanel);

    // decaração das functions
    function Crypto(vfStr: string): string;
    function NameCase(vfName, vfAll: string): string;
    function fullDate(vfDate: TDateTime):string;
    function showMsg(vfTituloJan, vfTituloMen, vfMensagem, vfIcone, vfButton, vfNameLink, vfLink: string): Boolean;

    function formatDocs(vfDoc: string): string;
    function removeChar(vfString: string): string;
    function toCurrency(vfValue: string): Currency;
    function FormatMoney(vfValor: Currency): string;





  var
    qryAuxFunc: TFDQuery;

implementation

uses untMessages, untDBConnect, untSource;

//##############################################################################
//### Procedures ###############################################################
//##############################################################################
procedure ATime(vpHH, vpMM, vpSS: TLabel);
begin
    vpHH.Caption := FormatDateTime('hh', Now);
    vpMM.Caption := FormatDateTime('mm', Now);
    vpSS.Caption := FormatDateTime('ss', Now);
end;

procedure ToCreate(vpForm: TForm; vpTForm: TFormClass; vpParent: TComponent; vpPParent, vpPanel: TPanel);
begin
    if Assigned(vpPanel) then
        vpPanel.Visible := False; // fecha a dashboard

    // verifica se o form foi criado
    if not Assigned(vpForm) then
        vpForm := vpTForm.Create(vpParent); // cria o form

    if Assigned(vpPParent) then
    begin
{
        //
        vpPParent.Visible  := True;
        vpForm.Parent      := vpPParent; // define o local onde será iniciado o form
        vpForm.Align       := alLeft;       // define a posição
        vpForm.BorderStyle := bsNone;       // define a borda
}
    end;

    try
        vpForm.ShowModal; // exibe o form
    finally
        if Assigned(vpPParent) then
            vpPParent.Visible := False;

        vpForm.Free; // descarrega o objeto
    end;

    if Assigned(vpPanel) then
        vpPanel.Visible := True; // fecha a dashboard
end;

//##############################################################################
//### Functions ################################################################
//##############################################################################
function Crypto(vfStr: string): string;
var
    i: Integer;
    symbol: array [0 .. 4] of String;
begin
    // função crypto modificada por Anderson Rosa
    symbol[1] := 'ABCDEFGHIJLMNOPQRSTUVXZYWK ~!@#$%^&*()\|Ã';
    symbol[2] := 'ÂÀ©çêùÿ5Üø£úñÑªº¿®¬¼ëèïÙýÄÅÉæÆôöò»Øû×ƒÁ"Ê';
    symbol[3] := 'abcdefghijlmnopqrstuvxzywk1234567890.:ã_/';
    symbol[4] := 'àåíóÇüé¾¶§÷ÎÏ-+ÌÓß¸°¨·¹³²Õµþîì¡«½áâä¢ã_.=';

    Result := '';

    for i := 1 to Length(Trim(vfStr)) do
    begin
        if Pos(Copy(vfStr, i, 1), symbol[1]) > 0 then
            Result := Result + Copy(symbol[2], Pos(Copy(vfStr, i, 1), symbol[1]), 1)
        else
        if Pos(Copy(vfStr, i, 1), symbol[2]) > 0 then
            Result := Result + Copy(symbol[1], Pos(Copy(vfStr, i, 1), symbol[2]), 1)
        else
        if Pos(Copy(vfStr, i, 1), symbol[3]) > 0 then
            Result := Result + Copy(symbol[4], Pos(Copy(vfStr, i, 1), symbol[3]), 1)
        else
        if Pos(Copy(vfStr, i, 1), symbol[4]) > 0 then
            Result := Result + Copy(symbol[3], Pos(Copy(vfStr, i, 1), symbol[4]), 1);
    end;
end;

function fulldate(vfDate: TDateTime):string;
begin
    // formata e concatena a data nun formato amigável similar ao mostrado abaixo
    // (Domingo, 30 de março de 1989.)
    Result := NameCase(FormatDateTime('dddd, dd "de" mmmm "de" yyyy"."', vfDate), '');
end;

function NameCase(vfName, vfAll: string): string;
const
    vIgnore: array[0..5] of string = (' da ', ' de ', ' do ', ' das ', ' dos ', ' e ');
var
    vLength, vJob: Integer;
    vLocal: byte;
begin
    Result  := AnsiLowerCase(vfName);
    vLength := Length(Result);

    if not (LowerCase(vfAll) = 'y') then
        vLength := 1;

    for vJob := 1 to vLength do
        // Se é a primeira letra ou se o caracter anterior é um espaço
        if (vJob = 1) or ((vJob > 1) and (Result[vJob - 1] = Chr(32))) then
            Result[vJob] := AnsiUpperCase(Result[vJob])[1];

    for vLocal := 0 to Length(vIgnore) - 1 do
        Result := StringReplace(Result, vIgnore[vLocal], vIgnore[vLocal],[rfReplaceAll, rfIgnoreCase]);
end;

function showMsg(vfTituloJan, vfTituloMen, vfMensagem, vfIcone, vfButton, vfNameLink, vfLink: string): Boolean;
begin
    // se a janela já estiver aberta sai da função
    if Assigned(frmMessages) then
        Exit;

    // define o resultado inicial
    Result := False;

    // cria a janela
    frmMessages := TfrmMessages.Create(nil);

    // acrescenta espaçamento na variavel
    frmMessages.vTituloJan := vfTituloJan;
    frmMessages.vTituloMen := vfTituloMen;
    frmMessages.vMenssagem := vfMensagem;
    frmMessages.vIcone     := vfIcone;
    frmMessages.vButton    := vfButton;
    frmMessages.vNameLink  := vfNameLink;
    frmMessages.vLink      := vfLink;

    try
        frmMessages.ShowModal; // exibe a mensagem
    finally
        Result := frmMessages.rMessage; // define o resultado final

        frmMessages := nil;
        frmMessages.Free; // descarrega o form
    end;

    // define o resultado final
//    Result := frmMessages.rMessage;
end;

function formatDocs(vfDoc: string):string;
begin
    // limpa o resultado
    Result := '';

    // Remove espaços em branco, traços pontos e barras
    vfDoc := removeChar(vfDoc);

  // verifica se existe algum valor na variável
    if Trim(vfDoc) <> '' then
        if Length(Trim(vfDoc)) = 14 then // 41735280000163 - se for um CNPJ
        begin
            // 41.735.280/0001-63
            Result := Copy(vfDoc, 1, 2) + '.' +
                      Copy(vfDoc, 3, 3) + '.' +
                      Copy(vfDoc, 6, 3) + '/' +
                      Copy(vfDoc, 9, 4) + '-' +
                      Copy(vfDoc, 13, 2);
        end
        else
        if Length(Trim(vfDoc)) = 11 then // 26519434876 - se for um CPF
        begin
            // 265.194.348-76
            Result := Copy(vfDoc, 1, 3) + '.' +
                      Copy(vfDoc, 4, 3) + '.' +
                      Copy(vfDoc, 7, 3) + '-' +
                      Copy(vfDoc, 10, 2);
        end
        else
        if Length(Trim(vfDoc)) = 9 then
        begin
            // 99690-5500
            Result := Copy(vfDoc, 1, 5) + '-' +
                      Copy(vfDoc, 6, 4);
        end
        else
//        if Length(Trim(vfDoc)) >= 25 then
            Result := vfDoc
{
        else
            // Documento inválido
            Result := 'CPF/CNPJ ==>  D O C U M E N T O   I N V Á L I D O !';
}
end;

function removeChar(vfString: string): string;
begin
    // limpa o resultado
    Result := '';

    // Remove espaços em branco, traços pontos e barras
    vfString := StringReplace(vfString, ' ', '', [rfReplaceAll]);
    vfString := StringReplace(vfString, '.', '', [rfReplaceAll]);
    vfString := StringReplace(vfString, '-', '', [rfReplaceAll]);
    vfString := StringReplace(vfString, '/', '', [rfReplaceAll]);

    Result := vfString;
end;

function toCurrency(vfValue: string): Currency;
begin
    // define o valor inicial
    Result := 0;

    // verifica se o valor foi preenchido
    if vfValue <> '' then
        Result := StrToFloat(StringReplace(vfValue, '.', ',', [rfReplaceAll])); // converte o valor
end;

function FormatMoney(vfValor: Currency): string;
begin
    // define o resultado inicial
    Result := 'R$ 0,00';

    // verifica se o valor é diferente de zero
    if vfValor <> 0 then
    begin
        // formata o valor
        Result := 'R$ ' + FormatFloat('##,##0.00', vfValor);
        // formata o tamanho do texto
//        Result := 'R$ ' + StringOfChar(' ', 10 - Length(Result)) + Result;
    end;
end;




end.

//##############################################################################
//##############################################################################
    showMsg({janela de ogigem}    Self.Caption,
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
    function LoadBallon(vfLeft, vfTop: Integer; vfPosition, vfMessage: string): boolean;
    function LoadPopUp(vfMessage: string): boolean;
    function OnlyBusinessDay(vfStartDate: TDateTime): TDateTime;

    function SingleResult(vfConnection: TzConnection; vfReturnField, vfTable, vfFilterField, vfOperator, vfValue, vfWhere, vfOrder: string): string;
    function SingleUpdate(vfConnection: TzConnection; vfUpdateField, vfUpdateValue, vfTable, vfSearchField, vfOperator, vfSearchValue, vfWhere, vfOrder: string): Boolean;

    function NameCase(vfName: string): string;

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

unit untFunctions;

interface

uses
    Winapi.Windows, Winapi.ShellAPI, Winapi.Messages, Winapi.WinInet,

    System.SysUtils, System.Classes, System.IniFiles,

    Vcl.Forms, Vcl.StdCtrls, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Graphics,
    Vcl.ComCtrls,

    IdHTTP, //IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,

    FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
    FireDAC.Stan.Async, FireDAC.Comp.DataSet, FireDAC.Stan.Error, FireDAC.Phys.Intf,
    FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,

    Data.DB, Datasnap.DBClient, Datasnap.Provider,

    REST.Types, REST.Client, UrlMon

    ;

    function Shuffle(vfDoc, vfDat: string): string;
    function getVersionInfo(ProgamName: string): string;
    function getCoupon(vfCUP_ID: Integer; vfCUP_STATUS: string): Boolean;
    function getClient(vfCLI_ID, vfCLI_STATUS: Integer): Boolean;
    function getCampaign(vfCAM_ID, vfCAM_STATUS: Integer): Integer;
    function getCompany(vfEMP_ID, vfEMP_STATUS: Integer): Integer;

    function exePathRequest: string;
    function ReadINI(): Boolean;

    function Crypto(vfStr: string): string;
    function ValidatePhone(vfCell: string): Boolean;
    function FriendlyTime(vfDateTime: TDateTime): string;
    function toCurrency(vfValue: string): Currency;
    function FormatNumber(vfNumber: Integer): string;

    function LoadMessage(vfTituloJan, vfTituloMen, vfMensagem, vfIcone, vfButton, vfNameLink, vfLink: string): Boolean;

    function SingleResult(vfConnection: TFDConnection; vfReturnField, vfTable, vfFilterField, vfOperator, vfValue, vfWhere,  vfOrder: string): string;
    function SingleUpdate(vfConnection: TFDConnection; vfUpdateField, vfUpdateValue, vfTable, vfSearchField, vfOperator, vfSearchValue, vfWhere, vfOrder: string): Boolean;
    function FullAddress(vfEndereco, vfNumero, vfBairro, vfCEP, vfComplemento, vfCity, vfUF: string): string;
    function RequestJSON(vfURL: string): string;

    procedure RequiredField(vpForm: TForm);
    procedure SaveINI(vfValue: string);

    procedure NumericKey(Sender: TObject; var Key: Char);

    procedure getValidation;

    function getPCName(): string;
    function getHDSerial(): string;
    function getMBSerial(vfPart: Integer): string;

    function DownloadLicenca(vfOrigem, ArquivoLicenca: string): Boolean;

var

    qryAuxiliar: TFDQuery;

implementation

uses untGV, untDBConnect;

function DownloadLicenca(vfOrigem, ArquivoLicenca: string): Boolean;
var
    MS: TMemoryStream;
    cHTTP: TIdHTTP;
begin
    // Define retorno como falso.
    Result := False;

    // Cria stream em memória para armazenar os dados do arquivo.
    MS := TMemoryStream.Create;

    // cria o cliente de internet
    cHTTP := TIdHTTP.Create;

    try
        try
            // Faz o download do arquivo de licença pelo ID informado.
            cHTTP.Request.CacheControl := 'no-store';
            cHTTP.Get(vfOrigem, MS);

            // Verifica se o arquivo de licença baixado possui o tamanho correto.
            if MS.Size > 10 then
            begin
                // Adiciona localização ao arquivo de licença.
                ArquivoLicenca := ArquivoLicenca;

                // Verifica se o arquivo de licença existe, se existir, apaga.
                if FileExists(ArquivoLicenca) then DeleteFile(ArquivoLicenca);

                // Salva o arquivo de licença no disco.
                MS.SaveToFile(ArquivoLicenca);

                // Define retorno como verdadeiro.
                Result := True;
            end;
        except
        end;
    finally
        // Remove instância do stream de memória.
        MS.Free;
        cHTTP.Free;
    end;
end;

procedure getValidation;
var
    vOrigem, vDestino, vArquivo, vLicSta: string;
begin
    // pega o numero de seria do hd e da placa mae
    sysPCCode := getMBSerial(1) + '-' + getHDSerial + '-' + getMBSerial(34);

    // define o nome do arquivo
    vArquivo := getHDSerial + '-' + getMBSerial(4) + '.dll';

    // origem = site + arquivo
//    vOrigem := 'http://www.andersonrosa.com.br/sys/lic/' + vArquivo;
    vOrigem := sysLinkDownload + 'lic/' + vArquivo;

    vDestino := vArquivo; // destino + arquivo

    // faz o download do arquivo
    sysPCReleased := DownloadLicenca(vOrigem, vDestino);

    // verifica se baixou o arquivo
    if sysPCReleased then
    begin
        try
            try
                // cria a query
                qryAuxiliar := TFDQuery.Create(nil);

                with qryAuxiliar do
                begin
                    // define a conexão
                    Connection := DBConnect.FDConnection;

                    // limpa a query
                    SQL.Clear;

                    // seleciona a licença
                    SQL.Add(' UPDATE TB_LICENCAS              ');
                    SQL.Add('    SET LIC_STATUS = :LIC_STATUS ');
                    SQL.Add('  WHERE LIC_ID = :LIC_ID         ');
                    ParamByName('LIC_ID').AsString     := sysPCCode;
                    ParamByName('LIC_STATUS').AsString := Crypto(getHDSerial + '-' +
                                                                 FormatDateTime('yyyymmdd', Now) + '-' +
                                                                 getMBSerial(4));
                    ExecSQL;
                end;

                // apaga o arquivo
                DeleteFile(vDestino);
            finally
                // fecha a query
                qryAuxiliar.Close;

                // descarrega o objeto
                qryAuxiliar.Free;
            end;
        except
            //
            //ShowMessage('');
        end;
    end;
end;

function exePathRequest: string;
begin
    //
end;

function getMBSerial(vfPart: Integer):string;
var
    a, b, c, d: LongWord;
begin
    asm
        push EAX
        push EBX
        push ECX
        push EDX

        mov eax, 1
        db $0F, $A2
        mov a, EAX
        mov b, EBX
        mov c, ECX
        mov d, EDX

        pop EDX
        pop ECX
        pop EBX
        pop EAX
    end;

    // define os retornos
    if vfPart = 1 then // retorna só a parte 1
        Result := inttohex(a, 8)
    else
    if vfPart = 2 then // retorna só a parte 2
        Result := inttohex(b, 8)
    else
    if vfPart = 3 then // retorna só a parte 3
        Result := inttohex(c, 8)
    else
    if vfPart = 4 then // retorna só a parte 4
        Result := inttohex(d, 8)
    else
    if vfPart = 12 then
        Result := inttohex(a, 8) + '-' +
                  inttohex(b, 8) // retorna as parte 1 e 2
    else
    if vfPart = 34 then // retorna as partes 3 e 4
        Result := inttohex(c, 8) + '-' +
                  inttohex(d, 8)
    else
    if vfPart = 1234 then // retorna todas as partes
        Result := inttohex(a, 8) + '-' +
                  inttohex(b, 8) + '-' +
                  inttohex(c, 8) + '-' +
                  inttohex(d, 8)

{
// result original
    Result := inttohex(a, 8) + '-' +
              inttohex(b, 8) + '-' +
              inttohex(c, 8) + '-' +
              inttohex(d, 8);
}
end;

function getHDSerial(): string;
var
    DriveLetter       : string;
    NotUsed           : DWORD;
    VolumeFlags       : DWORD;
    VolumeInfo        : array[0..MAX_PATH] of AnsiChar;
    VolumeSerialNumber: DWORD;
begin
    try
        DriveLetter := GetEnvironmentVariable('SystemDrive');

        GetVolumeInformation(PChar(DriveLetter + '\'),
                                   nil,
                                   SizeOf(VolumeInfo),
                                   @VolumeSerialNumber,
                                   NotUsed,
                                   VolumeFlags,
                                   nil,
                                   0
                            );

        Result := IntToHex(VolumeSerialNumber, 8);
    except
        Result := 'A83A79R59L55';
    end;
end;

function getPCName(): string;
var
   Computer : PChar;
   CSize : DWORD;
begin
    try
        Computer := #0;
        CSize    := MAX_COMPUTERNAME_LENGTH + 1;

        try
            GetMem(Computer, CSize);

            if GetComputerName(Computer, CSize) then
                Result := Computer;
        finally
            FreeMem(Computer);
        end;
    except
        Result := '';
    end;
end;

procedure NumericKey(Sender: TObject; var Key: Char);
begin
    // Aceita somente a digitação de números.
    if not(Key in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ',', '/', #8, #13]) then
        Key := #0;
end;

function Shuffle(vfDoc, vfDat: string): string;
var
    vDat, vDoc: string;
begin
    // formata o documento com os pontos e traços
    vfDoc := FormatDocs(vfDoc);

    if Length(Trim(vfDoc)) < 25 then
    begin
        // verifica o tipo de documento
        if (Length(Trim(vfDoc)) < 15) and (Length(Trim(vfDoc)) > 0) then
            vfDoc := vfDoc + '0';

        // mistura a data com o cnpj
        Result :=          Copy(vfDoc,  1, 3) + Copy(vfDat, 1, 2);
        Result := Result + Copy(vfDoc,  4, 3) + Copy(vfDat, 3, 2);
        Result := Result + Copy(vfDoc,  7, 3) + Copy(vfDat, 5, 2);
        Result := Result + Copy(vfDoc, 10, 3) + Copy(vfDat, 7, 2);
        Result := Result + Copy(vfDoc, 13, 3) + Copy(vfDat, 9, 2);
        Result := Result + Copy(vfDoc, 16, 3);
    end
    else
    begin
        // separa o documento da data
        vDoc :=        Copy(vfDoc,  1, 3);
        vDat :=        Copy(vfDoc,  4, 2);
        vDoc := vDoc + Copy(vfDoc,  6, 3);
        vDat := vDat + Copy(vfDoc,  9, 2);
        vDoc := vDoc + Copy(vfDoc, 11, 3);
        vDat := vDat + Copy(vfDoc, 14, 2);
        vDoc := vDoc + Copy(vfDoc, 16, 3);
        vDat := vDat + Copy(vfDoc, 19, 2);
        vDoc := vDoc + Copy(vfDoc, 21, 3);
        vDat := vDat + Copy(vfDoc, 24, 2);
        vDoc := vDoc + Copy(vfDoc, 26, 3);

        // verifica o tipo de documento
        if Length(Trim(vDoc)) = 15 then
            vDoc := Copy(vDoc, 1, 14);

        // define o resultado concatenando a data e o documento
        Result := vDat + vDoc;
    end;
end;

function ReadINI(): Boolean;
var
    vDoc, vDat: string;
begin
    Result := False;

    // cria e abre o arquivo 'ini'
    sysINIFile := TIniFile.Create(sysINIPath);

    // verifica se o arquivo existe
    if not FileExists(sysINIPath) then
    begin
        MessageDlg('O arquivo de configurações não foi encontrado!' +
                   sLineBreak + sLineBreak +
                   'Contate o desenvolvedor.', mtWarning, [mbOK], 0);
        // Arquivo não encontrado
        // LoadMessage({janela de ogigem}     sysMessage,
        // {título da mensagem}  'Licença não encontrada!',
        // {mensagem ao usuário} 'O arquivo de configuração conf.ini não foi localizado.',
        // {caminho do ícone}    'error', {check/error/question/exclamation}
        // {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
        // {nome do link}        '',
        // {link}                ''
        // );
        Exit;
    end;

    try
        // passa os valores do arquivo ini para as variaveis
        sysServer   :=         Trim(sysINIFile.ReadString('DBAConfig' , 'Server'   ,        ''          ))     ;
        sysBase     :=         Trim(sysINIFile.ReadString('DBAConfig' , 'Base'     ,        ''          ))     ;
        sysPort     :=         Trim(sysINIFile.ReadString('DBAConfig' , 'Port'     ,        ''          ))     ;
        sysDriver   :=         Trim(sysINIFile.ReadString('DBAConfig' , 'Driver'   ,        ''          ))     ;
        sysUser     :=  Crypto(Trim(sysINIFile.ReadString('DBAConfig' , 'User'     , Crypto('SYSDBA'   )))    );
        sysPass     :=  Crypto(Trim(sysINIFile.ReadString('DBAConfig' , 'Pass'     , Crypto('masterkey')))    );
        sysLib      :=         Trim(sysINIFile.ReadString('DBAConfig' , 'Lib'      ,        ''          ))     ;

        sysDocCli   :=         Trim(sysINIFile.ReadString('DCLicence' , 'cnpj'     ,        ''          ))     ;
//        sysCliKey   :=         Trim(sysINIFile.ReadString('DCLicence' , 'ckey'     ,        ''          ))     ;

        sysLicSTR   := Shuffle(Trim(sysINIFile.ReadString('DCLicence' , 'released' ,        '01/01/2024')), '');

        sysCPrinter :=         Trim(sysINIFile.ReadString('DSPrinter' , 'opPrinter',        ''          ))     ;

        sysAppBkp   :=         Trim(sysINIFile.ReadString('OutsideApp', 'bkp'      ,        ''          ))     ;

        try
            // descriptografa e separa a data e o documento
            vDoc      := Crypto(Copy(sysLicSTR, 11, 20));
            sysLicSTR := Crypto(Copy(sysLicSTR,  1, 10));

            // verifica se o documento na licença gerada bate com o arquivo de configurações
            // if vDoc <> sysDocCli then
            // sysDocCli := '';

            // verifica se está formatado para data
            if Length(sysLicSTR) = 8 then
                sysLicSTR := Copy(sysLicSTR, 1, 2) + '/' +
                             Copy(sysLicSTR, 3, 2) + '/' +
                             Copy(sysLicSTR, 5, 4);

            // converte para data
            sysExpirationDate := StrToDateTime(Trim(sysLicSTR) + '23:59');
        except
            // define uma data caso a data coletada tenha algum problema
            sysExpirationDate := StrToDateTime('01/01/2024 23:59');
        end;

        Result := True;
    finally
        sysINIFile.Free;
    end;
end;

procedure SaveINI(vfValue: string);
begin
    sysINIFile := TIniFile.Create(sysINIPath); // cria e abre o arquivo 'ini'

    try
        sysINIFile.WriteString('DCLicence', 'released', vfValue); // grava os valores no arquivo ini
    finally
        sysINIFile.Free;
    end;
end;

function Crypto(vfStr: string): string;
var
    i: Integer;
    symbol: array [0 .. 4] of String;
begin
    // função crypto modificada por Anderson Rosa
    symbol[1] := 'ABCDEFGHIJLMNOPQRSTUVXZYWK ~!@#$%^&*()\|Ã';
    symbol[2] := 'ÂÀ©çêùÿ5Üø£úñÑªº¿®¬¼ëèïÙýÄÅÉæÆôöò»Øû×ƒÁ"Ê';
    symbol[3] := 'abcdefghijlmnopqrstuvxzywk1234567890.:ã_/';
    symbol[4] := 'àåíóÇüé¾¶§÷ÎÏ-+ÌÓß¸°¨·¹³²Õµþîì¡«½áâä¢ã_.=';

    Result := '';

    for i := 1 to Length(Trim(vfStr)) do
    begin
        if Pos(Copy(vfStr, i, 1), symbol[1]) > 0 then
            Result := Result + Copy(symbol[2], Pos(Copy(vfStr, i, 1), symbol[1]), 1)
        else
        if Pos(Copy(vfStr, i, 1), symbol[2]) > 0 then
            Result := Result + Copy(symbol[1], Pos(Copy(vfStr, i, 1), symbol[2]), 1)
        else
        if Pos(Copy(vfStr, i, 1), symbol[3]) > 0 then
            Result := Result + Copy(symbol[4], Pos(Copy(vfStr, i, 1), symbol[3]), 1)
        else
        if Pos(Copy(vfStr, i, 1), symbol[4]) > 0 then
            Result := Result + Copy(symbol[3], Pos(Copy(vfStr, i, 1), symbol[4]), 1);
    end;
end;


function ValidatePhone(vfCell: string): Boolean;
begin
    // inicializa o resultado
    Result := True;
    vfCell := Trim(vfCell);

    // vefica se está vazio
    if vfCell = '' then
        Exit;

    if (Pos(' ', vfCell) > 0) or // verifica se tem espaço
        (Length(vfCell) <> sysPhoneLength) then // verifica se tem a quantidade de numeros correta
        Result := False; // define o resultado como negativo
end;

function LoadMessage(vfTituloJan, vfTituloMen, vfMensagem, vfIcone, vfButton, vfNameLink, vfLink: string): Boolean;
begin
    {
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
    }
end;

procedure RequiredField(vpForm: TForm);
var
    vI: Integer;
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
                    ((vpForm.Components[vI] as TEdit).Text = '') then
                begin
                    // mostra a mensagem
                    LoadMessage({ título da janela    } 'Entrada Inválida',
                                { título da mensagem  } 'Campo vazio',
                                { mensagem ao usuário } 'Campo de preenchimento obrigatório!' +
                                                        sLineBreak +
                                                        sLineBreak +
                                                        '[' + (vpForm.Components[vI] as TEdit).Hint + ']',
                                { caminho do ícone    } 'exclamation', { check/error/question/exclamation }
                                { botão               } 'ok', { 'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link' }
                                { nome do link        } '',
                                { link                } '');

                    // envia o cursor para o campo
                    (vpForm.Components[vI] as TEdit).SetFocus;

                    // encerra o processo
                    Abort;
                end;
            end;
        end;
    end;
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
    Result := FormatDateTime('d'   , vfDateTime) + ' de ' +
              FormatDateTime('mmm' , vfDateTime) + ' de ' +
              FormatDateTime('yyyy', vfDateTime);

    if vYearN = vYearR then // se o ano atual for igual ao ano recebido
    begin
        if vMonthN = vMonthR then // se o mes atual for igual ao mes recebido
        begin
            if vDayN = vDayR then // se o dia atual for igual ao dia recebido
            begin
                if vHourN = vHourR then // se a hora atual for igual a hora recebida
                begin
                    if vMinuteN = vMinuteR then // se o minuto atual for igual ao minuto recebido
                    begin
                        Result := 'há menos de um minuto.'; // mostra a string de tempo

                        if (vSecondN - vSecondR) < 10 then // verifica se o tempo decorrido é menor que 10 segundos
                            Result := 'há pouco.' // mostra a string de tempo
                        else
                        if (vSecondN - vSecondR) < 20 then // verifica se o tempo decorrido é menor que 20 seggundos
                            Result := 'segundos atrás.'; // mostra a string de tempo
                    end
                    else
                    begin
                        Result := 'há menos de um minuto.'; // mostra a string de tempo

                        // define o tempo em segundos
                        vTimeN := (vMinuteN * 60) + vSecondN;
                        vTimeR := (vMinuteR * 60) + vSecondR;

                        // calcula o tempo passado
                        vMinuteA := Trunc((vTimeN - vTimeR) / 60);

                        if vMinuteA = 1 then // verifica se o tempo decorrido é igual a 1 minuto
                            Result := 'um minuto atrás.' // mostra a string de tempo
                        else
                        if vMinuteA > 1 then // verifica se o tempo decorrido é maior que 1 minuto
                            Result := IntToStr(vMinuteA) + ' minutos atrás.'; // mostra a string de tempo
                    end;
                end
                else
                begin
                    // define o tempo em segundos
                    vTimeN := (vHourN * 60) + vMinuteN;
                    vTimeR := (vHourR * 60) + vMinuteR;

                    vHourA := vTimeN - vTimeR; // calcula o tempo passado

                    if vHourA < 60 then // verifica se o tempo passado é menor que 1 hora
                    begin
                        vMinuteA := vHourA; // define o tempo passado

                        if vMinuteA = 1 then // verifica se o tempo decorrido é igual a 1 minuto
                            Result := 'um minuto atrás.' // mostra a string de tempo
                        else
                        if vMinuteA > 1 then // verifica se o tempo decorrido é maior que 1 minuto
                            Result := IntToStr(vMinuteA) + ' minutos atrás.'; // mostra a string de tempo
                    end
                    else
                    if vHourA = 60 then // verifica se o tempo decorrido é igual a 60 minutos
                    begin
                        Result := 'uma hora atrás.'; // mostra a string de tempo
                    end
                    else
                    if vHourA > 60 then // verifica se o tempo passado é maior que 60 minutos
                    begin
                        vHourA := Trunc(vHourA / 60); // calcula o tempo em hora

                        Result := 'uma hora atrás.'; // mostra a string de tempo

                        if vHourA > 1 then // verifica se o tempo decorrido é maior q 1 hora
                            Result := IntToStr(vHourA) + ' horas atrás.'; // mostra a string de tempo
                    end;
                end;
            end;
        end;
    end;
end;

function toCurrency(vfValue: string): Currency;
begin
    Result := 0; // define o valor inicial

    // verifica se o valor foi preenchido
    if vfValue <> '' then
        Result := StrToFloat(StringReplace(vfValue, '.', ',', [rfReplaceAll])); // converte o valor
end;

function FormatNumber(vfNumber: Integer): string;
begin
    // formata o numero
    Result := FormatFloat(',000#', vfNumber);

    Result := FormatFloat('#,##0', vfNumber);
end;

function SingleResult(vfConnection: TFDConnection; vfReturnField, vfTable, vfFilterField, vfOperator, vfValue, vfWhere, vfOrder: string): string;
var
    vASpos: Integer;
begin
    // zera var
    Result := '';

    // verifica se o campo de resultado foi renomeado
    vASpos := Pos(' AS ', vfReturnField) + 4;

    // cria a query
    qryAuxiliar := TFDQuery.Create(nil);

    try
        // define a conecção
        qryAuxiliar.Connection := vfConnection;

        // insere a pesquisa (ATENÇÃO: a pesquisa só pode trazer um resultado)
        qryAuxiliar.SQL.Add('SELECT             ');
        qryAuxiliar.SQL.Add(vfReturnField        ); // campo retornado
        qryAuxiliar.SQL.Add('  FROM             ');
        qryAuxiliar.SQL.Add(vfTable              ); // tabela

        // se os campos de filtro estiverem preenchidos
        if (vfWhere <> '') or ((vfFilterField <> '') and (vfValue <> '')) then
        begin
            qryAuxiliar.SQL.Add(' WHERE ');

            if vfWhere <> '' then // se vfWhere esiver preenchido
            begin
                qryAuxiliar.SQL.Add(vfWhere); // where mais implementado
            end
            else
            begin
                if vfOperator = '' then // se o poerador não estiver preenchido
                    vfOperator := '='; // usa o "igual" como operador padrão

                qryAuxiliar.SQL.Add(vfFilterField); // campo pesquisado
                qryAuxiliar.SQL.Add(vfOperator); //
                qryAuxiliar.SQL.Add(QuotedStr(vfValue)); // valor
            end;
        end;

        if vfOrder <> '' then
        begin
            qryAuxiliar.SQL.Add(' ORDER BY ');
            qryAuxiliar.SQL.Add(vfOrder);
        end;

        // faz a pesquisa
        qryAuxiliar.Open;

        if vASpos > 4 then // se o valor da var for maior que 4
            vfReturnField := Copy(vfReturnField, vASpos, Length(vfReturnField)); // pega o nome do campo

        if not qryAuxiliar.IsEmpty then // se a query não estiver vazia
            Result := qryAuxiliar.FieldByName(vfReturnField).AsString; // coleta o resultado
    finally
        qryAuxiliar.Close; // fecha a query
        qryAuxiliar.Free; // descarrega a query
    end;
end;

function SingleUpdate(vfConnection: TFDConnection; vfUpdateField, vfUpdateValue, vfTable, vfSearchField, vfOperator, vfSearchValue, vfWhere, vfOrder: string): Boolean;
begin
    //
    Result := True;

    try
        try
            // cria a query
            qryAuxiliar := TFDQuery.Create(nil);

            // define a conecção
            qryAuxiliar.Connection := vfConnection;

            // insere a atualização (ATENÇÃO: a atualziação só pode atualziar um campo)
            qryAuxiliar.SQL.Add(' UPDATE ' + vfTable       + ' SET ');
            qryAuxiliar.SQL.Add(             vfUpdateField + ' =   ');
            qryAuxiliar.SQL.Add(   QuotedStr(vfUpdateValue)         );
            qryAuxiliar.SQL.Add('  WHERE ' + vfSearchField          );
            qryAuxiliar.SQL.Add(             vfOperator             );
            qryAuxiliar.SQL.Add(             vfSearchValue          );
            qryAuxiliar.ExecSQL; // executa
        finally
            qryAuxiliar.Close; // fecha a query
            qryAuxiliar.Free; // descarrega a query
        end;
    except
        Result := False;
    end;
end;

function FullAddress(vfEndereco, vfNumero, vfBairro, vfCEP, vfComplemento, vfCity, vfUF: string): string;
begin
    // monta o endereço completo
    Result := vfEndereco + ', ' + vfNumero + ' - ' + vfBairro + ' - ' + vfCEP;

    // adiciona o complemento se existir
    if vfComplemento <> '' then
        Result := Result + ' - ' + vfComplemento;

    // finaliza o endereço completo
    Result := Result + ' - ' + vfCity + '/' + vfUF;
end;

function RequestJSON(vfURL: String): string;
var
    RESTCli: TRESTClient;
    RESTReq: TRESTRequest;
begin
    // limpa o result
    Result := '';

    try
        try
            // cria os objetos
            RESTCli := TRESTClient.Create(nil);
            RESTReq := TRESTRequest.Create(nil);

            // informa a url a ser consumida
            RESTCli.BaseURL := vfURL;

            // define o RESTClient no RESTRequest
            RESTReq.Client := RESTCli;

            // executa a api
            RESTReq.Execute;
        except
            on eError: Exception do
                LoadMessage({ título da janela    } 'Requisição da API',
                            { título da mensagem  } 'Erro da API',
                            { mensagem ao usuário } 'Um erro ocorreu ao solicidar dados do servidor!' +
                                                    sLineBreak + sLineBreak +
                                                    eError.Message,
                            { caminho do ícone    } 'error', { check/error/question/exclamation }
                            { botão               } 'ok', { 'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link' }
                            { nome do link        } '',
                            { link                } '');
        end;
    finally
        // passa para o result o resultado da API
        Result := RESTReq.Response.JSONText;

        // descarrega os objetos
        RESTCli.Free;
        RESTReq.Free;
    end;
end;

function getVersionInfo(ProgamName: string): string;
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

function getCoupon(vfCUP_ID: Integer; vfCUP_STATUS: string): Boolean;
begin
    Result := False;

    // cria a query
    qryAuxiliar := TFDQuery.Create(nil);

    try
        with qryAuxiliar do
        begin
            Connection := DBConnect.FDConnection; // define o bando de dados

            // insere o sql
            SQL.Add(' SELECT *                        ');
            SQL.Add('   FROM TB_CUPONS                ');
            SQL.Add('  WHERE CUP_ID     = :CUP_ID     ');
            SQL.Add('    AND CUP_STATUS = :CUP_STATUS ');

            // passa o valor do parametro
            ParamByName('CUP_ID').AsInteger    := vfCUP_ID;
            ParamByName('CUP_STATUS').AsString := vfCUP_STATUS;

            Open; // faz a pesquisa

            // carrega os dados nas variáveis
            gvCUP_ID     := FieldByName('CUP_ID').AsInteger;
            gvCUP_STATUS := FieldByName('CUP_STATUS').AsString;
            gvCUP_CLI_ID := FieldByName('CUP_CLI_ID').AsInteger;
            gvCUP_AUTH   := FieldByName('CUP_AUTH').AsString;

            // se a query não estiver vazia
            if not IsEmpty then
                Result := True;
        end;
    finally
        qryAuxiliar.Close; // fecha a query
        qryAuxiliar.Free; // descarrega a query
    end;
end;

function getClient(vfCLI_ID, vfCLI_STATUS: Integer): Boolean;
begin
    // cria a query
    qryAuxiliar := TFDQuery.Create(nil);

    try
        with qryAuxiliar do
        begin
            Connection := DBConnect.FDConnection; // define o bando de dados

            // insere o sql
            SQL.Add(' SELECT *                        ');
            SQL.Add('   FROM TB_CLIENTES              ');
            SQL.Add('  WHERE CLI_ID = :CLI_ID         ');

            if vfCLI_STATUS > 0 then
            begin
                SQL.Add('    AND CLI_STATUS = :CLI_STATUS ');        // implementa o SQL
                ParamByName('CLI_STATUS').AsInteger := vfCLI_STATUS; // passa o valor do parametro
            end;

            // passa o valor do parametro
            ParamByName('CLI_ID').AsInteger := vfCLI_ID;

            Open; // faz a pesquisa

            // carrega os dados nas variáveis
            gvCLI_ID          := FieldByName('CLI_ID').AsInteger;
            gvCLI_INC         := FieldByName('CLI_INC').AsDateTime;
            gvCLI_STATUS      := FieldByName('CLI_STATUS').AsInteger;
            gvCLI_DOC         := FieldByName('CLI_DOC').AsString;
            gvCLI_NOME        := FieldByName('CLI_NOME').AsString;
            gvCLI_CEL         := FieldByName('CLI_CEL').AsString;
            gvCLI_TEL         := FieldByName('CLI_TEL').AsString;
            gvCLI_EMAIL       := FieldByName('CLI_EMAIL').AsString;
            gvCLI_CEP         := FieldByName('CLI_CEP').AsString;
            gvCLI_CIDADE      := FieldByName('CLI_CIDADE').AsString;
            gvCLI_UF          := FieldByName('CLI_UF').AsString;
            gvCLI_PONTOS      := FieldByName('CLI_PONTOS').AsCurrency;
            gvCLI_ENDERECO    := FieldByName('CLI_ENDERECO').AsString;
            gvCLI_NUMERO      := FieldByName('CLI_NUMERO').AsString;
            gvCLI_BAIRRO      := FieldByName('CLI_BAIRRO').AsString;
            gvCLI_COMPLEMENTO := FieldByName('CLI_COMPLEMENTO').AsString;
            gvCLI_FULLADDRESS := FieldByName('CLI_FULLADDRESS').AsString;
        end;
    finally
        qryAuxiliar.Close; // fecha a query
        qryAuxiliar.Free; // descarrega a query
    end;
end;

function getCampaign(vfCAM_ID, vfCAM_STATUS: Integer): Integer;
begin
    // cria a query
    qryAuxiliar := TFDQuery.Create(nil);

    if vfCAM_ID = 0 then
    begin
        vfCAM_ID     := 1;
        vfCAM_STATUS := 1;
    end;

    try
        with qryAuxiliar do
        begin
            Connection := DBConnect.FDConnection; // define o bando de dados

            // insere o sql
            SQL.Add(' SELECT *                        ');
            SQL.Add('   FROM TB_CAMPANHAS             ');
            SQL.Add('  WHERE CAM_ID     = :CAM_ID     ');
            SQL.Add('    AND CAM_STATUS = :CAM_STATUS ');

            ParamByName('CAM_ID').AsInteger     := vfCAM_ID;
            ParamByName('CAM_STATUS').AsInteger := vfCAM_STATUS;

            {
              if vfCLI_STATUS > 0 then
              begin
              SQL.Add('    AND CLI_STATUS = :CLI_STATUS '); // implementa o SQL
              ParamByName('CLI_STATUS').AsInteger := vfCLI_STATUS; // passa o valor do parametro
              end;

              // passa o valor do parametro
              ParamByName('CLI_ID').AsInteger     := vfCLI_ID;
            }

            Open; // faz a pesquisa

            // carrega os dados nas variáveis
            gvCAM_ID                := FieldByName('CAM_ID').AsInteger;
            gvCAM_INC               := FieldByName('CAM_INC').AsDateTime;
            gvCAM_STATUS            := FieldByName('CAM_STATUS').AsInteger;
            gvCAM_D_INICIO          := FieldByName('CAM_D_INICIO').AsDateTime;
            gvCAM_H_INICIO          := FieldByName('CAM_H_INICIO').AsDateTime;
            gvCAM_D_FINAL           := FieldByName('CAM_D_FINAL').AsDateTime;
            gvCAM_H_FINAL           := FieldByName('CAM_H_FINAL').AsDateTime;
            gvCAM_NOME              := FieldByName('CAM_NOME').AsString;
            gvCAM_SLOGAN            := FieldByName('CAM_SLOGAN').AsString;
            gvCAM_VALOR_PONTO       := FieldByName('CAM_VALOR_PONTO').AsInteger;
            gvCAM_SIGLA             := FieldByName('CAM_SIGLA').AsString;
            gvCAM_LINK_REGULAMENTO  := FieldByName('CAM_LINK_REGULAMENTO').AsString;
            gvCAM_CERTIFICADO       := FieldByName('CAM_CERTIFICADO').AsString;
            gvCAM_REGULAMENTO       := FieldByName('CAM_REGULAMENTO').AsString;
            gvCAM_PERIODO           := FormatDateTime('dd/mm', FieldByName('CAM_D_INICIO').AsDateTime) +
                                       ' até ' +
                                       FormatDateTime('dd/mm/yyyy', FieldByName('CAM_D_INICIO').AsDateTime);
        end;
    finally
        Result := gvCAM_ID; // define o result

        qryAuxiliar.Close; // fecha a query
        qryAuxiliar.Free; // descarrega a query
    end;
end;

function getCompany(vfEMP_ID, vfEMP_STATUS: Integer): Integer;
begin
    // cria a query
    qryAuxiliar := TFDQuery.Create(nil);

    if vfEMP_ID = 0 then
    begin
        vfEMP_ID     := 1;
        vfEMP_STATUS := 1;
    end;

    try
        with qryAuxiliar do
        begin
            Connection := DBConnect.FDConnection; // define o bando de dados

            // insere o sql
            SQL.Add(' SELECT *                        ');
            SQL.Add('   FROM TB_EMPRESAS              ');
            SQL.Add('  WHERE EMP_ID     = :EMP_ID     ');
            SQL.Add('    AND EMP_STATUS = :EMP_STATUS ');

            ParamByName('EMP_ID').AsInteger     := vfEMP_ID;
            ParamByName('EMP_STATUS').AsInteger := vfEMP_STATUS;

            Open; // faz a pesquisa

            // carrega os dados nas variáveis
            gvEMP_ID          := FieldByName('EMP_ID').AsInteger;
            gvEMP_INC         := FieldByName('EMP_INC').AsDateTime;
            gvEMP_STATUS      := FieldByName('EMP_STATUS').AsInteger;
            gvEMP_DOC         := FieldByName('EMP_DOC').AsString;
            gvEMP_LOGO        := FieldByName('EMP_LOGO').AsString;
            gvEMP_RSOCIAL     := FieldByName('EMP_RSOCIAL').AsString;
            gvEMP_NFANTASIA   := FieldByName('EMP_NFANTASIA').AsString;
            gvEMP_CEL         := FieldByName('EMP_CEL').AsString;
            gvEMP_TEL         := FieldByName('EMP_TEL').AsString;
            gvEMP_CEP         := FieldByName('EMP_CEP').AsString;
            gvEMP_LOGRADOURO  := FieldByName('EMP_LOGRADOURO').AsString;
            gvEMP_NUMERO      := FieldByName('EMP_NUMERO').AsString;
            gvEMP_COMPLEMENTO := FieldByName('EMP_COMPLEMENTO').AsString;
            gvEMP_BAIRRO      := FieldByName('EMP_BAIRRO').AsString;
            gvEMP_CIDADE      := FieldByName('EMP_CIDADE').AsString;
            gvEMP_UF          := FieldByName('EMP_UF').AsString;
            gvEMP_EMAIL       := FieldByName('EMP_EMAIL').AsString;
        end;
    finally
        Result := gvCAM_ID; // define o result

        qryAuxiliar.Close; // fecha a query
        qryAuxiliar.Free; // descarrega a query
    end;
end;

end.

// #######################################################################
// #######################################################################
SingleResult({ DB TFDConnection     } ,
             { campo retornado      } '',
             { tabela               } '',
             { campo de filtro      } '',
             { operador da pesquisa } '',
             { valor do filtro      } '',
             { where composto       } '',
             { ordenação (order by) } '');

SingleUpdate({ DB TFDConnection     } ,
             { campo atualizado     } '',
             { valor atualizado     } '',
             { tabela               } '',
             { campo de filtro      } '',
             { operador da pesquisa } '',
             { valor do filtro      } '',
             { where composto       } '',
             { ordenação (order by) } '');

