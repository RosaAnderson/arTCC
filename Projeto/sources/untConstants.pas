unit untConstants;

interface

uses {e.log,}

  Winapi.Windows,
  Winapi.Messages,

  System.Variants,
  System.Classes,
  System.SysUtils,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls
  ;

  function exePathRequest: string;

  var
    // inicialização
    vContinue                     : Boolean = False;



    gi_SecaoEMontagem             : Integer = 40;
//    gs_SecaoCorte                 : string  = 'XX';


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

    sysColorEmpresaPri            : TColor  = $00AE7803; // [R:2   | G:120 | B:174] - azul celeste
    sysColorEmpresaSec            : TColor  = $001D1402; // [R:2   | G:20  | B:29 ] - azul marinho

    sysColorButtonPrimary         : TColor  = $00AE7803; // [R:2   | G:120 | B:174] -
    sysColorButtonPrimary_Light   : TColor  = $00FAC8A0; // [R:160 | G:200 | B:250] -
    sysColorButtonSecondary       : TColor  = $00BEBEBE; // [R:190 | G:190 | B:190] -
    sysColorEdge                  : TColor  = $009F9F9F; // [R:159 | G:159 | B:159] - cinza                    *


    // Locais
    gcLocalDir                    : string  = 'c:\simplim'; // caminho da pasta local de armazenamento de configurações

    // Arquivos
    iniName                       : string  = 'conf.ini'; // nome do arquivo de configurações

    // form Design
    gcFontName                    : string  = 'Segoe UI';
    gcFontSize                    : Integer = 14;

    // padrões
    sysMessage                    : string  = 'SIMPLIM - SFC (Shop Floor Control)';
    gcDefault                     : string  = '123mudar';
    gcCelLength                   : Integer = 11;
    AppName                       : string  = 'SFC';

    // temporizadores
    sysStandByTime                : Integer = 60000;

    gvServer                      : string  = ''; // local do servidor
    gvBase                        : string  = ''; // nome da base de dados
    gvPort                        : string  = ''; // porta de entrada
    gvDriver                      : string  = ''; // driver (tipo de banco FB para FireBird/MySql)
    gvUser                        : string  = ''; // usuário do banco de dados
    gvPass                        : string  = ''; // senha do banco de dados


//##############################################################################
//### Acesso indireto do Programador ###########################################
//##############################################################################
    QuickAccess : Boolean; // habilida/desabilita algumas funções
//##############################################################################
//##############################################################################
//##############################################################################

  implementation

//uses untDm;


// coleta o caminho do arquivo executável do sistema
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
//    Result := ExtractFileDir(GetCurrentDir);

    // substitui o o trecho especificado caso exista
    Result := StringReplace(Result, 'win32', '', [rfReplaceAll]);
    Result := StringReplace(Result, 'win64', '', [rfReplaceAll]);

    // se o ultimo caracter não for uma barra
    if Copy(Result, Length(Result), 1) <> '\' then
        Result := Result + '\'; // insere a barra

    // grava o resultado na variavel
//    dm.exePathReply := Result;
end;

end.