unit untLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, ArEdit,
  Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TfrmLogin = class(TForm)
    txtUser: TArEdit;
    txtPass: TArEdit;
    imgLogo: TImage;
    pnlButtonPri_I: TPanel;
    shpButtonPri: TShape;
    btnPrimary_I: TSpeedButton;
    pnlButtonSec_I: TPanel;
    shpButtonSec: TShape;
    btnSecondary_I: TSpeedButton;

    procedure FormCreate(Sender: TObject);

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

uses untStyle;

procedure TfrmLogin.btnPrimary_IClick(Sender: TObject);
begin
    //

end;

procedure TfrmLogin.btnSecondary_IClick(Sender: TObject);
begin
    //
    Application.Terminate;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
    //
    setStyleWindow(Self);

    //
    imgLogo.Left := Trunc(Self.ClientWidth / 2) - Trunc(imgLogo.Width / 2);
    imgLogo.Top  := 50;
end;

end.
