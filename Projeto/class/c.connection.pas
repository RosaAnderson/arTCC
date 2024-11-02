unit c.connection;

interface

uses
    System.SysUtils, System.IniFiles,

    Vcl.Forms,

    FireDAC.Comp.Client, FireDAC.Stan.Intf;

type
    TConnection = class

    private
        {Private declarations}
        fConnect: TFDConnection;
        fBase   : string;
        fError  : string;
        fPass   : string;
        fPort   : string;
        fServer : string;
        fUser   : string;
        fDriver : string;

        vINIPath: string;
        vINIFile: TIniFile;

    public
        {Public declarations}
        constructor Create(ccConnection: TFDConnection);
        destructor  Destroy; override;

        procedure SaveINI;

        function ReadINI:boolean;
        function BDConnect: Boolean;


        // cria as propriedades da classe
        property cConnetion: TFDConnection Read fConnect Write fConnect;
        property cServer   : string        Read fServer  Write fServer;
        property cBase     : string        Read fBase    Write fBase;
        property cUser     : string        Read fUser    Write fUser;
        property cPass     : string        Read fPass    Write fPass;
        property cPort     : string        Read fPort    Write fPort;
        property cDriver   : string        Read fDriver  Write fDriver;
        property cError    : string        Read fError   Write fError;
    end;

implementation


{ TConnection }

uses untFunctions, untSource;

procedure TConnection.SaveINI;
begin
    // pega o caminho e o nome do executavel e troca a extensão pra 'ini'
    vINIPath := ChangeFileExt(Application.ExeName, '.ini');

    // cria e abre o arquivo 'ini'
    vINIFile := TIniFile.Create(vINIPath);

    try
        // grava os valores no arquivo ini
        vINIFile.WriteString('DBAccessConfig', 'Server', fServer);
        vINIFile.WriteString('DBAccessConfig', 'Base'  , fBase  );
        vINIFile.WriteString('DBAccessConfig', 'Port'  , fPort  );
        vINIFile.WriteString('DBAccessConfig', 'Driver', fDriver);
        vINIFile.WriteString('DBAccessConfig', 'User'  , fUser  );
//        vINIFile.WriteString('DBAccessConfig', 'Pass'  , Crypto('', fPass));
    finally
        vINIFile.free;
    end;
end;

function TConnection.ReadINI: boolean;
begin
    Result := False;

    // pega o caminho e o nome do executavel e troca a extensão pra 'ini'
    vINIPath := ChangeFileExt(Application.ExeName, '.ini');

    // cria e abre o arquivo 'ini'
    vINIFile := TIniFile.Create(vINIPath);

    // verifica se o arquivo existe
    if not FileExists(vINIPath) then
    begin
        Exit;
    end;

    try
        // passa os valores do arquivo ini para as variaveis
        fServer := vINIFile.ReadString('DBAccessConfig', 'Server', '');
        fBase   := vINIFile.ReadString('DBAccessConfig', 'Base'  , '');
        fPort   := vINIFile.ReadString('DBAccessConfig', 'Port'  , '');
        fDriver := vINIFile.ReadString('DBAccessConfig', 'Driver', '');
        fUser   := vINIFile.ReadString('DBAccessConfig', 'User'  , '');
//        fPass   := Crypto('', vINIFile.ReadString('DBAccessConfig', 'Pass'  , ''));
    finally
        Result  := True;
        vINIFile.Free;
    end;
end;

function TConnection.BDConnect: boolean;
begin
    // define a resposta como verdadeira
    Result := True;

    // limpa os parametros de conexão
    fConnect.Params.Clear;

    // seta os parametros de conexão
    fConnect.Params.Add('Server='    + fServer);
    fConnect.Params.Add('user_name=' + fUser);
    fConnect.Params.Add('password='  + fPass);
    fConnect.Params.Add('port='      + fPort);
    fConnect.Params.Add('Database='  + fBase);
    fConnect.Params.Add('DriverID='  + fDriver);

    try
        // faz a conexão com o banco de dados
        fConnect.Connected := True;
    except
        // se um erro ocorrer
        on Err:Exception do
        begin
            // cria a mensagem de erro
            cError := Err.Message;
            // define uma resposta como falsa
            Result := False;
        end;
    end;
end;

constructor TConnection.Create(ccConnection: TFDConnection);
begin
    // define a conexão
    fConnect := ccConnection;
end;

destructor TConnection.Destroy;
begin
    // desconecta do banco de dados
    fConnect.Connected := False;

    inherited;
end;

end.
