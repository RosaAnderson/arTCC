unit e.log;

interface

uses
  Winapi.Messages,

  System.SysUtils, System.Classes,

  Vcl.Forms, Vcl.Dialogs;

type
  TException = class

  private
    { Private declarations }
    FLogFile: string;
  public
    { Public declarations }
    constructor Create;
    procedure getExcept(Sender: TObject; E: Exception);
    procedure putOnFile(vpLine: string);
  end;

const
    vC : string = ' Caption.: ';
    vE : string = ' Error...: ';
    vF : string = ' Form....: ';
    vL : string = ' Object..: ';

    vLineLength : Integer = 80;

implementation

uses untDBConnect;

{ TException }

constructor TException.Create;
begin
    // define o caminho e o nome do arquivo
    FLogFile := ChangeFileExt(ParamStr(0), '.log');

    //
    Application.OnException := getExcept;
end;

procedure TException.getExcept(Sender: TObject; E: Exception);
var
    vFirstLine: string;
begin
{
    // gera a linha titulo
    vFirstLine := '### '   + FormatDateTime('yyyy/mm/dd | hh:nn:ss // ', Now) +
                  'User: ' + IntToStr(dm.vUserCode) + '-' + dm.vUserName + ' ';

    // insere a linha cabeçalho
    putOnFile(vFirstLine + StringOfChar('#', vLineLength - Length(vFirstLine)));

    // insere as linhas com os dados do erro
    if TComponent(Sender) is TForm then
    begin
        putOnFile(vF + TForm(Sender).Name);
        putOnFile(vC + TForm(Sender).Caption);
        putOnFile(vL + dm.vLocalE);
        putOnFile(vE + e.ClassName);
        putOnFile(     lineBreak(e.Message, vE, vLineLength));
        putOnFile(vE + e.UnitName);
    end
    else
    begin
        putOnFile(vF + TForm(TComponent(Sender).Owner).Name);
        putOnFile(vC + TForm(TComponent(Sender).Owner).Caption);
        putOnFile(vL + dm.vLocalE);
        putOnFile(vE + e.ClassName);
        putOnFile(     lineBreak(e.Message, vE, vLineLength));
        putOnFile(vE + e.UnitName);
    end;

    // insere a linha divisória
    putOnFile(StringOfChar('=', vLineLength) + sLineBreak);
}

    // exibe a mensagem do erro
//    LoadMessage({título da janela}    'Um erro impediu a execução da tarefa!',
//                {título da mensagem}  e.ClassName,
//                {mensagem ao usuário} e.Message,
//                {caminho do ícone}    'error', {check/error/question/exclamation}
//                {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
//                {nome do link}        '',
//                {link}                ''
//               );
end;

procedure TException.putOnFile(vpLine: string);
var
    vFile : TextFile;
begin
    // cria o arquivo na memória
    AssignFile(vFile, FLogFile);

    // verifica se o arquivo existe
    if FileExists(FLogFile) then
        Append(vFile) // abre o arquivo
    else
        Rewrite(vFile); // cria e abre o arquivo

    // grava os dados no arquivo
    Writeln(vFile, vpLine);

    // fecha o arquivo
    CloseFile(vFile);
end;

var
  arExcept: TException;

initialization
  arExcept := TException.Create;

finalization
  arExcept.Free;

end.



//#######################################################################
//#######################################################################


unit e.log;

interface

uses
  Winapi.Messages,

  System.SysUtils, System.Classes,

  Vcl.Forms, Vcl.Dialogs;

type
  TException = class

  private
    { Private declarations }
    FLogFile: string;
  public
    { Public declarations }
    constructor Create;
    procedure getExcept(Sender: TObject; E: Exception);
    procedure putOnFile(vpLine: string);
  end;

const
    vF : string = ' Form....: ';
    vC : string = ' Caption.: ';
    vE : string = ' Error...: ';

    vLineLength : Integer = 80;

implementation

uses untMessage, untDBConnect, untFunctions;

{ TException }

constructor TException.Create;
begin
    // define o caminho e o nome do arquivo
    FLogFile := ChangeFileExt(ParamStr(0), '.log');

    //
    Application.OnException := getExcept;
end;

procedure TException.getExcept(Sender: TObject; E: Exception);
var
    vFirstLine: string;
begin
    // gera a linha titulo
    vFirstLine := '### '   + FormatDateTime('yyyy/mm/dd | hh:nn:ss // ', Now) +
                  'User: ' + IntToStr(frmDBConnect.vpUCode) + '-' + frmDBConnect.vpUName + ' ';

    // insere a linha cabeçalho
    putOnFile(vFirstLine + StringOfChar('#', vLineLength - Length(vFirstLine)));

    // insere as linhas com os dados do erro
    if TComponent(Sender) is TForm then
    begin
        putOnFile(vF + TForm(Sender).Name);
        putOnFile(vC + TForm(Sender).Caption);
        putOnFile(vE + e.ClassName);
        putOnFile(     lineBreak(e.Message, vE, vLineLength));
        putOnFile(vE + e.UnitName);
    end
    else
    begin
        putOnFile(vF + TForm(TComponent(Sender).Owner).Name);
        putOnFile(vC + TForm(TComponent(Sender).Owner).Caption);
        putOnFile(vE + e.ClassName);
        putOnFile(     lineBreak(e.Message, vE, vLineLength));
        putOnFile(vE + e.UnitName);
    end;

    // insere a linha divisória
    putOnFile(StringOfChar('=', vLineLength) + sLineBreak);

    // exibe a mensagem do erro
    LoadMessage({título da janela}    'Um erro impediu a execução da tarefa!',
                {título da mensagem}  e.ClassName,
                {mensagem ao usuário} e.Message,
                {caminho do ícone}    'error', {check/error/question/exclamation}
                {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                {nome do link}        '',
                {link}                ''
               );
end;

procedure TException.putOnFile(vpLine: string);
var
    vFile : TextFile;
begin
    // cria o arquivo na memória
    AssignFile(vFile, FLogFile);

    // verifica se o arquivo existe
    if FileExists(FLogFile) then
        Append(vFile) // abre o arquivo
    else
        Rewrite(vFile); // cria e abre o arquivo

    // grava os dados no arquivo
    Writeln(vFile, vpLine);

    // fecha o arquivo
    CloseFile(vFile);
end;

var
  arExcept: TException;

initialization
  arExcept := TException.Create;

finalization
  arExcept.Free;

end.

