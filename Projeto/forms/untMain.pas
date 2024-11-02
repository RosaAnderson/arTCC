unit untMain;

interface

uses
  Winapi.Windows, Winapi.Messages,

  System.SysUtils, System.Variants, System.Classes,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmMain = class(TForm)
    pnlHoje: TPanel;
    pboxTopo: TPaintBox;
    lblHoje: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;

    procedure TopoPaint(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses untFunctions, untSource, untStyle;

procedure TfrmMain.TopoPaint(Sender: TObject);
const
    clStart: TColor  = $002A5320;
    clEnd  : TColor  = $00A0D5A9;
begin
    // aplica o gradiente no objeto
    setGradient(Self, (Sender as TPaintBox), clStart, clEnd);
end;

end.
