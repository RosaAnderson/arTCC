unit undDashboard;

interface

uses
  untStandard,

  Winapi.Windows, Winapi.Messages,

  System.SysUtils, System.Variants, System.Classes,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.WinXCalendars, Vcl.Buttons, Vcl.WinXCtrls,
  Vcl.WinXPickers, Vcl.ComCtrls, Vcl.Grids, Vcl.Samples.Calendar




  ;

type
  TfrmDashboard = class(TfrmStandard)
    shpBG: TShape;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDashboard: TfrmDashboard;

implementation

{$R *.dfm}


end.



