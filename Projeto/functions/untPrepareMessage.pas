unit untPrepareMessage;

interface

uses
    System.SysUtils, System.Classes, System.NetEncoding,
{
    FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
    FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
    FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
    FireDAC.Comp.UI, FireDAC.FMXUI.Wait, FireDAC.Comp.Client, FireDAC.Stan.Param,
    FireDAC.Comp.DataSet, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,

    Data.DB,
//}
    Datasnap.DBClient, Datasnap.Provider,

    REST.Types, REST.Client, REST.Response.Adapter,

    IdHTTP, idSMTP, idMessage, idSSLOpenSSL, idAttachmentFile, IdBaseComponent,
    IdTCPConnection, IdTCPClient, IdComponent, idExplicitTLSClientServerBase,

    Soap.EncdDecd

    ;


    function ValidarPhone(vfNumero: string): string;
    function getSendResult(vfJSON: string): Boolean;
    function SendToWhatsapp(vfTo, vfID, vfType, vfDescription, vfFName, vfBody: string): string;
    function createMessage(vfTipo, vfPES_NOME, vfATD_DATA, vfATD_HORA, vfPRC_NOME: string): string;

var
    message_id, sResult: string;

implementation

uses untSource, untFunctions;

function getSendResult(vfJSON: string): Boolean;
var
    jget, vJSONClear: string;
    I: Integer;
begin
    // limpa a variavel
    vJsonClear := '';

    // passa por toda a string caraceter por caracter
    for I := 1 to vfJSON.Length do
    begin
        // pega caracter por caracter limpa e salva na variavel
        vJSONClear := vJSONClear + Trim(Copy(vfJSON, i, 1));

        // incrementa
        int(i);
    end;

    // remove os caracteres designados
    vJSONClear := StringReplace(vJSONClear, '"', '', [rfReplaceAll, rfIgnoreCase]);
    vJSONClear := StringReplace(vJSONClear, '{', '', [rfReplaceAll, rfIgnoreCase]);

    // pega o ida da mensagem gerado pelo sistema
    message_id := Copy(vJSONClear,
                    (Pos('_id:', vJSONClear) + 4),
                      (Pos(',', (Copy(vJSONClear,
                        (Pos('_id:', vJSONClear) + 4), 20))) - 1));

    // pega o resultado do envio
    Result := (Copy(vJSONClear, gcPosResult, (Pos(',', (Copy(vJSONClear, gcPosResult, 10))) - 1)) = 'success');
end;

function SendToWhatsapp(vfTo, vfID, vfType, vfDescription, vfFName, vfBody: string): string;
var
    vURL, Json  : string;
    JsonToSend  : TStringStream;
    idHTTP      : TIdHTTP;
    RESTClient  : TRESTClient;
    RESTRequest : TRESTRequest;
    RESTResponse: TRESTResponse;
begin




if sysDevShortcut then Exit;




    try
        // verifica o tipo de envio
        if vfType = 'text' then
        begin
            if gvAPIKey = '' then
            begin
                //

                //
                Exit
            end;

            if gvPhoneFrom = '' then
            begin
                //

                //
                Exit;
            end;

            if vfTo = '' then
            begin
                //

                //
                Exit;
            end;

            try
                // cria os objetos
                RESTClient   := TRESTClient.Create(nil);
                RESTRequest  := TRESTRequest.Create(RESTClient);
                RESTResponse := TRESTResponse.Create(nil);

                // define o type
                RESTClient.ContentType := 'application/x-www-form-urlencoded';

                // monta a URL final a partir dos dados informados
                vURL := gvURL + '?' // insere a url principal da api
                              + 'apikey='                + gvAPIKey // insere a chave
                              + '&phone_number='         + gvPhoneFrom // insere o telefone de origem
                              + '&contact_phone_number=' + vfTo // insere o numero de destino
                              + '&message_custom_id='    + vfID // define o id da mensagem
                              + '&message_type='         + vfType; // tipo de mensagem (texto/anexo)

                // substitui os caracteres necessários
                vfBody := StringReplace(vfBody, '  '    , ' '          , [rfReplaceAll, rfIgnoreCase]);
                vfBody := StringReplace(vfBody, ' '     , gcSymbolSpace, [rfReplaceAll, rfIgnoreCase]);
                vfBody := StringReplace(vfBody, '#$D#$A', gcSymbolLine , [rfReplaceAll, rfIgnoreCase]);

                vURL   := vURL + '&message_body=' + vfBody; // insere a mensagem na url

                if vfBody = '' then
                begin
                    //

                    //
                    Exit;
                end;

                try
                    // envia a url
                    RESTClient.BaseURL := vURL;

                    // faz a requisição para o servidor
                    RESTRequest.Execute;

                    // pega a resposta do servidor
                    Result := RESTRequest.Response.JSONText;
                except
                    // captura o erro encontrado, caso haja
                    on eError: Exception do
                        // exibe a mensagem com o erro
                        Writeln(eError.ClassName, ': ', eError.Message);
                end;
            finally
                // descarrega as variaveis
                RESTClient.Free;
                RESTResponse.Free;
            end;
        end
        else
        begin
            try
                // cria o objeto
                idHTTP := TIdHTTP.Create(nil);

                // controi o json
                Json := '{' +
                            '"apikey" : "'                + gvAPIKey      + '",' +
                            '"phone_number" : "'          + gvPhoneFrom   + '",' +
                            '"contact_phone_number" : "'  + vfTo          + '",' +
                            '"message_custom_id" : "'     + vfID          + '",' +
                            '"message_type" : "'          + vfType        + '",' +
                            '"message_caption" : "'       + vfDescription + '",' +
                            '"message_body_mimetype" : "application/pdf",'       +
                            '"message_body_filename" : "' + vfFName       + '",' +
                            '"message_body" : "'          + vfBody        + '",' +
                            '"check_status" : "1"' +
                        '}';
                // converto a string para stream
                JsonToSend := TStringStream.Create(json);
                // define o type
                IdHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
                try
                    // executa o envio via post
                    Result := idHTTP.Post(gvURL, JsonToSend);
                except
                    on E: Exception do
                        Result := 'Error on request:' + e.Message;
                end;
            finally
                // descarrega os objetos
                JsonToSend.Free;
                idHTTP.Free;
            end;
        end;
    except
    //
    end;
end;

function ValidarPhone(vfNumero: string): string;
begin
    // remove caracteres desnecessários
    vfNumero := StringReplace(vfNumero, ' ', '', [rfReplaceAll]);
    vfNumero := StringReplace(vfNumero, '-', '', [rfReplaceAll]);
    vfNumero := StringReplace(vfNumero, '(', '', [rfReplaceAll]);
    vfNumero := StringReplace(vfNumero, ')', '', [rfReplaceAll]);
    vfNumero := StringReplace(vfNumero, '.', '', [rfReplaceAll]);

    // verifica o telefone
    if Length(vfNumero) < 8 then
        vfNumero := '' // limpa a variavel
    else
    if Length(vfNumero) <= 9 then
        vfNumero := '5514' + vfNumero // adiciona pais e ddd
    else
    if Length(vfNumero) <= 11 then
        vfNumero := '55' + vfNumero //adiciona pais
    else
    if Length(vfNumero) > 13 then
        vfNumero := '';

    Result := vfNumero;
end;

function createMessage(vfTipo, vfPES_NOME, vfATD_DATA, vfATD_HORA, vfPRC_NOME: string): string;
begin
    // transforma tudo em minusculo
    vfTipo := LowerCase(vfTipo);

    // tipo de mensagem
    if vfTipo = 'confirma' then
    begin
        // composição da mensagem
        Result := '*_Confirmação de Atendimento_*' + sLineBreak +
                  sLineBreak +
                  'Olá ' + vfPES_NOME + ', tudo bem? ☺️' + sLineBreak + sLineBreak +
                  'Este é um lembrete para o seu atendimento, ' + doWeek(StrToDate(vfATD_DATA)) +
                  ' (' + vfATD_DATA + ') às ' + vfATD_HORA + '.' + sLineBreak +
                  '*Serviço:* ' + vfPRC_NOME + sLineBreak + sLineBreak +
                  '*caso você confirme mas não compareça, seu horário ' +
                  'constará como atendido, e deverá ser pago*' + sLineBreak + sLineBreak +
                  '_Podemos confirmar?_';
    end
    else
    if vfTipo = 'cadastra' then
    begin
        // composição da mensagem
        Result := '*_Confirmação de Agendamento_*' + sLineBreak +
                  sLineBreak +
                  'Olá, ' + vfPES_NOME + ', seu agendamento foi confirmado '+
                  'com sucesso! ☺️' + sLineBreak +
                  sLineBreak +
                  'Seguem os detalhes:' + sLineBreak +
                  '*Data....:* ' + vfATD_DATA + ' (' + doWeek(StrToDate(vfATD_DATA)) + ')' + sLineBreak +
                  '*Hora....:* ' + vfATD_HORA + sLineBreak +
                  '*Serviço.:* ' + vfPRC_NOME + sLineBreak +
                  sLineBreak + sLineBreak +
                  'Ficamos à disposição para qualquer dúvida ou necessidade de alteração.'  + sLineBreak +
                  sLineBreak +
                  'Agradecemos pela confiança e aguardamos você no dia e horário marcados!' + sLineBreak +
                  sLineBreak + sLineBreak +
                  'Atenciosamente,' + sLineBreak +
                  '*Carol Rosa - Estética*'; //[Seu Nome / Nome da Empresa]
    end
    else
    if vfTipo = 'altera' then
    begin
        // composição da mensagem
        Result := '*_Agendamento Alterado_*' + sLineBreak +
                  sLineBreak +
                  'Olá, ' + vfPES_NOME + ', seu agendamento foi alterado '+
                  'com sucesso! ☺️' + sLineBreak +
                  sLineBreak +
                  'Seguem os novos detalhes:' + sLineBreak +
                  '*Data....:* ' + vfATD_DATA + ' (' + doWeek(StrToDate(vfATD_DATA)) + ')' + sLineBreak +
                  '*Hora....:* ' + vfATD_HORA + sLineBreak +
                  '*Serviço.:* ' + vfPRC_NOME + sLineBreak +
                  sLineBreak + sLineBreak +
                  'Ficamos à disposição para qualquer dúvida ou necessidade de alteração.'  + sLineBreak +
                  sLineBreak +
                  'Agradecemos pela confiança e aguardamos você no dia e horário marcados!' + sLineBreak +
                  sLineBreak + sLineBreak +
                  'Atenciosamente,' + sLineBreak +
                  '*Carol Rosa - Estética*';//[Seu Nome / Nome da Empresa]
    end;
end;








end.


// link para consultar saldo
{https://app.whatsgw.com.br/api/WhatsGw/Balance?apikey=4ddb1698-05a3-4613-8416-6ca08340519b}






Confirmação de Agendamento

Olá, [Nome da Pessoa], seu agendamento foi confirmado com sucesso!

Seguem os detalhes:

**Data:** [Data]
**Hora:** [Hora]

Ficamos à disposição para qualquer dúvida ou necessidade de alteração.

Agradecemos pela confiança e aguardamos você no dia e horário marcados!

Atenciosamente,
[Seu Nome / Nome da Empresa]

