unit untMessages;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untStandard, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TfrmMessages = class(TfrmStandard)
    imgIcon: TImage;
    lblTituloMsg: TLabel;
    lblMensagem: TLabel;
    btnConfirm: TSpeedButton;
    btnCancel: TSpeedButton;
    Panel1: TPanel;
    imgQuestion: TImage;
    imgError: TImage;
    imgCheck: TImage;
    imgExclamation: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMessages: TfrmMessages;

implementation

{$R *.dfm}

end.
