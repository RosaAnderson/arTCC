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
    procedure txtSenhaKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    vLogin: Integer;
  public
    { Public declarations }
    // procedure para fazer ENTER funcionar como tab.
    procedure CMDialogKey(var Msg: TWMKey); message CM_DIALOGKEY;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses untStyle, untDark, untColors, untFunctions;

procedure TfrmLogin.CMDialogKey(var Msg: TWMKey);
begin
    // faz uma validação de controle
    if not(Assigned(ActiveControl)) then
        Exit;

    // Faz o ENTER funcionar como TAB.
    if not(ActiveControl.Tag = 310779) then
        if Msg.Charcode = 13 then
            Msg.Charcode := 9;
    inherited;
end;

procedure TfrmLogin.btnPrimary_IClick(Sender: TObject);
begin
    // inicializa a variavel
    vLogin := 0;

    // aqui vão todos os codigos de validação do login!!!
    if not(LowerCase(txtUsuario.Text) = 'anderson') then
        vLogin := 1;
    if not(LowerCase(txtSenha.Text) = '#ar795400') then
        vLogin := 1;

    //
    if (vLogin > 0) then
    begin
        showMsg({janela de ogigem}    Self.Caption,
                {título da mensagem}  'Login inválido!',
                {mensagem ao usuário} 'Usuário ou senha inválidos!',
                {caminho do ícone}    'error', {check/error/question/exclamation}
                {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                {nome do link}        '',
                {link}                '');

        txtUsuario.SetFocus; //
    end
    else
        Close; // fecha a janela
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

procedure TfrmLogin.txtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
    // verifica se a tecla <enter> foi pressionada
    if Key = #13 then
    begin
        Key := #0; // impede que o som seja emitido

        //
        btnPrimary_IClick(Sender);
    end;
end;

end.
