program arEasyCare;

uses
  midas,
  MidasLib,
  System.SysUtils,
  Vcl.Forms,
  untStandard in 'standards\untStandard.pas' {frmStandard},
  untComponents in 'support\untComponents.pas' {frmComponents},
  untColors in 'support\untColors.pas' {frmColors},
  untObjetos in 'support\untObjetos.pas' {Form1},
  e.log in 'class\e.log.pas',
  c.connection in 'class\c.connection.pas',
  c.pessoas in 'class\c.pessoas.pas',
  c.atendimentos in 'class\c.atendimentos.pas',
  c.procedimentos in 'class\c.procedimentos.pas',
  untDBConnect in 'modules\untDBConnect.pas' {frmDBConnect: TDataModule},
  untFunctions in 'functions\untFunctions.pas',
  untStyle in 'functions\untStyle.pas',
  untSource in 'sources\untSource.pas',
  untMessages in 'dialogs\untMessages.pas' {frmMessages},
  untLogin in 'dialogs\untLogin.pas' {frmLogin},
  untDark in 'dialogs\untDark.pas' {frmDark},
  untMain in 'forms\untMain.pas' {frmMain},
  untMain_v1 in 'forms\untMain_v1.pas' {frmMain_v1},
  undDashboard in 'forms\undDashboard.pas' {frmDashboard},
  untCli_Manutencao in 'forms\untCli_Manutencao.pas' {frmCli_Manutencao},
  untCli_Cadastro in 'forms\untCli_Cadastro.pas' {frmCli_Cadastro},
  untAtd_Cadastro in 'forms\untAtd_Cadastro.pas' {frmAtd_Cadastro},
  untAtd_Listagem in 'forms\untAtd_Listagem.pas' {frmAtd_Listagem},
  untCom_Cadastro in 'forms\untCom_Cadastro.pas' {frmCom_Cadastro},
  untCom_Listagem in 'forms\untCom_Listagem.pas' {frmCom_Listagem};

{$R *.res}

var
    vDBDriver: string = 'MySQL';

begin
    ReportMemoryLeaksOnShutdown := True;

    Application.Initialize;
//    sysDevTools := (DebugHook <> 0);
    ReportMemoryLeaksOnShutdown := (DebugHook <> 0);

    Application.CreateForm(TfrmDBConnect, frmDBConnect);
  Application.MainFormOnTaskbar := True;
    Application.Title := 'AR EasyCare - Sistema Gestão de Clínica Estética';
    Application.CreateForm(TfrmMain_v1, frmMain_v1);

    // lê os dados do arquivo de inicialização
    if not frmDBConnect.ReadINI then
    begin
        showMsg({janela de ogigem}    'Sistema',
                {título da mensagem}  'Inicialização do Sistema (sys.ini)',
                {mensagem ao usuário} 'O arquivo de configuração não foi carregado!',
                {caminho do ícone}    'error', {check/error/question/exclamation}
                {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
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
//            frmDBConnect.FDDriverLink.VendorLib := exePathRequest + 'dlls\libmysql_32.dll' // define o caminho da dll do MySQL
            frmDBConnect.FDDriverLink.VendorLib := 'd:\Área de Trabalho\arTCC\Projeto\dlls\libmysql_32.dll' // define o caminho da dll do MySQL
        else if vDBDriver = 'outro banco' then
            vDBDriver := 'mysql'; //troca no futuro

        // faz a conexão com o banco de dados
        if frmDBConnect.DBConnect then
//            getConfigs; // carrega as configurações do banco de dados
    end;

    Application.Run;
end.



// resolução notebook: 1366 x 768
// resolução máxima:   1300 x 660

