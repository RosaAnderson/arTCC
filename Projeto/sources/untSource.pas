unit untSource;

interface

uses e.log,

  Winapi.Windows, Winapi.Messages,

  System.Variants, System.Classes, System.SysUtils,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

  function exePathRequest: string;

  var
    sysDevShortcut                : Boolean = False;

    // conexão
    gvServer                      : string  = ''; // local do servidor
    gvBase                        : string  = ''; // nome da base de dados
    gvPort                        : string  = ''; // porta de entrada
    gvDriver                      : string  = ''; // driver (tipo de banco FB para FireBird/MySql)
    gvUser                        : string  = ''; // usuário do banco de dados
    gvPass                        : string  = ''; // senha do banco de dados

    // form Design
    gcFontName                    : string  = 'Segoe UI';
    gcFontSize                    : Integer = 14;

    // form Colors
    sysColorEmpresaPri            : TColor  = $003A700F; // [R: | G: | B:] -
    sysColorButtonPrimary         : TColor  = $00437E15; // [R: | G: | B:] -
    sysColorButtonSecondary       : TColor  = $002233BB; // [R: | G: | B:] -

    // gradiente
    sysColorGradientStart         : TColor  = $00A0D5A9;
    sysColorGradientEnd           : TColor  = $002A5320;

    // variaveis de ambiente e sistema
    gcAppName                     : string  = 'EasyCare'; // nome do sistema/aplicativo
    gcAppTitle                    : string  = 'AR EasyCare - Sistema Gestão de Clínica Estética';
    gcSymbolLine                  : string  = '%0A'; // caracteres para mudança de linha em uma url
    gcSymbolSpace                 : string  = '%20'; // caracteres para espaço em uma url
    gcPosResult                   : Integer = Length('result:') + 1; // valor para encontrar o result no json
    gcPosMessId                   : Integer = Length('result:') + 1; // valor para encontrar o id da mensagem no json
    gvResponse                    : Integer = 0; // armazena um codigo do banco de dados da tabela config para checar se coletou os dados de configuração

    gvDate                        : TDate; // armazena a data do sistema
    gvHExpI                       : string = '08:00'; // define a hora inicial do expediente
    gvHExpF                       : string = '18:00'; // define a hora final do expediente
    gvScheduleInterval            : Integer = 30; // define o intervalo minimo de cada atendimento
    gvScheduleRefresh             : Integer = (1000 * 60) * 30; // define o intervalo entre cada atualização da agenda
    gvInterval                    : Integer = 5; // intervalo entre cada requisição de dados para o servidor

    gvAttachPath                  : string  = 'D:\'; // caminho da pasta de armazenamento de anexos
    gvSysPatch                    : string  = ''; // caminho do executavel do sistema

    // variaveis de comunicação (whatsapp e e-mail)
    gvDDI                         : string  = '+55'; // DDI padrão do sistema
    gvDDD                         : string  = '14';  // DDD padrão do sistema

    gvURL                         : string  = 'https://app.whatsgw.com.br/api/WhatsGw/Send'; // URL constante do site
    gvAPIKey                      : string  = '4ddb1698-05a3-4613-8416-6ca08340519b'; // APIKey gerada no site
    gvPhoneFrom                   : string  = '5514999065400'; // numero de origem do whatsapp

    gvEMail                       : string  = ''; // e-mail do sistema
    gvSMTP                        : string  = ''; // host SMTP
    gvPorta                       : Integer = 0 ; // porta
    gvSenha                       : string  = ''; // senha do e-mail
    gvNome                        : string  = ''; // nome do remetente

//##########################################
//#### Variáveis de BD #####################
//##########################################

    // Cliente
    gvPES_ID                      : Integer = 0;
    gvPES_INCLUSAO                : TDateTime;
    gvPES_STATUS                  : string  = '';
    gvPES_TIPO                    : string  = '';
    gvPES_USER                    : string  = '';
    gvPES_DOCUMENTO               : string  = '';
    gvPES_NOME                    : string  = '';
    gvPES_NASCIMENTO              : TDate;
    gvPES_GENERO                  : string  = '';
    gvPES_PROFISSAO               : string  = '';
    gvPES_AVATAR                  : string  = '';
    gvPES_DATA_ATUALIZADO         : TDateTime;

        // endereço
        gvEND_ID                  : Integer = 0;
        gvEND_PES_ID              : Integer = 0;
        gvEND_TIPO                : string  = '';
        gvEND_CEP                 : string  = '';
        gvEND_CIDADE              : string  = '';
        gvEND_UF                  : string  = '';
        gvEND_LOGRADOURO          : string  = '';
        gvEND_NUMERO              : string  = '';
        gvEND_BAIRRO              : string  = '';
        gvEND_COMPLEMENTO         : string  = '';
        gvEND_DATA_ATUALIZADO     : TDateTime;

        // telefone
        gvTEL_ID                  : Integer = 0;
        gvTEL_PES_ID              : Integer = 0;
        gvTEL_TIPO                : string  = '';
        gvTEL_DDI                 : string  = '';
        gvTEL_DDD                 : string  = '';
        gvTEL_TELEFONE            : string  = '';
        gvTEL_DATA_ATUALIZADO     : TDateTime;

        // email
        gvMAI_ID                  : Integer = 0;
        gvMAI_PES_ID              : Integer = 0;
        gvMAI_TIPO                : string  = '';
        gvMAI_EMAIL               : string  = '';
        gvMAI_DATA_ATUALIZADO     : TDateTime;

    // procedimento
    gvPRC_ID                      : Integer = 0;
    gvPRC_CAT_ID                  : Integer = 0;
    gvPRC_PRF_ID                  : Integer = 0;
    gvPRC_EQP_ID                  : Integer = 0;
    gvPRC_INCLUSAO                : TDateTime;
    gvPRC_STATUS                  : string  = '';
    gvPRC_NOME                    : string  = '';
    gvPRC_DESCRICAO               : string  = '';
    gvPRC_DURACAO                 : Integer = 0;
    gvPRC_VALOR                   : Double  = 0.00;
    gvPRC_REQUISITO               : string  = '';
    gvPRC_CUIDADOS                : string  = '';
    gvPRC_RISCOS                  : string  = '';
    gvPRC_DATA_ATUALIZADO         : TDateTime;

    // Atendimento
    gvATD_ID                      : Integer = 0;
    gvATD_FPG_ID                  : Integer = 0;
    gvATD_INCLUSAO                : TDateTime;
    gvATD_STATUS                  : string = '';
    gvATD_NOTIFICADO              : string = '';
    gvATD_DATA                    : TDate;
    gvATD_HORA                    : TTime;
    gvATD_DURACAO                 : Integer = 0;
    gvATD_VALOR                   : Double = 0.00;
    gvATD_OBSERVACOES             : string = '';
    gvATD_DATA_ATUALIZADO         : TDateTime;

        // atendimentos pessoa
        gvAPS_ID                  : Integer = 0;
        gvAPS_ATD_ID              : Integer = 0;
        gvAPS_PES_ID              : Integer = 0;
        gvAPS_DATA_ATUALIZADO     : TDateTime;

        // atendimentos procedimento
        gvAPC_ID                  : Integer = 0;
        gvAPC_ATD_ID              : Integer = 0;
        gvAPC_PRC_ID              : Integer = 0;
        gvAPC_DATA_ATUALIZADO     : TDateTime;

        // atendimentos profissional
        gvAPF_ID                  : Integer = 0;
        gvAPF_ATD_ID              : Integer = 0;
        gvAPF_PRF_ID              : Integer = 0;
        gvAPF_DATA_ATUALIZADO     : TDateTime;

    // profissionais
    gvPRF_ID                      : Integer = 1;
    gvPRF_PES_ID                  : Integer = 1;
    gvPRF_STATUS                  : string = '';
    gvPRF_DATA_ATUALIZADO         : TDateTime;

    // formas de pagamento
    gvFPG_ID                      : Integer = 0;
    gvFPG_STATUS                  : string = '';
    gvFPG_NOME                    : string = '';
    gvFPG_DATA_ATUALIZADO         : TDateTime;

    //

implementation

function exePathRequest: string;
var
    coleta: TStringList;
    vArq, valor: string;
begin
    // verifica se a variavel está preenchida
//    if dm.exePathReply <> '' then
//    begin
//        Result := dm.exePathReply;
//        Exit;
//    end;

    // pega o caminho do executável
    Result := ExtractFileDir(GetCurrentDir);

    // substitui o o trecho especificado caso exista
    Result := StringReplace(Result, 'outputs', '', [rfReplaceAll]);
    Result := StringReplace(Result, 'win32', '', [rfReplaceAll]);
    Result := StringReplace(Result, 'win64', '', [rfReplaceAll]);

    // se o ultimo caracter não for uma barra
    if Copy(Result, Length(Result), 1) <> '\' then
        Result := Result + '\'; // insere a barra

    // grava o resultado na variavel
//    dm.exePathReply := Result;
end;

end.











{
//##############################################################################
//### Acesso indireto do Programador ###########################################
//##############################################################################
    QuickAccess : Boolean; // habilida/desabilita algumas funções
//##############################################################################
//##############################################################################
//##############################################################################

    // inicialização
    vContinue                     : Boolean = False;

    // Cores
    gc_CorProduzidoOK             : TColor  = $00B3FD93; // [R:    | G:    | B:   ] - verde
    sysColorProduzidoOK_Light     : TColor  = $00B3FD93; // [R:    | G:    | B:   ] - verde
    gc_CorProduzidoAtraso         : TColor  = $0099F7D6; // [R:    | G:    | B:   ] - verde claro
    sysColorProduzidoAtraso_Light : TColor  = $0099F7D6; // [R:    | G:    | B:   ] - verde claro
    gc_CorAtrasado                : TColor  = $007979FF; // [R:    | G:    | B:   ] - vermelho
    sysColorAtrasado_Light        : TColor  = $00C6BAF5; // [R:245 | G:186 | B:198] - vermelho claro [usado nas fichas]
    gc_CorAProduzir               : TColor  = $00F7F79D; // [R:157 | G:247 | B:247] - ciano
    gc_CorEmGiro                  : TColor  = $00D896A5; // [R:    | G:    | B:   ] - roxo
    sysColorEmGiro_Light          : TColor  = $00D896A5; // [R:165 | G:150 | B:216] - vermelho claro [usado nas fichas]
    gc_CorPrioridade              : TColor  = $000B92F4; // [R:    | G:    | B:   ] - ocre

    sysColorPrioridade_Light      : TColor  = $0063B9F8; // [R:    | G:    | B:   ] - ocre claro [usado nas fichas]
    sysColorLimite                : TColor  = $0015DCFF; // [R:255 | G:220 | B:21 ] - amarelo
    sysColorLimite_Light          : TColor  = $0091F0FF; // [R:255 | G:240 | B:145] - amarelo claro [usado nas fichas]
    sysColorPendente              : TColor  = $00D7D7D7; // [R:215 | G:215 | B:215] - cinza

//    sysColorEmpresaPri            : TColor  = $00AE7803; // [R:2   | G:120 | B:174] - azul celeste

    sysColorEmpresaSec            : TColor  = $001D1402; // [R:2   | G:20  | B:29 ] - azul marinho

//    sysColorButtonPrimary         : TColor  = $00AE7803; // [R:2   | G:120 | B:174] -
    sysColorButtonPrimary_Light   : TColor  = $00FAC8A0; // [R:160 | G:200 | B:250] -
//    sysColorButtonSecondary       : TColor  = $00BEBEBE; // [R:190 | G:190 | B:190] -
    sysColorEdge                  : TColor  = $009F9F9F; // [R:159 | G:159 | B:159] - cinza                    *

    // Locais
    gcLocalDir                    : string  = 'c:\simplim'; // caminho da pasta local de armazenamento de configurações

    // Arquivos
    iniName                       : string  = 'conf.ini'; // nome do arquivo de configurações

    // padrões
    sysMessage                    : string  = 'SIMPLIM - SFC (Shop Floor Control)';
    gcDefault                     : string  = '123mudar';
    gcCelLength                   : Integer = 11;
    AppName                       : string  = 'SFC';

    // temporizadores
    sysStandByTime                : Integer = 60000;
//}

