unit untDBConnect;

interface

uses
  System.SysUtils, System.Classes, System.IniFiles,

  Vcl.Forms,

  Data.DB,

  FireDAC.Phys.MySQLDef, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Phys,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Error, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys.MySQL, FireDAC.Stan.Def,
  FireDAC.Comp.UI, FireDAC.Comp.Client, FireDAC.FMXUI.Wait, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase


  ;

type
  TfrmDBConnect = class(TDataModule)

    FDDriverLink: TFDPhysMySQLDriverLink;
    FDConnect: TFDConnection;
    FDWaitCursor: TFDGUIxWaitCursor;

    function ReadINI: Boolean;
    function DBConnect: Boolean;
    function DBDisconnect: Boolean;

    procedure SaveINI;

    private
    { Private declarations }
        vINIPath: string;
        vINIFile: TIniFile;

    public
    { Public declarations }
        fError  : string;

    end;

var
  frmDBConnect: TfrmDBConnect;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses untFunctions, untSource;

{$R *.dfm}

{ TfrmDBConnect }

function TfrmDBConnect.DBConnect: Boolean;
begin
    // define a resposta como verdadeira
    Result := True;

    // limpa os parametros de conexão
    FDConnect.Params.Clear;

    // seta os parametros de conexão
    FDConnect.Params.Add('Server='    + gvServer);
    FDConnect.Params.Add('user_name=' + gvUser);
    FDConnect.Params.Add('password='  + gvPass);
    FDConnect.Params.Add('port='      + gvPort);
    FDConnect.Params.Add('Database='  + gvBase);
    FDConnect.Params.Add('DriverID='  + gvDriver);

    try
        // faz a conexão com o banco de dados
        FDConnect.Connected := True;
    except
        // se um erro ocorrer
        on Err:Exception do
        begin
            // cria a mensagem de erro
            fError := Err.Message;

            showMsg({janela de ogigem}    'Erro de conexão!',
                    {título da mensagem}  'O sistema não pode se conectar ao banco de dados!',
                    {mensagem ao usuário} fError + sLineBreak + sLineBreak +
                                          'Tente novamente...' + sLineBreak + sLineBreak +
                                          'Se o problema persistir contate o suporte!',
                    {caminho do ícone}    'error', {check/error/question/exclamation}
                    {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                    {nome do link}        '',
                    {link}                ''
                   );

            // define uma resposta como falsa
            Result := False;
        end;
    end;
end;

function TfrmDBConnect.DBDisconnect: Boolean;
begin
    // desconecta do banco
    FDConnect.Connected := False;
end;

function TfrmDBConnect.ReadINI: Boolean;
var
    vScheduleInterval,
    vScheduleRefresh: string;
begin
    Result := True;

    // pega o caminho e o nome do executavel e troca a extensão pra 'ini'
    vINIPath := ChangeFileExt(Application.ExeName, '.ini');

    // cria e abre o arquivo 'ini'
    vINIFile := TIniFile.Create(vINIPath);

    try
        // verifica se o arquivo existe
        if not FileExists(vINIPath) then
            Exit;

        try
            // passa os valores do arquivo ini para as variaveis
            gvServer           :=        vINIFile.ReadString('DBAccessConfig', 'Server'          , ''      );
            gvBase             :=        vINIFile.ReadString('DBAccessConfig', 'Base'            , ''      );
            gvPort             :=        vINIFile.ReadString('DBAccessConfig', 'Port'            , ''      );
            gvDriver           :=        vINIFile.ReadString('DBAccessConfig', 'Driver'          , ''      );
            gvUser             :=        vINIFile.ReadString('DBAccessConfig', 'User'            , ''      );
            gvPass             := Crypto(vINIFile.ReadString('DBAccessConfig', 'Pass'            , ''     ));
//            gvPass             :=        vINIFile.ReadString('DBAccessConfig', 'Pass'             , ''     );

            gvHExpI            :=        vINIFile.ReadString('DBAccessConfig', 'HExpI'           , '08:00' );
            gvHExpF            :=        vINIFile.ReadString('DBAccessConfig', 'HExpF'           , '18:00' );
             vScheduleInterval :=        vINIFile.ReadString('DBAccessConfig', 'ScheduleInterval', '60'    );
             vScheduleRefresh  :=        vINIFile.ReadString('DBAccessConfig', 'ScheduleRefresh' , '30'    );

            gvScheduleInterval := StrToInt(vScheduleInterval);
            gvScheduleRefresh  := StrToInt(vScheduleRefresh ) * (1000 * 60);

        except
            Result  := False;
        end;
    finally
        vINIFile.Free;
    end;
end;

procedure TfrmDBConnect.SaveINI;
begin
    // pega o caminho e o nome do executavel e troca a extensão pra 'ini'
    vINIPath := ChangeFileExt(Application.ExeName, '.ini');

    // cria e abre o arquivo 'ini'
    vINIFile := TIniFile.Create(vINIPath);

    try
        // grava os valores no arquivo ini
        vINIFile.WriteString('DBAccessConfig', 'Server',            gvServer);
        vINIFile.WriteString('DBAccessConfig', 'Base'  ,            gvBase  );
        vINIFile.WriteString('DBAccessConfig', 'Port'  ,            gvPort  );
        vINIFile.WriteString('DBAccessConfig', 'Driver',            gvDriver);
        vINIFile.WriteString('DBAccessConfig', 'User'  ,            gvUser  );
        vINIFile.WriteString('DBAccessConfig', 'Pass'  ,     Crypto(gvPass) );
        vINIFile.WriteString('DBAccessConfig', 'Pass'  ,            gvPass  );
    finally
        vINIFile.free;
    end;
end;

end.


