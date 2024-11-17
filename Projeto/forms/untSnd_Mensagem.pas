unit untSnd_Mensagem;

interface

uses untStandard,

  Winapi.Windows, Winapi.Messages,

  System.SysUtils, System.Variants, System.Classes,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.WinXCalendars, Vcl.ComCtrls,

  Data.DB,

  Datasnap.DBClient, Datasnap.Provider,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.WinXCtrls



  ;

type
  TfrmSnd_Mensagem = class(TfrmStandard)
    dbgList: TDBGrid;
    pnlData: TPanel;
    pboxHoje: TPaintBox;
    lblLogDate: TLabel;
    dspAtd: TDataSetProvider;
    cdsAtd: TClientDataSet;
    dtsAtd: TDataSource;
    qryAtd: TFDQuery;
    Shape1: TShape;
    Calendar: TCalendarPicker;
    pnlHistory: TPanel;
    txtHistory: TMemo;
    pnl01: TPanel;
    lbl01: TLabel;
    btnRefresh: TImage;
    Panel1: TPanel;
    Label1: TLabel;
    btnSendAll: TImage;
    btnNotified: TToggleSwitch;
    procedure reLoad(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);

    procedure btnSendAllClick(Sender: TObject);

    procedure CalendarChange(Sender: TObject);

    procedure dbgListDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSnd_Mensagem: TfrmSnd_Mensagem;

implementation

{$R *.dfm}

uses untStyle, untDBConnect, untFunctions, untPrepareMessage, untSource,
  c.atendimentos;

var
    vType : string  = 'text';
    vCount: Integer = 0;
    vSend : Integer = 0;

procedure TfrmSnd_Mensagem.CalendarChange(Sender: TObject);
begin
  inherited;
    //
    reLoad(Sender);

    // colca a data do calendario no label
    lblLogDate.Caption := fullDAte(Calendar.Date);
end;

procedure TfrmSnd_Mensagem.dbgListDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
//  inherited;
    // define o padrão da zebra
    setZebraDbg(Self.dbgList, (Sender as TObject), Rect, DataCol, Column, State);
end;

procedure TfrmSnd_Mensagem.FormActivate(Sender: TObject);
begin
  inherited;
    // oculta a barra de rolagem horizontal
    ShowScrollBar(dbgList.handle, SB_HORZ, False);
    ShowScrollBar(dbgList.handle, SB_VERT, False);
end;

procedure TfrmSnd_Mensagem.FormCreate(Sender: TObject);
begin
  inherited;
    // seta a data atual no calendario
    Calendar.Date := gvDate;

    // colca a data do calendario no label
    lblLogDate.Caption := fullDAte(gvDate);
end;

procedure TfrmSnd_Mensagem.reLoad(Sender: TObject);
begin
    // seleciona os dados
    with qryAtd do
    begin
        Close;
        SQL.Clear;

        SQL.Add(' SELECT                                              ');
        SQL.Add('   ATD_ID, ATD_STATUS, ATD_DATA, PES_NOME, PRC_NOME, ');
        SQL.Add('   TEL_DDI, TEL_DDD, TEL_TELEFONE,                   ');
        SQL.Add('   CONCAT(ATD_DURACAO, '' min.'') AS ATD_DURACAO,    ');
        SQL.Add('   TIME_FORMAT(ATD_HORA, ''%H:%i'') AS ATD_HORA,     ');
        SQL.Add('   REPLACE(                                          ');
        SQL.Add('       REPLACE(                                      ');
        SQL.Add('           REPLACE(                                  ');
        SQL.Add('               FORMAT(ATD_VALOR, 2),                 ');
        SQL.Add('           ''.'', ''|''),                            ');
        SQL.Add('       '','', ''.''),                                ');
        SQL.Add('   ''|'', '','') AS ATD_VALOR                        ');
        SQL.Add('  FROM ATENDIMENTOS                                  ');
        SQL.Add('  JOIN ATENDIMENTOS_PESS ON (APS_ATD_ID = ATD_ID)    ');
        SQL.Add('  JOIN ATENDIMENTOS_PROC ON (APC_ATD_ID = ATD_ID)    ');
        SQL.Add('  JOIN PESSOAS ON (PES_ID = APS_PES_ID)              ');
        SQL.Add('  JOIN TELEFONES ON (TEL_PES_ID = PES_ID)            ');
        SQL.Add('  JOIN PROCEDIMENTOS ON (PRC_ID = APC_PRC_ID)        ');
        SQL.Add(' WHERE ATD_DATA = :ATD_DATA                          ');
        SQL.Add('   AND ATD_STATUS = ''A''                            ');

        // vrifica se vai ocultar/exibir clientes já notificados
        if btnNotified.State = tssOn then
            SQL.Add(' AND ATD_NOTIFICADO = ''N'' ');

        SQL.Add(' ORDER BY ATD_HORA                                   ');
        ParamByName('ATD_DATA').AsDate := Calendar.Date;
        Open;
    end;

    // carrega os dados no CDS
    cdsAtd.Open;
    cdsAtd.Refresh;

    // exibe/oculta o dbgrid
    dbgList.Visible := not(cdsAtd.IsEmpty);

    // oculta a barra de rolagem horizontal
    ShowScrollBar(dbgList.handle, SB_HORZ, False);
end;

procedure TfrmSnd_Mensagem.btnSendAllClick(Sender: TObject);
var
    vPES_NOME,
    vSND_MESSAGE,
    vSND_TELEFONE: string;
    vError: Integer;
begin
    try
        // verifica se tem algum registro listado
        if cdsAtd.IsEmpty then
        begin
            vError := -27; // define o erro
            Exit; // encerra a execução
        end;

        // exibe o painel historico
        pnlHistory.Visible := True;

        // limpa o campo
        txtHistory.Clear;

        // inicia a variavel
        vError := 0;

        // move para o primeiro registro
        cdsAtd.First;

        // inicia o historico
        txtHistory.Lines.Add('   Notificações' + sLineBreak);

        // passa por todos os registros enviando a mensagem
        while not(cdsAtd.Eof) do
        begin
            // coleta de dados
            vPES_NOME     := cdsAtd.FieldByName('PES_NOME').AsString;

            // gera a mensagem
            vSND_MESSAGE := createMessage('confirma', vPES_NOME,
                                           cdsAtd.FieldByName('ATD_DATA').AsString,
                                            cdsAtd.FieldByName('ATD_HORA').AsString,
                                             cdsAtd.FieldByName('PRC_NOME').AsString);

            // pega o telefone
            vSND_TELEFONE := cdsAtd.FieldByName('TEL_DDI').AsString +
                              cdsAtd.FieldByName('TEL_DDD').AsString +
                               cdsAtd.FieldByName('TEL_TELEFONE').AsString;

            // valida o numero
            vSND_TELEFONE := ValidarPhone(vSND_TELEFONE);

            // envia a mensagem
            if getSendResult(
                SendToWhatsapp(vSND_TELEFONE, 'mult-notification',
                                vType, '', '', vSND_MESSAGE)) then
            begin
                // marca o atendimento como nofificado
                c.atendimentos.atdSetNotified(cdsAtd.FieldByName('ATD_ID').AsInteger);

                // adiciona o historico
                txtHistory.Lines.Add('    - ' + vPES_NOME + ' => enviada com sucesso.')
            end
            else
            begin
                // adiciona o historico
                txtHistory.Lines.Add('    - ' + vPES_NOME + ' => não enviada.');

                // registra o erro
                Inc(vError);
            end;

            // move para o proximo registro
            cdsAtd.Next;
        end;

        // move para o primeiro registro
        cdsAtd.First;
    finally
        // exibe a mensagem
        if vError = -27 then
            showMsg({janela de ogigem}    Self.Caption,
                    {título da mensagem}  'Lista vazia!',
                    {mensagem ao usuário} 'Nenhum cliente listado na data selecionada!',
                    {caminho do ícone}    'exclamation', {check/error/question/exclamation}
                    {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                    {nome do link}        '',
                    {link}                '')
        else
        if vError = 0 then
            showMsg({janela de ogigem}    Self.Caption,
                    {título da mensagem}  'Notificações de Agendamento',
                    {mensagem ao usuário} 'Todas as notificações foram enviadas com sucesso!',
                    {caminho do ícone}    'check', {check/error/question/exclamation}
                    {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                    {nome do link}        '',
                    {link}                '');

        // fecha a ajanela
        Close;
    end;
end;

end.






procedure TfrmSnd_Mensagem.dbgListDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
//  inherited;
    // define o padrão da zebra
    if Odd(dbgList.DataSource.DataSet.RecNo) then
        dbgList.Canvas.Brush.Color := $00CAEBD1
    else
        dbgList.Canvas.Brush.Color := clWhite;

    // cofigura a cor do highligth
    if (gdSelected in State) then
    begin
        dbgList.Canvas.Brush.Color := $0048B74B;
        dbgList.Canvas.Font.Color  := clWhite;
        dbgList.Canvas.Font.Style  := [fsBold];
    end;

    // seta as configurações
    dbgList.Canvas.FillRect(Rect);
    dbgList.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

