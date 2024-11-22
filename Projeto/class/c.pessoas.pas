unit c.pessoas;

interface

uses
  System.SysUtils,

  Data.DB,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.FMXUI.Wait, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.Comp.DataSet, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt

  ;

type
    TPessoas = class

    private
        {Private declarations}
    public
        {Public declarations}
//        constructor Create(ccConnection: TFDConnection);
//        destructor  Destroy; override;

    end;

        procedure cDisconnect();

        function pesSearchOne(vfValue: string): Boolean;
        function pesGetID(vfValue: string): Integer;
        function pesUpdate(vfValue: Integer): Boolean;

var
    qryAuxPES            : TFDQuery;
    vFound               : Boolean;
    vOutCount            : Integer;

    vcPES_ID             : Integer;
    vcPES_INCLUSAO       : TDateTime;
    vcPES_STATUS         : string;
    vcPES_TIPO           : string;
    vcPES_USER           : string;
    vcPES_DOCUMENTO      : string;
    vcPES_NOME           : string;
    vcPES_NASCIMENTO     : TDate;
    vcPES_GENERO         : string;
    vcPES_PROFISSAO      : string;
    vcPES_AVATAR         : string;
    vcPES_DATA_ATUALIZADO: TDateTime;

    vcTEL_ID             : Integer;
    vcTEL_PES_ID         : Integer;
    vcTEL_TIPO           : string;
    vcTEL_DDI            : string;
    vcTEL_DDD            : string;
    vcTEL_TELEFONE       : string;
    vcTEL_DATA_ATUALIZADO: TDateTime;

    vcMAI_ID             : Integer;
    vcMAI_PES_ID         : Integer;
    vcMAI_TIPO           : string;
    vcMAI_EMAIL          : string;
    vcMAI_DATA_ATUALIZADO: TDateTime;


implementation

{ TPessoas }

uses untDBConnect, untSource, untFunctions, untCli_Cadastro;

procedure cDisconnect();
begin
    qryAuxPES.Close; // fecha a query
    qryAuxPES.Free; // descarrega a query

    frmDBConnect.DBDisconnect; // desconecta
end;

function pesGetID(vfValue: string):Integer;
begin
    try
        // conecta
        if not(frmDBConnect.DBConnect) then
            Exit
        else
            qryAuxPES := TFDQuery.Create(nil); // cria a query

        try
            with qryAuxPES do
            begin
                Connection := frmDBConnect.FDConnect; // define o bando de dados

                // insere o SQL
                SQL.Add(' INSERT INTO PESSOAS           ');
                SQL.Add(' (PES_NOME) VALUES (:PES_NOME) ');
                ParamByName('PES_NOME').AsString := vfValue + '_ins'; // preenche o parametro
                ExecSQL; // executa o SQL
                SQL.Clear; // limpa

                // insere o SQL
                SQL.Add(' SELECT PES_ID       ');
                SQL.ADD(' FROM PESSOAS WHERE  ');
                SQL.ADD(' PES_NOME = :PES_NOME');
                ParamByName('PES_NOME').AsString := vfValue + '_ins'; // preenche o parametro
                Open; // abre

                gvPES_ID := FieldByName('PES_ID').AsInteger; // armazena o id gerado
                Result   := gvPES_ID; // define o resultado
            end;
        except
            Result := 0; // define o resultado
        end;
    finally
        cDisconnect(); // desconecta
    end;
end;

function pesSearchOne(vfValue: string): Boolean;
begin
    // remove possiveis espaços
    vfValue := Trim(vfValue);

    try
        // conecta
        if not(frmDBConnect.DBConnect) then
            Exit
        else
            qryAuxPES := TFDQuery.Create(nil); // cria a query

        try
            with qryAuxPES do
            begin
                Connection := frmDBConnect.FDConnect; // define o bando de dados

                // insere o sql
                SQL.Add(' SELECT P.*, T.*, M.*             ');
                SQL.Add(' FROM PESSOAS AS P                ');
                SQL.Add(' LEFT JOIN TELEFONES AS T         ');
                SQL.Add('        ON (TEL_PES_ID = PES_ID)  ');
                SQL.Add(' LEFT JOIN MAILS AS M             ');
                SQL.Add('        ON (MAI_PES_ID = PES_ID)  ');
                SQL.Add(' WHERE PES_ID        = :CLI_BUSCA ');
                SQL.ADD(' OR    PES_DOCUMENTO = :CLI_BUSCA ');
                SQL.Add(' OR    MAI_EMAIL     = :CLI_BUSCA ');
                SQL.ADD(' OR    TEL_TELEFONE  = :CLI_BUSCA ');
                SQL.Add(' OR    PES_NOME LIKE' +
                              QuotedStr('%' + vfValue + '%'));
                ParamByName('CLI_BUSCA').AsString := vfValue; // passa o valor do parametro
                Open; // faz a pesquisa

                if not(IsEmpty) then
                begin
                    // insere os dados nos campos
                    gvPES_ID              :=                FieldByName('PES_ID').AsInteger;
                    gvPES_INCLUSAO        :=                FieldByName('PES_INCLUSAO').AsDateTime;
                    gvPES_STATUS          :=           Trim(FieldByName('PES_STATUS').AsString);
                    gvPES_TIPO            :=           Trim(FieldByName('PES_TIPO').AsString);
                    gvPES_USER            :=           Trim(FieldByName('PES_USER').AsString);
                    gvPES_DOCUMENTO       :=           Trim(FieldByName('PES_DOCUMENTO').AsString);
                    gvPES_NOME            :=  NameCase(Trim(FieldByName('PES_NOME').AsString), 'y');
                    gvPES_NASCIMENTO      :=                FieldByName('PES_NASCIMENTO').AsDateTime;
                    gvPES_GENERO          :=           Trim(FieldByName('PES_GENERO').AsString);
                    gvPES_PROFISSAO       :=           Trim(FieldByName('PES_PROFISSAO').AsString);
                    gvPES_AVATAR          :=           Trim(FieldByName('PES_AVATAR').AsString);
                    gvPES_DATA_ATUALIZADO :=                FieldByName('PES_DATA_ATUALIZADO').AsDateTime;

                    gvTEL_ID              :=                FieldByName('TEL_ID').AsInteger;
                    gvTEL_PES_ID          :=                FieldByName('TEL_PES_ID').AsInteger;
                    gvTEL_TIPO            :=           Trim(FieldByName('TEL_TIPO').AsString);
                    gvTEL_DDI             :=           Trim(FieldByName('TEL_DDI').AsString);
                    gvTEL_DDD             :=           Trim(FieldByName('TEL_DDD').AsString);
                    gvTEL_TELEFONE        :=           Trim(FieldByName('TEL_TELEFONE').AsString);
                    gvTEL_DATA_ATUALIZADO :=                FieldByName('TEL_DATA_ATUALIZADO').AsDateTime;

                    gvMAI_ID              :=                FieldByName('MAI_ID').AsInteger;
                    gvMAI_PES_ID          :=                FieldByName('MAI_PES_ID').AsInteger;
                    gvMAI_TIPO            :=           Trim(FieldByName('MAI_TIPO').AsString);
                    gvMAI_EMAIL           := LowerCase(Trim(FieldByName('MAI_EMAIL').AsString));
                    gvMAI_DATA_ATUALIZADO :=                FieldByName('MAI_DATA_ATUALIZADO').AsDateTime;
                end;

                vOutCount := RecordCount;
            end;

            Result := not(qryAuxPES.IsEmpty); // derfine o resultado
        except
            //
            Result := False;
        end;
    finally
        cDisconnect(); // desconecta
    end;
end;

function pesUpdate(vfValue: Integer): Boolean;
begin
    try
        // conecta
        if not(frmDBConnect.DBConnect) then
            Exit
        else
            qryAuxPES := TFDQuery.Create(nil); // cria a query

        try
            with qryAuxPES do
            begin
                Connection := frmDBConnect.FDConnect; // define o bando de dados

//##############################################################################
//## TABELA CLIENTES ###########################################################
//##############################################################################

                // insere o sql
                SQL.Add(' UPDATE PESSOAS SET                ');
//                SQL.Add(' PES_STATUS     = :PES_STATUS,     ');
//                SQL.Add(' PES_TIPO       = :PES_TIPO,       ');
//                SQL.Add(' PES_USER       = :PES_USER,       ');
                SQL.Add(' PES_DOCUMENTO  = :PES_DOCUMENTO,  ');
                SQL.Add(' PES_NOME       = :PES_NOME,       ');
                SQL.Add(' PES_NASCIMENTO = :PES_NASCIMENTO, ');
//                SQL.Add(' PES_GENERO     = :PES_GENERO,     ');
                SQL.Add(' PES_PROFISSAO  = :PES_PROFISSAO  ');
//                SQL.Add(' PES_AVATAR     = :PES_AVATAR      ');
                SQL.Add(' WHERE PES_ID   = :PES_ID          ');

                // insere os dados na query
                ParamByName('PES_ID').AsInteger       := vfValue;
//                ParamByName('PES_STATUS').AsString    := vcPES_STATUS;
//                ParamByName('PES_TIPO').AsString      := vcPES_TIPO;
//                ParamByName('PES_USER').AsString      := vcPES_USER;
                ParamByName('PES_DOCUMENTO').AsString := vcPES_DOCUMENTO;
                ParamByName('PES_NOME').AsString      := vcPES_NOME;
                ParamByName('PES_NASCIMENTO').AsDate  := vcPES_NASCIMENTO;
//                ParamByName('PES_GENERO').AsString    := vcPES_GENERO;
                ParamByName('PES_PROFISSAO').AsString := vcPES_PROFISSAO;
//                ParamByName('PES_AVATAR').AsString    := vcPES_AVATAR;
                ExecSQL; // executa o SQL
                SQL.Clear; // limpa

//##############################################################################
//## TABELA TELEFONES ##########################################################
//##############################################################################

                // verifica se encontrou um telefone
                SQL.Add(' SELECT TEL_ID FROM TELEFONES  ');
                SQL.Add(' WHERE TEL_PES_ID = :TEL_PES_ID');
                ParamByName('TEL_PES_ID').AsInteger := vfValue;
                Open; // abre
                vFound := not(IsEmpty); // encontrou
                Close; // fecha
                SQL.Clear; // limpa

                // se não encontrou
                if vFound then
                begin
                    // atualiza o telefone
                    SQL.Add(' UPDATE TELEFONES SET           ');
                    SQL.ADD(' TEL_TIPO     = :TEL_TIPO,      ');
                    SQL.ADD(' TEL_DDI      = :TEL_DDI,       ');
                    SQL.ADD(' TEL_DDD      = :TEL_DDD,       ');
                    SQL.Add(' TEL_TELEFONE = :TEL_TELEFONE   ');
                    SQL.ADD(' WHERE TEL_PES_ID = :TEL_PES_ID ');
                end
                else
                begin
                    // insere o telefone
                    SQL.Add(' INSERT INTO TELEFONES    ');
                    SQL.ADD(' (TEL_PES_ID, TEL_TIPO,   ');
                    SQL.ADD('  TEL_DDI, TEL_DDD,       ');
                    SQL.ADD('  TEL_TELEFONE)           ');
                    SQL.ADD(' VALUES                   ');
                    SQL.ADD(' (:TEL_PES_ID, :TEL_TIPO, ');
                    SQL.ADD('  :TEL_DDI, :TEL_DDD,     ');
                    SQL.ADD('  :TEL_TELEFONE)          ');
                end;

                // passa os valores
                ParamByName('TEL_PES_ID').AsInteger  := vfValue;
                ParamByName('TEL_TIPO').AsString     := 'P'; //vcTEL_TIPO;
                ParamByName('TEL_DDI').AsString      := vcTEL_DDI;
                ParamByName('TEL_DDD').AsString      := vcTEL_DDD;
                ParamByName('TEL_TELEFONE').AsString := vcTEL_TELEFONE;
                ExecSQL; // executa
                SQL.Clear; // limpa

//##############################################################################
//## TABELA E-MAIL #############################################################
//##############################################################################

                // verifica se encontrou um email
                SQL.Add(' SELECT MAI_ID FROM MAILS       ');
                SQL.Add(' WHERE MAI_PES_ID = :MAI_PES_ID ');
                ParamByName('MAI_PES_ID').AsInteger := vfValue;
                Open; // abre
                vFound := not(IsEmpty); // encontrou
                Close; // fecha
                SQL.Clear; // limpa

                if vcMAI_EMAIL <> '' then
                begin
                    // se encontrou
                    if vFound then
                    begin
                        // atualiza o telefone
                        SQL.Add(' UPDATE MAILS SET               ');
                        SQL.ADD(' MAI_TIPO  = :MAI_TIPO,         ');
                        SQL.ADD(' MAI_EMAIL = :MAI_EMAIL         ');
                        SQL.ADD(' WHERE MAI_PES_ID = :MAI_PES_ID ');
                    end
                    else
                    begin
                        // insere o e-mail
                        SQL.Add(' INSERT INTO MAILS                    ');
                        SQL.ADD(' (MAI_PES_ID, MAI_TIPO, MAI_EMAIL)    ');
                        SQL.ADD(' VALUES                               ');
                        SQL.ADD(' (:MAI_PES_ID, :MAI_TIPO, :MAI_EMAIL) ');
                    end;

                    // passa os valores
                    ParamByName('MAI_PES_ID').AsInteger := vfValue;
                    ParamByName('MAI_TIPO').AsString    := 'P'; //vcMAI_TIPO;
                    ParamByName('MAI_EMAIL').AsString   := vcMAI_EMAIL;
                    ExecSQL; // executa
                end;
            end;

            // atualiza as variáveis
            gvPES_ID         := vfValue;
            gvPES_STATUS     := vcPES_STATUS;
            gvPES_TIPO       := vcPES_TIPO;
            gvPES_USER       := vcPES_USER;
            gvPES_DOCUMENTO  := vcPES_DOCUMENTO;
            gvPES_NOME       := vcPES_NOME;
            gvPES_NASCIMENTO := vcPES_NASCIMENTO;
            gvPES_GENERO     := vcPES_GENERO;
            gvPES_PROFISSAO  := vcPES_PROFISSAO;
            gvPES_AVATAR     := vcPES_AVATAR;

            gvTEL_PES_ID     := vfValue;
            gvTEL_TIPO       := 'P'; //vcTEL_TIPO;
            gvTEL_DDI        := vcTEL_DDI;
            gvTEL_DDD        := vcTEL_DDD;
            gvTEL_TELEFONE   := vcTEL_TELEFONE;

            gvMAI_PES_ID     := vfValue;
            gvMAI_TIPO       := 'P'; //vcMAI_TIPO;
            gvMAI_EMAIL      := vcMAI_EMAIL;

            Result := not(qryAuxPES.IsEmpty); // derfine o resultado
        except
            //
            Result := False;
        end;
    finally
        cDisconnect(); // desconecta

        pesSearchOne(IntToStr(vfValue));
    end;
end;

end.
