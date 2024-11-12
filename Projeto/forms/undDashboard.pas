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
    pnlSideBar: TPanel;
    Shape1: TShape;
    imgConfig: TImage;
    imgClose: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    imgAgenda: TImage;
    imgCliente: TImage;
    shpBG: TShape;
    pnlAtendimentos: TPanel;
    Panel4: TPanel;
    Label2: TLabel;
    Label0: TLabel;
    Shape2: TShape;
    SpeedButton1: TSpeedButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    Shape3: TShape;
    SpeedButton2: TSpeedButton;
    Panel2: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Shape4: TShape;
    SpeedButton3: TSpeedButton;
    pnlAtd: TPanel;
    lblAtdCliente: TLabel;
    lblAtdHora: TLabel;
    shpAtdBorda: TShape;
    btnAtd: TSpeedButton;
    Panel5: TPanel;
    Label3: TLabel;
    Label7: TLabel;
    Shape5: TShape;
    SpeedButton4: TSpeedButton;
    pnlSpace: TPanel;

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



