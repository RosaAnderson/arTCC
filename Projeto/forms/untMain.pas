unit untMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untStandard, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.WinXCalendars, Vcl.Imaging.jpeg,
  System.DateUtils;

type
  TfrmMain = class(TfrmStandard)
    pnlTopo: TPanel;
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
    pnlHome: TPanel;
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
    pnlRegistered: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    pnlAgenda: TPanel;
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
    Image2: TImage;
    pnlCenter: TPanel;
    pnlNextATD: TPanel;
    imgAvatar: TImage;
    shpBorda: TShape;
    lblPES_NOME: TLabel;
    imgBox: TImage;
    Label24: TLabel;
    lblPRC_NOME: TLabel;
    pnlNext00: TPanel;
    pnlNextATDData: TPanel;
    Label1: TLabel;
    lblATD_DATA: TLabel;
    pnlNextATDHora: TPanel;
    Label13: TLabel;
    lblATD_HORA: TLabel;
    pnlNextATDValor: TPanel;
    Label22: TLabel;
    lblATD_VALOR: TLabel;
    pnl001: TPanel;
    pnlGraficoMes: TPanel;
    btnConfirmN: TImage;
    btnCancelN: TImage;
    pnlGraficoM: TPanel;
    Label11: TLabel;
    pnl001_M: TPanel;
    lbl001_M: TLabel;
    pnl002_M: TPanel;
    lbl002_M: TLabel;
    pnl003_M: TPanel;
    lbl003_M: TLabel;
    pnl000_M: TPanel;
    lbl000_M: TLabel;
    pnlGraficoDia: TPanel;
    Label14: TLabel;
    pnlGraficoD: TPanel;
    Panel10: TPanel;
    lblDinheiroH: TLabel;
    Panel11: TPanel;
    lblPIXH: TLabel;
    Panel12: TPanel;
    lblCreditoH: TLabel;
    Panel13: TPanel;
    lblDebitoH: TLabel;

    function getId(Sender: TObject): Integer;
    function getName(Sender: TObject): string;

    procedure MoveForm(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);

    procedure loadGraphic();
    procedure loadNextATD(Sender: TObject);
    procedure finishPreviousATD(Sender: TObject);

    procedure visiblePanel(vpStatus: Boolean);

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
    procedure btnCompromissoClick(Sender: TObject);
    procedure btnDashboardClick(Sender: TObject);

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
        untAtd_Cadastro, untSnd_Mensagem, untPrepareMessage, untCli_Cadastro;

var
    vType: string = 'text';


function TfrmMain.getId(Sender: TObject): Integer;
begin
    // pega o id do objeto
    Result := (Sender as TImage).parent.Tag;
end;

function TfrmMain.getName(Sender: TObject): string;
var
    vComponent: TComponent;
begin
    try
        // pega o nome do cliente
        vComponent := nil;
        vComponent := Self.FindComponent('lblC_' + Copy((Sender as TImage).Parent.Name, 6, 30));
        Result     := (vComponent as TLabel).Caption;

        if Result = '' then
            Result := ' de ' + lblPES_NOME.Caption
        else
            Result := ' de ' + Result;
    finally
        vComponent := nil;
    end;
end;

procedure TfrmMain.btnAddClick(Sender: TObject);
begin
    // pega o id do atendimento
    vATD_ID := getId(Sender);

    // verifica se tem atendimento
    if vATD_ID <> 0 then
        Exit;

    // inicializa o form
    ToCreate(frmAtd_Cadastro, TfrmAtd_Cadastro, Self, nil, pnlAgenda);
end;

procedure TfrmMain.btnCanClick(Sender: TObject);
begin
    // pega o id do atendimento
    vATD_ID := getId(Sender);

    // verifica se tem atendimento
    if vATD_ID = 0 then
        Exit;

    //
    if showMsg({janela de ogigem}    Self.Caption,
               {título da mensagem}  '',
               {mensagem ao usuário} 'Deseja realmente cancelar o atendimento' +
                                     getName(Sender) + '?',
               {caminho do ícone}    'question', {check/error/question/exclamation}
               {botão}               'y/n', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
               {nome do link}        '',
               {link}                '')
    then
    begin
        // cansela o atendimento
        c.atendimentos.atdChange(vATD_ID, 'C');

        // recarrega os dados
        iSchedulingBox(Self, pnlAtendimentos, gvDate);
    end;
end;

procedure TfrmMain.btnClienteClick(Sender: TObject);
begin
    // inicializa o form
    ToCreate(frmCli_Cadastro, TfrmCli_Cadastro, Self, nil, pnlAgenda);
end;

procedure TfrmMain.btnCloClick(Sender: TObject);
begin
    // pega o id do atendimento
    vATD_ID := getId(Sender);

    // verifica se tem atendimento
    if vATD_ID = 0 then
        Exit;

    if showMsg({janela de ogigem}    Self.Caption,
               {título da mensagem}  '',
               {mensagem ao usuário} 'Deseja realmente marcar o atendimento' +
                                     getName(Sender) + ' como finalizado?',
               {caminho do ícone}    'question', {check/error/question/exclamation}
               {botão}               'y/n', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
               {nome do link}        '',
               {link}                '')
    then
    begin
        // finaliza o atendimento
        c.atendimentos.atdChange(vATD_ID, 'F');
    end;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
    // encerra a aplicação
    Application.Terminate;
end;

procedure TfrmMain.btnCompromissoClick(Sender: TObject);
begin
  inherited;
    // exibe/oculta a agenda
//    pnlAgenda.Visible := not(pnlAgenda.Visible);
    if pnlAgenda.Width < 10 then
        pnlAgenda.Width := 300
    else
        pnlAgenda.Width := 1;
end;

procedure TfrmMain.btnDashboardClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmMain.btnEdtClick(Sender: TObject);
begin
visiblePanel(False);
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
        if gvATD_STATUS <> 'A' then
            Exit;

        frmAtd_Cadastro.Tag                  := vATD_ID;

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
visiblePanel(True);
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
    // pega o id do atendimento
    vATD_ID := getId(Sender);

    // verifica se tem atendimento
    if vATD_ID = 0 then
        Exit;

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
                if gvATD_STATUS = 'F' then
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
                if (getSendResult(SendToWhatsapp(vSND_TELEFONE, 'single-notification',
                                              vType, '', '', vSND_MESSAGE))) then
                begin
                    // marca o atendimento como nofificado
                    c.atendimentos.atdSetNotified(vATD_ID);

                    // recarrega os dados
                    iSchedulingBox(Self, pnlAtendimentos, gvDate);
                end
                else
                    vError := 1; // muda o status
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

procedure TfrmMain.loadGraphic();
var
    numDaysM, // numero de dias do mes
    numAtenD, // numero de atendimentos por dia
    totAtend, // total de atendimentos no mes
    maxWidth: // largura dopanel
              Integer;
    stepSize: Double;  // tamanho do passo
    yearMonth: string;
begin
    //
    yearMonth := FormatDateTime('/mm/yyyy', Now);

    // pega a largura do panel
    maxWidth := pnl001_M.Width;

    // pega o numero de dias
    numDaysM := MonthDays[IsLeapYear(
                    StrToInt(FormatDateTime('yyyy', Now))),
                        StrToInt(FormatDateTime('mm', Now))];

    // calcula o numero de atendimentos do dia
    numAtenD := StrToInt(FormatDateTime('hh', (StrToTime(gvHExpF) - StrToTime(gvHExpI))));

    // calcula o numero de atendimentos no mes
    totAtend := numDaysM * numAtenD;

    // calcula o passo
    stepSize := totAtend / maxWidth;

    // faz a busca
    getVoG(StrToDate('01' + yearMonth), StrToDate('30' + yearMonth));

// monta o grafico
//##############################################################################
    // primeira linha
    if Length(Matriz) > 0 then
    begin
        lbl000_M.Width   := Trunc(((StrToInt(Matriz[0,1]) / totAtend) * 100) * stepSize) * 15;
        lbl000_M.Caption := '  ' + Matriz[0,0];
        pnl000_M.Caption := '  ' + Matriz[0,0];
        pnl000_M.Visible := True;
    end
    else
        pnl000_M.Visible := False;

    // segunda linha
    if Length(Matriz) > 1 then
    begin
        lbl001_M.Width   := Trunc(((StrToInt(Matriz[1,1]) / totAtend) * 100) * stepSize) * 15;
        lbl001_M.Caption := '  ' + Matriz[1,0];
        pnl001_M.Caption := '  ' + Matriz[1,0];
        pnl001_M.Visible := True;
    end
    else
        pnl001_M.Visible := False;

    // terceira linha
    if Length(Matriz) > 2 then
    begin
        lbl002_M.Width   := Trunc(((StrToInt(Matriz[2,1]) / totAtend) * 100) * stepSize) * 15;
        lbl002_M.Caption := '  ' + Matriz[2,0];
        pnl002_M.Caption := '  ' + Matriz[2,0];
        pnl002_M.Visible := True;
    end
    else
        pnl002_M.Visible := False;

    // quarta linha
    if Length(Matriz) > 3 then
    begin
        lbl003_M.Width   := Trunc(((StrToInt(Matriz[3,1]) / totAtend) * 100) * stepSize) * 15;
        lbl003_M.Caption := '  ' + Matriz[3,0];
        pnl003_M.Caption := '  ' + Matriz[3,0];
        pnl003_M.Visible := True;
    end
    else
        pnl003_M.Visible := False;
//##############################################################################

    c.atendimentos.Matriz := nil ;
{
PIX      := 170;
Crédito  := 170;
dinheiro := 85;
debito   := 85;
}
end;

procedure TfrmMain.loadNextATD(Sender: TObject);
var
    vDataI: String;
    vTimeI: TTime;
    vDataA: TDate;
    vI    : Integer;
begin
    try
        // inicializa as variaveis
        vDataA := Date; // pega a data atual
        vTimeI := Time; // pega a hora atual
        vDataI := FormatDateTime('dd/mm/yyyy', vDataA); // armazena a data inicial

        // verifica se a hora atual é maior que a hora final do expediente
        if Time > StrToTime(gvHExpF) then
        begin
            vDataA := IncDay(Date, 1); // incrementa a data
            vTimeI := IncHour(StrToTime(gvHExpI), -1); // seta a hora para a primeira hora do expediente
        end;

        // faz a busca 50x
        for vI := 0 to 45 do
            // se não tiver atendimento na data especificada
            if not(atdSearchOne(FormatDateTime('yyyy-mm-dd', vDataA), 'A')) then
            begin
                vDataA := IncDay(vDataA, 1); // incrementa a data
                vTimeI := IncHour(StrToTime(gvHExpI), -1); // seta a hora para a primeira hora do expediente
            end
            else
            begin
//                showMsg({janela de ogigem}    Self.Caption,
//                        {título da mensagem}  'Agendamentos',
//                        {mensagem ao usuário} 'Nenhum agendamento foi encontrato entre os dias ' +
//                                              vDataI + ' e ' + FormatDateTime('', vDataA),
//                        {caminho do ícone}    'exclamation', {check/error/question/exclamation}
//                        {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
//                        {nome do link}        '',
//                        {link}                '');

                Break;
            end;

        // faz a busca do primeiro atendimento do dia
        if c.atendimentos.getNextATD(FormatDateTime('yyyy-mm-dd', vDataA),
                                      FormatDateTime('hh:MM', vTimeI)) then
        begin
            pnlNextATD.Tag       :=                         vcCLK_ATD_ID;
            lblPES_NOME.Caption  :=                         vcCLK_PES_NOME;
            lblPRC_NOME.Caption  :=                         vcCLK_PRC_NOME;
            lblATD_DATA.Caption  :=                         vcCLK_ATD_DATA;
            lblATD_HORA.Caption  :=                    Copy(vcCLK_ATD_HORA, 1, 5);
            lblATD_VALOR.Caption := FormatMoney((StrToFloat(vcCLK_ATD_VALOR)));

            try
                if vcCLK_PES_AVATAR <> '' then
                    imgAvatar.Picture.LoadFromFile(exePathRequest +
                        'images\pessoas\' + vcCLK_PES_AVATAR + '.jpg')
                else
                    imgAvatar.Picture.LoadFromFile(exePathRequest +
                        'images\pessoas\00.png');
            except
                imgAvatar.Visible := not(vcCLK_PES_AVATAR = '');
            end;
        end;
    finally
        pnlNextATD.Visible := not(vcCLK_ATD_ID = 0);
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

procedure TfrmMain.finishPreviousATD(Sender: TObject);
var
    vDataI: String;
//    vTimeI: TTime;
    vDataA: TDate;
    vI    : Integer;
begin
    try
        // inicializa as variaveis
        vDataA := Date; // pega a data atual
//        vTimeI := Time; // pega a hora atual
        vDataI := FormatDateTime('dd/mm/yyyy', vDataA); // armazena a data inicial

        // verifica se a hora atual é maior que a hora final do expediente
        if Time < StrToTime(gvHExpI) then
        begin
            vDataA := IncDay(Date, -1); // decrementa a data
//            vTimeI := IncHour(StrToTime(gvHExpF), 1); // seta a hora para a primeira hora do expediente
        end;

        // faz a busca 50x
        for vI := 0 to 45 do
            // se não tiver atendimento na data especificada
            if not(atdSearchOne(FormatDateTime('yyyy-mm-dd', vDataA), 'A')) then
            begin
                vDataA := IncDay(vDataA, - 1); // decrementa a data
//                vTimeI := IncHour(StrToTime(gvHExpI), 1); // seta a hora para a primeira hora do expediente
            end
            else
            begin
                // verifica se o atendimento já passou
                if gvATD_HORA < Time then
                    c.atendimentos.atdChange(gvATD_ID, 'F'); // atualiza atendimento para finalizado

                Break;
            end;
    finally
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

    // carrega as informações no grafico
    loadGraphic();

    // atualiza o atendimento para finalizado
    finishPreviousATD(Sender);

    // carrega o proximo aendimento no card
    loadNextATD(Sender);

    // carrega as agendas
    iSchedulingBox(Self, pnlAtendimentos, gvDate);
end;

procedure TfrmMain.tmrClockTimer(Sender: TObject);
begin
    // define a hora
    ATime(lblHou, lblMin, lblSec);

    tmrAgendas.Enabled := pnlAgenda.Visible;
end;

procedure TfrmMain.visiblePanel(vpStatus: Boolean);
begin
// tecer melhorias no futuro
    pnlCenter.Visible := vpStatus;
    pnlAgenda.Visible := vpStatus;
end;

end.

var
  V_Hora,V_Hora_1,V_Nova_Hora :TDateTime;
  V_Qt_Segundos,V_Qt_Minutos,V_Qt_Horas: integer;

SOMA SEGUNDOS A UMA HORA
v_Nova_Hora := IncSecond(V_Hora,V_Qt_Segundos);

SUBTRAI SEGUNDOS DE UMA HORA
v_Nova_Hora := IncSecond(V_Hora,(V_Qt_Segundos*(-1)));

SOMA MINUTOS A UMA HORA
v_Nova_Hora := IncMinute(V_Hora,V_Qt_Minutos);

SUBTRAI MINUTOS DE UMA HORA
v_Nova_Hora := IncMinute(V_Hora,(V_Qt_Minutos*(-1)));

SOMA HORAS A UMA HORA
v_Nova_Hora := IncHour(V_Hora,V_Qt_Horas);

SUBTRAI HORAS DE UMA HORA
v_Nova_Hora := IncHour(V_Hora,(V_Qt_Horas*(-1)));

DIFERENÇA DE SEGUNDOS ENTRE DUAS HORAS
V_Nova_Hora := IntToStr(SecondsBetween(V_Hora,V_Hora_1));

DIFERENÇA DE MINUTOS ENTRE DUAS HORAS
V_Nora_Nova := IntToStr(MinutesBetween(V_Hora,V_Hora_1));

DIFERENÇA DE HORAS ENTRE DUAS HORAS
V_Nora_Nova := IntToStr(HoursBetween(V_Hora,V_Hora_1));

DIFERENÇA ENTRE DUAS HORAS
V_Nova_Hora := (StrToTime('23:59:59') + StrToTime('00:00:01')-V_Hora)+V_Hora_1;

