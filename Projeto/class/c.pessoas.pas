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
//        qryAuxCli: TFDQuery;
    public
        {Public declarations}
//        constructor Create(ccConnection: TFDConnection);
//        destructor  Destroy; override;

    end;

        procedure cDisconnect();

        function pesSearch(vfValue: string): Boolean;
        function pesGetID(vfValue: string):Integer;
        function pesUpdate(vfValue: Integer): Boolean;

var
    qryAuxCli: TFDQuery;
    vFound   : Boolean;

    vcPES_CPF, vcPES_NOME, vcTEL_DDD, vcTEL_TELEFONE, vcMAI_EMAIL: string;
    vcPES_NASCIMENTO:TDate;

implementation

{ TPessoas }

uses untDBConnect, untSource, untFunctions, untCli_Cadastro;

procedure cDisconnect();
begin
    qryAuxCli.Close; // fecha a query
    qryAuxCli.Free; // descarrega a query

    frmDBConnect.DBDisconnect; // desconecta
end;

function pesGetID(vfValue: string):Integer;
begin
    try
        // conecta
        if not(frmDBConnect.DBConnect) then
            Exit
        else
            qryAuxCli := TFDQuery.Create(nil); // cria a query

        try
            with qryAuxCli do
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

function pesSearch(vfValue: string): Boolean;
begin
    // remove possiveis espaços
    vfValue := Trim(vfValue);

    try
        // conecta
        if not(frmDBConnect.DBConnect) then
            Exit
        else
            qryAuxCli := TFDQuery.Create(nil); // cria a query

        try
            with qryAuxCli do
            begin
                Connection := frmDBConnect.FDConnect; // define o bando de dados

                // insere o sql
                SQL.Add(' SELECT P.*, T.*, M.*            ');
                SQL.Add(' FROM PESSOAS AS P               ');
                SQL.Add(' LEFT JOIN TELEFONES AS T        ');
                SQL.Add('        ON (TEL_PES_ID = PES_ID) ');
                SQL.Add(' LEFT JOIN MAILS AS M            ');
                SQL.Add('        ON (MAI_PES_ID = PES_ID) ');
                SQL.Add(' WHERE PES_ID       = :CLI_BUSCA ');
                SQL.ADD(' OR    PES_DOC      = :CLI_BUSCA ');
                SQL.Add(' OR    MAI_EMAIL    = :CLI_BUSCA ');
                SQL.ADD(' OR    TEL_TELEFONE = :CLI_BUSCA ');
                SQL.Add(' OR    PES_NOME LIKE' +
                              QuotedStr('%' + vfValue + '%'));
                ParamByName('CLI_BUSCA').AsString := vfValue; // passa o valor do parametro
                Open; // faz a pesquisa

                if not(IsEmpty) then
                begin
                    // insere os dados nos campos
                    gvPES_ID         :=                FieldByName('PES_ID').AsInteger;
                    gvPES_DOC        :=           Trim(FieldByName('PES_DOC').AsString);
                    gvPES_NOME       :=  NameCase(Trim(FieldByName('PES_NOME').AsString), 'y');
                    gvPES_NASCIMENTO :=                FieldByName('PES_NASCIMENTO').AsDateTime;
                    gvTEL_DDD        :=           Trim(FieldByName('TEL_DDD').AsString);
                    gvTEL_TELEFONE   :=           Trim(FieldByName('TEL_TELEFONE').AsString);
                    gvMAI_EMAIL      := LowerCase(Trim(FieldByName('MAI_EMAIL').AsString));
                end;
            end;

            Result := not(qryAuxCli.IsEmpty); // derfine o resultado
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
            qryAuxCli := TFDQuery.Create(nil); // cria a query

        try
            with qryAuxCli do
            begin
                Connection := frmDBConnect.FDConnect; // define o bando de dados

//##################################
//## TABELA CLIENTES ###############
//##################################

                // insere o sql
                SQL.Add(' UPDATE PESSOAS SET ');
                SQL.Add(' PES_DOC        = :PES_DOC,       ');
                SQL.Add(' PES_NOME       = :PES_NOME,      ');
                SQL.Add(' PES_NASCIMENTO = :PES_NASCIMENTO ');
                SQL.Add(' WHERE PES_ID   = :PES_ID         ');

                // insere os dados na query
                ParamByName('PES_ID').AsInteger      := vfValue;
                ParamByName('PES_DOC').AsString      := vcPES_CPF;
                ParamByName('PES_NOME').AsString     := vcPES_NOME;
                ParamByName('PES_NASCIMENTO').AsDate := vcPES_NASCIMENTO;
                ExecSQL; // executa o SQL
                SQL.Clear; // limpa

//##################################
//## TABELA TELEFONES ##############
//##################################

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
                    SQL.ADD(' TEL_DDD      = :TEL_DDD,       ');
                    SQL.Add(' TEL_TELEFONE = :TEL_TELEFONE   ');
                    SQL.ADD(' WHERE TEL_PES_ID = :TEL_PES_ID ');
                end
                else
                begin
                    // insere o telefone
                    SQL.Add(' INSERT INTO TELEFONES                  ');
                    SQL.ADD(' (TEL_PES_ID, TEL_DDD, TEL_TELEFONE)    ');
                    SQL.ADD(' VALUES                                 ');
                    SQL.ADD(' (:TEL_PES_ID, :TEL_DDD, :TEL_TELEFONE) ');
                end;

                // passa os valores
                ParamByName('TEL_PES_ID').AsInteger  := vfValue;
                ParamByName('TEL_DDD').AsString      := vcTEL_DDD;
                ParamByName('TEL_TELEFONE').AsString := vcTEL_TELEFONE;
                ExecSQL; // executa
                SQL.Clear; // limpa

//##################################
//## TABELA E-MAIL #################
//##################################

                // verifica se encontrou um email
                SQL.Add(' SELECT MAI_ID FROM MAILS WHERE MAI_PES_ID = :MAI_PES_ID');
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
                        SQL.ADD(' MAI_EMAIL = :MAI_EMAIL         ');
                        SQL.ADD(' WHERE MAI_PES_ID = :MAI_PES_ID ');
                    end
                    else
                    begin
                        // insere o e-mail
                        SQL.Add(' INSERT INTO MAILS         ');
                        SQL.ADD(' (MAI_PES_ID, MAI_EMAIL)   ');
                        SQL.ADD(' VALUES                    ');
                        SQL.ADD(' (:MAI_PES_ID, :MAI_EMAIL) ');
                    end;

                    // passa os valores
                    ParamByName('MAI_PES_ID').AsInteger := vfValue;
                    ParamByName('MAI_EMAIL').AsString   := vcMAI_EMAIL;
                    ExecSQL; // executa
                end;
            end;

            // atualiza as variáveis
            gvPES_DOC        := vcPES_CPF;
            gvPES_NOME       := vcPES_NOME;
            gvPES_NASCIMENTO := vcPES_NASCIMENTO;
            gvTEL_DDD        := vcTEL_DDD;
            gvTEL_TELEFONE   := vcTEL_TELEFONE;
            gvMAI_EMAIL      := vcMAI_EMAIL;

            Result := not(qryAuxCli.IsEmpty); // derfine o resultado
        except
            //
            Result := False;
        end;
    finally
        cDisconnect(); // desconecta

        pesSearch(IntToStr(vfValue));
    end;
end;

end.
