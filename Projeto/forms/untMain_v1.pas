unit untMain_v1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untStandard, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Buttons, Vcl.WinXCalendars, Vcl.Imaging.jpeg,
  Vcl.ComCtrls, Vcl.Grids, Vcl.Samples.Calendar, ArEdit,
  ArCalendarAppointmentNotice, ArCalendarEmptyNotice, ArFolderPath;

type
  TfrmMain_v1 = class(TfrmStandard)
    pnlSideBar: TPanel;
    shpSideLine: TShape;
    pnlSideButtonSpace00: TPanel;
    tmrClock: TTimer;
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
    Shape18: TShape;
    pnlExit: TPanel;
    imgClose: TImage;
    Label5: TLabel;
    pnlConfig: TPanel;
    imgConfig: TImage;
    Label1: TLabel;
    pnlSideButton04: TPanel;
    Image1: TImage;
    Label2: TLabel;
    pnlSideButton01: TPanel;
    imgCliente: TImage;
    Label3: TLabel;
    pnlSideButton02: TPanel;
    imgCompromissos: TImage;
    Label4: TLabel;
    pnlSideButton00: TPanel;
    Image2: TImage;
    Label6: TLabel;
    pnlSideButton03: TPanel;
    imgAtendimentos: TImage;
    Label7: TLabel;
    pnlSideButton05: TPanel;
    Image3: TImage;
    Label8: TLabel;
    pnlAgenda: TPanel;
    pnlHoje: TPanel;
    pboxHoje: TPaintBox;
    lblHoje: TLabel;
    pnlAtendimentos: TPanel;
    lblAtendimentos: TLabel;
    pnlCompromissos: TPanel;
    lblCompromisso: TLabel;
    ArCalendarEmptyNotice2: TArCalendarEmptyNotice;
    pnlSideButtonSpace10: TPanel;
    pnlDashboard: TPanel;
    ArCalendarEmptyNotice1: TArCalendarEmptyNotice;
    Label11: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure imgCloseClick(Sender: TObject);

    procedure tmrClockTimer(Sender: TObject);

    procedure ToPaint(Sender: TObject);

    procedure imgClienteClick(Sender: TObject);
    procedure imgCompromissosClick(Sender: TObject);
    procedure imgAtendimentosClick(Sender: TObject);

    procedure CalendarClick(Sender: TObject);

    procedure ArCalendarEmptyNotice2Click(Sender: TObject);

    procedure imgLogoClick(Sender: TObject);
    procedure pnlAtendimentosClick(Sender: TObject);
    procedure ArCalendarEmptyNotice1Click(Sender: TObject);
    procedure imgConfigClick(Sender: TObject);


  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmMain_v1: TfrmMain_v1;

implementation

{$R *.dfm}

uses  untStyle, untFunctions, untSource,
        untLogin,
        untCli_Cadastro,
        untCom_Cadastro, untCom_Listagem,
        untAtd_Cadastro, untAtd_Listagem, untMain;


{ TfrmMain_v1 }

procedure TfrmMain_v1.toPaint(Sender: TObject);
begin
  inherited;
    // aplica o gradiente no objeto
    setGradient(Self, (Sender as TPaintBox), 0, 0);
end;

procedure TfrmMain_v1.ArCalendarEmptyNotice1Click(Sender: TObject);
begin
  inherited;
    // inicializa o form
    ToCreate(frmAtd_Cadastro, TfrmAtd_Cadastro, Self, nil, pnlAgenda);
end;

procedure TfrmMain_v1.ArCalendarEmptyNotice2Click(Sender: TObject);
begin
  inherited;
    // inicializa o form
    ToCreate(frmCom_Cadastro, TfrmCom_Cadastro, Self, nil, pnlAgenda);
end;

procedure TfrmMain_v1.CalendarClick(Sender: TObject);
begin
  inherited;
    // colca a data do calendario no label
    lblHoje.Caption := fullDAte(Calendar.Date);
end;

procedure TfrmMain_v1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
    // encerra o sistema
    Application.Terminate;
end;

procedure TfrmMain_v1.FormCreate(Sender: TObject);
begin
    // seta a data e a hora
    Calendar.Date  := Now;

    // define a hora
    ATime(lblHou, lblMin, lblSec);
    lblHoje.Caption := fullDAte(Now);

    // define o tamanho do form
    Self.ClientHeight := 700;
    Self.ClientWidth  := 1300;

    // cria o form
//    ToCreate(frmLogin, TfrmLogin, nil, nil, nil);

    // executa as funções do form padrão (precisa ficar no final)
    inherited;
end;

procedure TfrmMain_v1.imgAtendimentosClick(Sender: TObject);
begin
  inherited;
    // inicializa o form
    ToCreate(frmAtd_Listagem, TfrmAtd_Listagem, Self, nil, pnlAgenda);
end;

procedure TfrmMain_v1.imgClienteClick(Sender: TObject);
begin
  inherited;
    // inicializa o form
    ToCreate(frmCli_Cadastro, TfrmCli_Cadastro, Self, pnlDashboard, pnlAgenda);
end;

procedure TfrmMain_v1.imgCloseClick(Sender: TObject);
begin
  inherited;
    // fecha a janela
    Close;
end;

procedure TfrmMain_v1.imgCompromissosClick(Sender: TObject);
begin
  inherited;
    // inicializa o form
    ToCreate(frmCom_Listagem, TfrmCom_Listagem, Self, nil, pnlAgenda);
end;

procedure TfrmMain_v1.imgConfigClick(Sender: TObject);
begin
  inherited;
    // inicializa o form
    ToCreate(frmMain, TfrmMain, Self, nil, nil);
end;

procedure TfrmMain_v1.imgLogoClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmMain_v1.pnlAtendimentosClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmMain_v1.tmrClockTimer(Sender: TObject);
begin
  inherited;
    // define a hora
    ATime(lblHou, lblMin, lblSec);
end;

end.



// tamanho limite do campo
// 'Anderson Luiz dos Santos...' = 25c





chamando janelas
    // verifica se o form foi criado
    if not Assigned(frmCom_Listagem) then
        frmCom_Listagem := TfrmCom_Listagem.Create(Self);
//        Application.CreateForm(TfrmCom_Cadastro, frmCom_Cadastro); // cria o form

//    frmCom_list.Parent      := pnlDashboard; // define o local onde será iniciado o form
//    frmCom_list.Align       := alLeft;       // define a posição
//    frmCom_List.BorderStyle := bsNone;       // define a borda
    try
        frmCom_Listagem.ShowModal; // exibe o form
    finally
        frmCom_Listagem.Free;
    end;


