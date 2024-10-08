unit untStandard;

interface

uses
  Winapi.Windows, Winapi.Messages,

  System.SysUtils, System.Variants, System.Classes,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TfrmStandard = class(TForm)
    shpEdgeForm: TShape;
    lblTitleForm: TLabel;
    shpTitleForm: TShape;
    btnCloseForm: TLabel;

    procedure objectStyle;

    procedure MoveForm(Sender: TObject; Shift: TShiftState; X, Y: Integer);

    procedure CloseEnter(Sender: TObject);
    procedure CloseLeave(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

    procedure btnCloseFormClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStandard: TfrmStandard;

implementation

{$R *.dfm}

uses untFuncions, untStyle, untConstants;

procedure TfrmStandard.objectStyle;
begin
    // oculta o fundo do bot�o fechar
    btnCloseForm.Transparent := True;
    btnCloseForm.Font.Color  := clBlack;
end;

procedure TfrmStandard.MoveForm(Sender: TObject; Shift: TShiftState; X, Y: Integer);
const
    sc_DragMove = $f012;
begin
    // permite mover o form
    ReleaseCapture;
    Perform(wm_SysCommand, sc_DragMove, 0);
end;

procedure TfrmStandard.CloseEnter(Sender: TObject);
begin
    // exibe o fundo
    btnCloseForm.Transparent := False;
    btnCloseForm.Font.Color  := clWhite;
end;

procedure TfrmStandard.CloseLeave(Sender: TObject);
begin
    // oculta o fundo
    btnCloseForm.Transparent := True;
    btnCloseForm.Font.Color  := clBlack;
end;

procedure TfrmStandard.FormCreate(Sender: TObject);
begin
    // seta as defini��es da janela
//    lblTitleForm.Caption := setWindowDefaults(Self);

    objectStyle;
end;

procedure TfrmStandard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    // desconstr�i o formul�rio.
    Action := caFree;
end;

procedure TfrmStandard.FormDestroy(Sender: TObject);
begin
    // Descarrega o formul�rio da mem�ria.
    Self := nil;
end;

procedure TfrmStandard.btnCloseFormClick(Sender: TObject);
begin
    // fecha a janela
    Close;
end;

end.




{
uses untConstantes, untLayout, untFuncao;

procedure CMDialogKey(var Msg:TWMKey); message CM_DIALOGKEY;
begin
    // Faz o ENTER funcionar como TAB.
    if not (ActiveControl.Tag = 7955) then
        if Msg.Charcode = 13 then
            Msg.Charcode := 9;
    inherited;
end;
}

//#######################################################################
//#######################################################################
    LoadMessage({t�tulo da janela}     Self.Caption,
                {t�tulo da mensagem}  '',
                {mensagem ao usu�rio} '',
                {caminho do �cone}    '', {check/error/question/exclamation}
                {bot�o}               '', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                {nome do link}        '',
                {link}                ''
               );
//#######################################################################
//#######################################################################
    SingleResult({DB TzConnection}        ,
                 {campo retornado}      '',
                 {tabela}               '',
                 {campo da pesquisa}    '',
                 {operador da pesquisa} '',
                 {valor da pesquisa}    '',
                 {where composto}       '',
                 {ordena��o (order by)} '');
//#######################################################################
//#######################################################################



Tamanho m�ximo da tela := '1366x768'
