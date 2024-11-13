unit untCom_Listagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untStandard, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, ArCalendarEmptyNotice, Vcl.StdCtrls;

type
  TfrmCom_Listagem = class(TfrmStandard)

    procedure ArCalendarEmptyNotice1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCom_Listagem: TfrmCom_Listagem;

implementation

{$R *.dfm}

uses untStyle, untFunctions, untCom_Cadastro;

procedure TfrmCom_Listagem.ArCalendarEmptyNotice1Click(Sender: TObject);
begin
  inherited;
    // fecha a janela
    Close;

    sleep(500);

    // inicializa o form
    ToCreate(frmCom_Cadastro, TfrmCom_Cadastro, Self, nil, nil);
end;

end.
