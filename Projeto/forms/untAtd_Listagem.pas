unit untAtd_Listagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untStandard, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, ArCalendarAppointmentNotice, Vcl.StdCtrls;

type
  TfrmAtd_Listagem = class(TfrmStandard)
    pnlAtendimentos: TPanel;
    Label13: TLabel;
    ArCalendarAppointmentNotice1: TArCalendarAppointmentNotice;
    ArCalendarAppointmentNotice2: TArCalendarAppointmentNotice;
    procedure ArCalendarAppointmentNotice1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAtd_Listagem: TfrmAtd_Listagem;

implementation

{$R *.dfm}

uses untFunctions, untAtd_Cadastro;

procedure TfrmAtd_Listagem.ArCalendarAppointmentNotice1Click(Sender: TObject);
begin
  inherited;
    // inicializa o form
    ToCreate(frmatd_Cadastro, Tfrmatd_Cadastro, Self, nil, nil);
end;

end.
