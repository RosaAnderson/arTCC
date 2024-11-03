unit untLogin;

interface

uses ArEdit,

  Winapi.Windows, Winapi.Messages,

  System.SysUtils, System.Variants, System.Classes,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg;

type
  TfrmLogin = class(TForm)
    imgLogo: TImage;
    pnlButtonPri_I: TPanel;
    shpButtonPri: TShape;
    btnPrimary_I: TSpeedButton;
    pnlButtonSec_I: TPanel;
    shpButtonSec: TShape;
    btnSecondary_I: TSpeedButton;
    shpEdgeForm: TShape;
    Panel1: TPanel;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    pnlUsuario: TPanel;
    Label2: TLabel;
    shpUsuario: TShape;
    txtUsuario: TArEdit;
    pnlSenha: TPanel;
    Label1: TLabel;
    shpSenha: TShape;
    txtSenha: TArEdit;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

    procedure btnSecondary_IClick(Sender: TObject);
    procedure btnPrimary_IClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses untStyle, untDark, untColors, untMain_v1;

procedure TfrmLogin.btnPrimary_IClick(Sender: TObject);
begin
    // aqui vão todos os codigos de validação do login!!!

    // fecha a janela
    Close;
end;

procedure TfrmLogin.btnSecondary_IClick(Sender: TObject);
begin
    // encerra a aplicação
    Application.Terminate;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    // desconstrói o formulário.
    Action := caFree;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
    // seta o padrão da janela
    setStyleWindow(Self);

    // posiciona a logo
    imgLogo.Left := Trunc(Self.ClientWidth / 2) - Trunc(imgLogo.Width / 2);
    imgLogo.Top  := 25;
end;

procedure TfrmLogin.FormDestroy(Sender: TObject);
begin
    // Descarrega o formulário da memória.
    frmLogin := nil;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
    // "esmaece" o fundo
    TfrmDark.getinstace(Self).Show;
end;

end.
