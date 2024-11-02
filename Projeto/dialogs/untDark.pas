unit untDark;

interface

uses
  Winapi.Windows, Winapi.Messages,

  System.SysUtils, System.Variants, System.Classes,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmDark = class(TForm)

    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    class var FInstance: tfrmDark;

    procedure scrPosition();

  public
    { Public declarations }
    class function getInstace(const AParent: TForm): TfrmDark;

  end;

var
  frmDark: TfrmDark;

implementation

{$R *.dfm}

{ TfrmDark }

procedure TfrmDark.FormShow(Sender: TObject);
begin
    scrPosition;
end;

class function TfrmDark.getInstace(const AParent: TForm): TfrmDark;
begin
    //
    FInstance := TfrmDark.Create(AParent);

    Result    := FInstance;
end;

procedure TfrmDark.scrPosition;
begin
    //
    Self.Width  := Screen.Width;
    Self.Height := Screen.Height;
    Self.Top    := 0;
    Self.Left   := 0;
end;

end.
