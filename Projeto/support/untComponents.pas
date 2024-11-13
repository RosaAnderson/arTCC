unit untComponents;

interface

uses
  Winapi.Windows, Winapi.Messages,

  System.SysUtils, System.Variants, System.Classes,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ComCtrls,
  ArEdit, Vcl.WinXCtrls, Vcl.DBCGrids;

type
  TfrmComponents = class(TForm)
    pnlFooter: TPanel;
    pnlPageControl: TPanel;
    pgcControl: TPageControl;
    tab001: TTabSheet;
    Image1: TImage;
    tab002: TTabSheet;
    Image2: TImage;
    tab003: TTabSheet;
    Image3: TImage;
    pnlTabBtn: TPanel;
    pnl001: TPanel;
    btn001: TSpeedButton;
    pnl003: TPanel;
    btn003: TSpeedButton;
    pnl002: TPanel;
    btn002: TSpeedButton;
    txtNewNameDB: TEdit;
    Panel1: TPanel;
    btnSearch: TImage;
    Edit1: TEdit;
    pnlButtonPri_I: TPanel;
    shpButtonPri: TShape;
    btnPrimary_I: TSpeedButton;
    pnlButtonSec_I: TPanel;
    shpButtonSec: TShape;
    btnSecondary_I: TSpeedButton;
    pnlAdditional: TScrollBox;
    shpTitleDescricao: TShape;
    lblTitleDescricao: TLabel;
    pnlAtividade: TPanel;
    shpEdge_panel: TShape;
    lblTitleBusca: TLabel;
    shpTitleBusca: TShape;
    Panel3: TPanel;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    pnlMenuCad: TPanel;
    shpEdgeMenu: TShape;
    pnl1000: TPanel;
    img1000: TImage;
    mniButton1000: TSpeedButton;
    pnl1001: TPanel;
    img1001: TImage;
    mniButton1001: TSpeedButton;
    pnl1002: TPanel;
    img1002: TImage;
    mniButton1002: TSpeedButton;
    pnl1014: TPanel;
    img1014: TImage;
    mniButton1014: TSpeedButton;
    pnl1010: TPanel;
    img1010: TImage;
    mniButton1010: TSpeedButton;
    pnl1009: TPanel;
    img1009: TImage;
    mniButton1009: TSpeedButton;
    pnl1008: TPanel;
    img1008: TImage;
    mniButton1008: TSpeedButton;
    pnl1007: TPanel;
    img1007: TImage;
    mniButton1007: TSpeedButton;
    pnl1006: TPanel;
    img1006: TImage;
    mniButton1006: TSpeedButton;
    pnl1005: TPanel;
    img1005: TImage;
    mniButton1005: TSpeedButton;
    pnl1004: TPanel;
    img1004: TImage;
    mniButton1004: TSpeedButton;
    pnl1003: TPanel;
    img1003: TImage;
    mniButton1003: TSpeedButton;
    pnl1011: TPanel;
    img1011: TImage;
    mniButton1011: TSpeedButton;
    pnl1012: TPanel;
    img1012: TImage;
    mniButton1012: TSpeedButton;
    pnl1013: TPanel;
    img1013: TImage;
    mniButton1013: TSpeedButton;
    pnlStatus: TPanel;
    pnlButtonPri: TPanel;
    shpPrimary: TShape;
    btnPrimary: TSpeedButton;
    pnlButtonSec: TPanel;
    shpSecondary: TShape;
    btnSecondary: TSpeedButton;
    navBOClassificacao: TDBNavigator;
    Panel2: TPanel;
    Label6: TLabel;
    SearchBox1: TSearchBox;
    dgrClock: TPaintBox;
    GridPanel1: TGridPanel;
    DBCtrlGrid1: TDBCtrlGrid;
    Panel4: TPanel;
    Panel5: TPanel;
    pnl01: TPanel;
    lbl01: TLabel;
    btn01: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmComponents: TfrmComponents;

implementation

{$R *.dfm}

end.
