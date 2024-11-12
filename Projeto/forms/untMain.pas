unit untMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untStandard, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.WinXCalendars;

type
  TfrmMain = class(TfrmStandard)
    pnlHoje: TPanel;
    pboxTopo: TPaintBox;
    lblTitleForm02: TLabel;
    pnlSideBar: TPanel;
    shpSideLine: TShape;
    pnlButtons: TPanel;
    Shape18: TShape;
    pnlSideButtonSpace00: TPanel;
    pnlExit: TPanel;
    btnClose: TImage;
    Label5: TLabel;
    pnlConfig: TPanel;
    btnConfig: TImage;
    Label2: TLabel;
    pnlSideButton04: TPanel;
    btnNotificacoes: TImage;
    Label3: TLabel;
    pnlSideButton01: TPanel;
    btnCliente: TImage;
    Label4: TLabel;
    pnlSideButton02: TPanel;
    btnCompromisso: TImage;
    Label6: TLabel;
    pnlSideButton00: TPanel;
    btnDashboard: TImage;
    Label7: TLabel;
    pnlSideButton03: TPanel;
    btnAtendimento: TImage;
    Label8: TLabel;
    pnlSideButton05: TPanel;
    btnBuscar: TImage;
    Label9: TLabel;
    pnlSideButtonSpace10: TPanel;
    pnlSideButtonSpace09: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlHome: TPanel;
    Label11: TLabel;
    pnlDigClock: TPanel;
    dgrClock: TPaintBox;
    pnlHour: TPanel;
    lblHou: TLabel;
    Label10: TLabel;
    pnlMinute: TPanel;
    lblMin: TLabel;
    Label12: TLabel;
    pnlSecond: TPanel;
    lblSec: TLabel;
    Label15: TLabel;
    GridPanel2: TGridPanel;
    imgLogo: TImage;
    Calendar: TCalendarView;
    Panel4: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    pnlAgenda: TPanel;
    Panel3: TPanel;
    pboxHoje: TPaintBox;
    lblHoje2: TLabel;
    pnlAtend: TPanel;
    lblAtendimentos: TLabel;
    pnlAtendimentos: TPanel;
    pnlComp: TPanel;
    lblCompromisso: TLabel;
    pnlCompromissos: TPanel;
    tmrClock: TTimer;
    tmrAgendas: TTimer;
    pnlAgeButtons: TPanel;
    imgDel: TImage;
    imgAdd: TImage;
    imgEdt: TImage;
    imgClo: TImage;
    imgSen: TImage;
    imgEnv: TImage;
    imgCfm: TImage;
    lblHoje: TLabel;

    function getId(Sender: TObject): Integer;

    procedure MoveForm(Sender: TObject; Shift: TShiftState; X, Y: Integer);

    procedure FormCreate(Sender: TObject);

    procedure tmrClockTimer(Sender: TObject);
    procedure tmrAgendasTimer(Sender: TObject);

    procedure CalendarClick(Sender: TObject);

    procedure btnCloseClick(Sender: TObject);
    procedure btnSenClick(Sender: TObject);
    procedure btnCloClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEdtClick(Sender: TObject);
    procedure btnCanClick(Sender: TObject);
    procedure btnNotificacoesClick(Sender: TObject);
    procedure btnClienteClick(Sender: TObject);

  private
    { Private declarations }
    vATD_ID: Integer;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses untFunctions, untSource, untStyle, untObjects,
        c.atendimentos,
        untAtd_Cadastro, untSnd_Mensagem, untPrepareMessage;

var
    vType: string = 'text';


function TfrmMain.getId(Sender: TObject): Integer;
begin
    // pega o id do objeto
    Result := (Sender as TImage).parent.Tag;
end;

procedure TfrmMain.btnAddClick(Sender: TObject);
begin
    // inicializa o form
    ToCreate(frmAtd_Cadastro, TfrmAtd_Cadastro, Self, nil, pnlAgenda);
end;

procedure TfrmMain.btnCanClick(Sender: TObject);
begin
    //
    if showMsg({janela de ogigem}    Self.Caption,
               {título da mensagem}  '',
               {mensagem ao usuário} 'Deseja realmente cancelar o atendimento?',
               {caminho do ícone}    'question', {check/error/question/exclamation}
               {botão}               'y/n', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
               {nome do link}        '',
               {link}                '')
    then
    begin
        // cansela o atendimento
        c.atendimentos.atdChange(getId(Sender), 'C');

        // recarrega os dados
        iSchedulingBox(Self, pnlAtendimentos, gvDate);
    end;
end;

procedure TfrmMain.btnClienteClick(Sender: TObject);
begin
    // inicializa o form
    ToCreate(frmAtd_Cadastro, TfrmAtd_Cadastro, Self, nil, pnlAgenda);
end;

procedure TfrmMain.btnCloClick(Sender: TObject);
begin
    if showMsg({janela de ogigem}    Self.Caption,
               {título da mensagem}  '',
               {mensagem ao usuário} 'Deseja realmente marcar o atendimento como finalizado?',
               {caminho do ícone}    'question', {check/error/question/exclamation}
               {botão}               'y/n', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
               {nome do link}        '',
               {link}                '')
    then
    begin
        // finaliza o atendimento
        c.atendimentos.atdChange(getId(Sender), 'F');
    end;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
    // encerra a aplicação
    Application.Terminate;
end;

procedure TfrmMain.btnEdtClick(Sender: TObject);
begin
    // pega o id do atendimento
    vATD_ID := getId(Sender);

    // verifica se tem atendimento
    if vATD_ID = 0 then
        Exit;

    // verifica se o form foi criado
    if not Assigned(frmAtd_Cadastro) then
        frmAtd_Cadastro := TfrmAtd_Cadastro.Create(nil); // cria o form

    // faza busca e obtem os dados do cliente
    c.atendimentos.atdSearchClk(FormatDateTime('yyyy-mm-dd', gvDate),
                                (Sender as TImage).Parent.Hint,
                                 vATD_ID);

    try
        frmAtd_Cadastro.Tag := vATD_ID;

        frmAtd_Cadastro.pnlCliente.Tag       := gvPES_ID;
        frmAtd_Cadastro.txtCliente.Text      := gvPES_NOME;

        frmAtd_Cadastro.txtData.Date         := gvATD_DATA;
        frmAtd_Cadastro.txtHora.Time         := gvATD_HORA;

        frmAtd_Cadastro.pnlProcedimento.Tag  := gvPRC_ID;
        frmAtd_Cadastro.txtProcedimento.Text := gvPRC_NOME;

        frmAtd_Cadastro.txtDuracao.Text      := IntToStr(gvATD_DURACAO) + ' min.';
        frmAtd_Cadastro.txtValor.Text        := FormatMoney(gvATD_VALOR);

        frmAtd_Cadastro.pnlPagamento.Tag     := gvFPG_ID;
        frmAtd_Cadastro.txtPagamento.Text    := gvFPG_NOME;

        frmAtd_Cadastro.txtObservacoes.Text  := gvATD_OBSERVACOES;

        frmAtd_Cadastro.ShowModal; // exibe o form

//        if frmAtd_Cadastro.Tag <> 0 then
//            iSchedulingBox(Self, pnlAtendimentos, gvDate); // recarrega os dados
    finally
        frmAtd_Cadastro := nil;
        frmAtd_Cadastro.Free; // descarrega o objeto
    end;
end;

procedure TfrmMain.btnNotificacoesClick(Sender: TObject);
begin
    // inicializa o form
    ToCreate(frmSnd_Mensagem, TfrmSnd_Mensagem, Self, nil, pnlAgenda);
end;

procedure TfrmMain.btnSenClick(Sender: TObject);
var
    vSND_MESSAGE,
    vSND_TELEFONE: string;
    vError: Integer;
begin
    vATD_ID := getId(Sender);

    try
        try
            // se o painel tiver um cliente assossiado
            if vATD_ID > 0 then
            begin
                // faza busca e obtem os dados do cliente
                c.atendimentos.atdSearchClk(FormatDateTime('yyyy-mm-dd', gvDate),
                                            (Sender as TImage).Parent.Hint,
                                             vATD_ID);

                // se o atendimento já foi finalizado
                if gvATD_STATUS = 'N' then
                begin
                    vError := -5;
                    Exit;
                end;

                // gera a mensagem
                vSND_MESSAGE := createMessage('confirma', gvPES_NOME,
                                                           vcCLK_ATD_DATA,
                                                            vcCLK_ATD_HORA,
                                                             gvPRC_NOME);

                // verifica o conteudo da variavel
                if vcCLK_TEL_TELEFONE <> '' then
                    vSND_TELEFONE := vcCLK_TEL_TELEFONE // pega o telefone
                else
                    vSND_TELEFONE := gvTEL_DDI + gvTEL_DDD + gvTEL_TELEFONE; // pega o telefone

                // valida o numero
                vSND_TELEFONE := ValidarPhone(vSND_TELEFONE);

                // verifica se o numero é válido
                if vSND_TELEFONE = '' then
                begin
                    vError := -1;
                    Exit;
                end;

                // envia a mensagem
                if not(getSendResult(SendToWhatsapp(vSND_TELEFONE, 'single-notification',
                                              vType, '', '', vSND_MESSAGE))) then
                vError := 1;
            end;
        finally
            // exibe a mensagem
            if vError = -5 then
                showMsg({janela de ogigem}    Self.Caption,
                        {título da mensagem}  'Inpossível notificar!',
                        {mensagem ao usuário} 'O atendimento selecionado já foi finalizado!',
                        {caminho do ícone}    'exclamation', {check/error/question/exclamation}
                        {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                        {nome do link}        '',
                        {link}                '')
            else
            if vError = -1 then
                showMsg({janela de ogigem}    Self.Caption,
                        {título da mensagem}  'Inpossível notificar!',
                        {mensagem ao usuário} 'O número registrado para esse cliente não é válido!' + sLineBreak +
                                              sLineBreak +
                                              'Verifique o cadastro do cliente e tente novamente!' ,
                        {caminho do ícone}    'error', {check/error/question/exclamation}
                        {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                        {nome do link}        '',
                        {link}                '')
            else
            if vError > 1 then
                showMsg({janela de ogigem}    Self.Caption,
                        {título da mensagem}  'Inpossível notificar!',
                        {mensagem ao usuário} 'Um erro ocorreu ao tentar enviar a notificação!' + sLineBreak +
                                              sLineBreak +
                                              'Tente novamente mais tarde!' ,
                        {caminho do ícone}    'error', {check/error/question/exclamation}
                        {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                        {nome do link}        '',
                        {link}                '')
            else
            if vError = 0 then
                showMsg({janela de ogigem}    Self.Caption,
                        {título da mensagem}  'Notificações de Agendamento',
                        {mensagem ao usuário} 'Notificação de ' + gvPES_NOME +
                                              ' enviada com sucesso!',
                        {caminho do ícone}    'check', {check/error/question/exclamation}
                        {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                        {nome do link}        '',
                        {link}                '');
        end;
    except
        //
    end;
end;

procedure TfrmMain.CalendarClick(Sender: TObject);
begin
    // compara as dastas do sistema e do calendario
    if gvDate <> Calendar.Date then
    begin
        // define a data do sistema
        gvDate := Calendar.Date;

        // recarrega os dados
        iSchedulingBox(Self, pnlAtendimentos, gvDate);
    end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
    // seta a data e a hora
    Calendar.Date  := gvDate;

    // define a hora
    ATime(lblHou, lblMin, lblSec);
    lblHoje.Caption := fullDAte(gvDate);

    // define o tamanho do form
    Self.ClientHeight := 700;
    Self.ClientWidth  := 1300;

    // cria o form
//    ToCreate(frmLogin, TfrmLogin, nil, nil, nil);

    //
    inherited;

    // seta as definições da janela
    lblTitleForm02.Caption := 'EasyCare';
    Self.Caption           := gcAppTitle;
end;

procedure TfrmMain.MoveForm(Sender: TObject; Shift: TShiftState; X, Y: Integer);
const
    sc_DragMove = $f012;
begin
    // permite mover o form
    ReleaseCapture;
    Perform(wm_SysCommand, sc_DragMove, 0);
end;

procedure TfrmMain.tmrAgendasTimer(Sender: TObject);
begin
    // define o tempo de atualização
    tmrAgendas.Interval := gvScheduleRefresh;

    iSchedulingBox(Self, pnlAtendimentos, gvDate);
end;

procedure TfrmMain.tmrClockTimer(Sender: TObject);
begin
    // define a hora
    ATime(lblHou, lblMin, lblSec);
end;

end.

