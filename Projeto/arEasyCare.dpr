program arEasyCare;

uses
  Vcl.Forms,
  untFuncions in 'functions\untFuncions.pas',
  untStyle in 'functions\untStyle.pas',
  untConstants in 'sources\untConstants.pas',
  untComponents in 'support\untComponents.pas' {frmComponents},
  untStandard in 'standards\untStandard.pas' {frmStandard},
  untLogin in 'dialogs\untLogin.pas' {frmLogin},
  untMessages in 'dialogs\untMessages.pas' {frmMessages},
  undDashboard in 'forms\undDashboard.pas' {frmDashboard},
  untClient_Cad in 'forms\untClient_Cad.pas' {frmClient_Cad},
  untScheduling in 'forms\untScheduling.pas' {frmScheduling},
  untNotification in 'forms\untNotification.pas' {frmNotification};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmNotification, frmNotification);
  Application.Run;
end.








// resolu��o notebook: 1366 x 768
// resolu��o m�xima:   1300 x 660
