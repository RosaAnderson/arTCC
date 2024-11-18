program arEasyCare;

uses
  midas,
  MidasLib,
  System.SysUtils,
  Vcl.Forms,
  untStandard in 'standards\untStandard.pas' {frmStandard},
  untComponents in 'support\untComponents.pas' {frmComponents},
  untColors in 'support\untColors.pas' {frmColors},
  e.log in 'class\e.log.pas',
  c.connection in 'class\c.connection.pas',
  c.pessoas in 'class\c.pessoas.pas',
  c.forma_pgto in 'class\c.forma_pgto.pas',
  c.atendimentos in 'class\c.atendimentos.pas',
  c.procedimentos in 'class\c.procedimentos.pas',
  c.compromissos in 'class\c.compromissos.pas',
  untFunctions in 'functions\untFunctions.pas',
  untStyle in 'functions\untStyle.pas',
  untObjects in 'functions\untObjects.pas',
  untPrepareMessage in 'functions\untPrepareMessage.pas',
  untSource in 'sources\untSource.pas',
  untDBConnect in 'modules\untDBConnect.pas' {frmDBConnect: TDataModule},
  untMessages in 'dialogs\untMessages.pas' {frmMessages},
  untLogin in 'dialogs\untLogin.pas' {frmLogin},
  untDark in 'dialogs\untDark.pas' {frmDark},
  untMain in 'forms\untMain.pas' {frmMain},
  undDashboard in 'forms\undDashboard.pas' {frmDashboard},
  untCli_Manutencao in 'forms\untCli_Manutencao.pas' {frmCli_Manutencao},
  untCli_Cadastro in 'forms\untCli_Cadastro.pas' {frmCli_Cadastro},
  untAtd_Cadastro in 'forms\untAtd_Cadastro.pas' {frmAtd_Cadastro},
  untAtd_Listagem in 'forms\untAtd_Listagem.pas' {frmAtd_Listagem},
  untCom_Cadastro in 'forms\untCom_Cadastro.pas' {frmCom_Cadastro},
  untCom_Listagem in 'forms\untCom_Listagem.pas' {frmCom_Listagem},
  untLst_Registro in 'forms\untLst_Registro.pas' {frmLst_Registro},
  untSnd_Mensagem in 'forms\untSnd_Mensagem.pas' {frmSnd_Mensagem},
  untAlarm in 'dialogs\untAlarm.pas' {frmAlarm};

{$R *.res}

var
    vDBDriver: string = 'MySQL';

begin
    Application.Initialize;
    // se estiver em Debug
    if (DebugHook <> 0) then
    begin
        gvScheduleRefresh := (1000 * 45);
        gvHExpI           := '06:00';
        gvHExpF           := '23:00';
    end;

//    sysDevTools := (DebugHook <> 0);
    ReportMemoryLeaksOnShutdown := (DebugHook <> 0);

    Application.CreateForm(TfrmDBConnect, frmDBConnect);

    Application.MainFormOnTaskbar := True;
    Application.Title := gcAppTitle;

    // define a data inicial
    gvDate := Now;

    Application.CreateForm(TfrmMain, frmMain);

    // l� os dados do arquivo de inicializa��o
    if not frmDBConnect.ReadINI then
    begin
        showMsg({janela de ogigem}    'Sistema',
                {t�tulo da mensagem}  'Inicializa��o do Sistema (sys.ini)',
                {mensagem ao usu�rio} 'O arquivo de configura��o n�o foi carregado!',
                {caminho do �cone}    'error', {check/error/question/exclamation}
                {bot�o}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                {nome do link}        '',
                {link}                ''
               );

        Application.Terminate;
    end
    else
    begin
        // define o driver
        vDBDriver := LowerCase(gvDriver);

        // verifica qual driver usar
        if vDBDriver = 'mysql' then
        begin
            frmDBConnect.FDDriverLink.VendorLib := exePathRequest + 'dlls\libmysql_32.dll'; // define o caminho da dll do MySQL
//            frmDBConnect.FDDriverLink.VendorLib := 'd:\�rea de Trabalho\arTCC\Projeto\dlls\libmysql_32.dll'; // define o caminho da dll do MySQL
        end
        else if vDBDriver = 'outro banco' then
            vDBDriver := 'mysql'; //troca no futuro

        // faz a conex�o com o banco de dados
        if frmDBConnect.DBConnect then
//            getConfigs; // carrega as configura��es do banco de dados
    end;

    Application.Run;
end.



// resolu��o notebook: 1366 x 768 ** justificar o tamanho escolhido
// resolu��o m�xima:   1300 x 660


'{'#$D#$A'    "result": "success",'#$D#$A'    "message_id": 233286111,'#$D#$A'    "contact_phone_number": "5514996905500",'#$D#$A'    "phone_state": "Conectado"'#$D#$A'}'
'{'#$D#$A'    "result": "fail",'#$D#$A'    "result_message": "contact_phone_number empty"'#$D#$A'}'
