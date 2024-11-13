unit untMessages;

interface

uses
  untStandard,

  MMSystem,

  Winapi.Windows, Winapi.Messages,

  System.SysUtils, System.Variants, System.Classes,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TfrmMessages = class(TfrmStandard)
    imgIcon: TImage;
    lblTituloMsg: TLabel;
    lblMensagem: TLabel;
    btnConfirm: TSpeedButton;
    btnCancel: TSpeedButton;
    pnlStatus: TPanel;
    pnlButtonPri: TPanel;
    shpPrimary: TShape;
    btnPrimary: TSpeedButton;
    pnlButtonSec: TPanel;
    shpSecondary: TShape;
    btnSecondary: TSpeedButton;
    pnlIcons: TPanel;
    imgQuestion: TImage;
    imgError: TImage;
    imgCheck: TImage;
    imgExclamation: TImage;

    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure btnAction(Sender: TObject);

  private
    { Private declarations }
    vImage    : TImage;

  public
    { Public declarations }
    rMessage: Boolean;

    vTituloJan,
    vTituloMen,
    vMenssagem,
    vIcone,
    vButton,
    vNameLink,
    vLink: string;

  end;

var
  frmMessages: TfrmMessages;

implementation

{$R *.dfm}

procedure TfrmMessages.btnAction(Sender: TObject);
begin
    if (Sender as TSpeedButton).Hint = LowerCase('link') then
    begin
        // abre o link
//        execPath('open', pchar(vLink));
    end
    else
    begin
        // verifica se � o bot�o cancel
        if (Sender = btnCancel) or (Sender = btnCloseForm) then
            rMessage := false;

        // verifica se � o bot�o confirm
        if Sender = btnConfirm then
            rMessage := True;
    end;

    // fecha o formul�rio
    Close;
end;

procedure TfrmMessages.FormActivate(Sender: TObject);
var
    i: integer;
begin
//  inherited;
    // passa por todos os caomponentes do form
    for i := 0 to (Self.ComponentCount - 1) do
    begin
        // verifica se � um image
        if (Self.Components[i] is TImage) then
        begin
            // passa o nome do objeto para a variavel
            vImage := (Self.Components[i] as TImage);

            // verifica se o nome do objeto coincide com o nome solicitado
            if LowerCase(vImage.Name) = 'img' + vIcone then
                // atribui a imagem
                imgIcon.Picture := vImage.Picture;
        end;
    end;

    // define a resposta do fromul�rio
    rMessage := False;

    // preenche os objetos com os dados da fun��o
    lblTitleForm.Caption := vTituloJan;
    lblTituloMsg.Caption := vTituloMen;
    lblMensagem.Caption  := vMenssagem;

    // valida os bot�es da janela
    if vButton = 'y/n' then
    begin
        // Define o caption do bot�o
        btnConfirm.Caption := 'Sim (Enter)';
        btnCancel.Caption  := 'N�o (Esc)';
    end
    else if vButton = 'y/n/a' then
    begin
        //
    end
    else if vButton = 'ok' then
    begin
        // Oculta o bot�o
        btnConfirm.Visible := False;

        // Define o caption do bot�o
        btnCancel.Caption   := 'Ok (Enter)';
    end
    else if vButton = 'ok/cancel' then
    begin
        // ainda n�o programado
    end
    else if vButton = 'ok/link' then
    begin
        // Define o caption do bot�o
        btnConfirm.Caption := 'Ok (Enter)';
        btnCancel.Caption  := vNameLink;
        btnCancel.Hint     := LowerCase('link');
    end;

    // descarrega o objeto
    vImage.Free;
end;

procedure TfrmMessages.FormCreate(Sender: TObject);
begin
    // define o tamanho do form
    Self.ClientHeight := 260;
    Self.ClientWidth  := 660;

    //
    PlaySound('C:\',1 ,SND_ASYNC);

  inherited;
end;

procedure TfrmMessages.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  inherited;
    // se a tecla <enter> for pressionada
    if key = #13 then
    begin
        key := #0;
        // executa o codigo do bot�o "confirm"
        btnAction(btnConfirm);
    end;

    // se a tecla <esc> for pressionada
    if key = #27 then
    begin
        key := #0;
        // executa o codigo do bot�o "cancel"
        btnAction(btnCancel);
    end;
end;

end.

    showMsg({janela de ogigem}    Self.Caption,
            {t�tulo da mensagem}  '',
            {mensagem ao usu�rio} '',
            {caminho do �cone}    '', {check/error/question/exclamation}
            {bot�o}               '', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
            {nome do link}        '',
            {link}                ''
           );


