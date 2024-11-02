unit c.atendimentos;

interface

uses
  System.SysUtils,

  Data.DB,

  FireDAC.Phys.MySQLDef, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.DApt,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.FMXUI.Wait, FireDAC.Stan.Intf,
  FireDAC.Phys.MySQL, FireDAC.Stan.Async, FireDAC.VCLUI.Wait, FireDAC.Stan.Error,
  FireDAC.Phys.Intf, FireDAC.Stan.Pool, FireDAC.DApt.Intf, FireDAC.Stan.Def,
  FireDAC.UI.Intf, FireDAC.Comp.UI, FireDAC.Phys, FireDAC.DatS
  ;


type
    TAtendimentos = class

    private
        {Private declarations}
        qryAuxCli: TFDQuery;
    public
        {Public declarations}
//        constructor Create(ccConnection: TFDConnection);
//        destructor  Destroy; override;
    end;

        procedure cDisconnect();

        function atdSearch(vfValue: string): Boolean;
        function atdGetID(vfValue: string): Integer;
        function atdUpdate(vfValue: Integer): Boolean;

var
    qryAuxCli: TFDQuery;

implementation

uses untDBConnect, untFunctions, untSource;

procedure cDisconnect();
begin
    qryAuxCli.Close; // fecha a query
    qryAuxCli.Free; // descarrega a query

    frmDBConnect.DBDisconnect; // desconecta
end;

function atdSearch(vfValue: string): Boolean;
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
                SQL.Add(' SELECT * FROM ATENDIMENTOS      ');
                SQL.Add(' WHERE PRC_ID       = :PRC_BUSCA ');
                SQL.Add(' OR    PRC_NOME LIKE' +
                              QuotedStr('%' + vfValue + '%'));
                ParamByName('PRC_BUSCA').AsString := vfValue; // passa o valor do parametro
                Open; // faz a pesquisa

                if not(IsEmpty) then
                begin
                    // insere os dados nos campos
                    gvPRC_ID              :=               FieldByName('PRC_ID').AsInteger;
                    gvPRC_PRF_ID          :=               FieldByName('PRC_PRF_ID').AsInteger;
                    gvPRC_EQP_ID          :=               FieldByName('PRC_EQP_ID').AsInteger;
                    gvPRC_CAT_ID          :=               FieldByName('PRC_CAT_ID').AsInteger;
                    gvPRC_INC             :=               FieldByName('PRC_INC').AsDateTime;
                    gvPRC_STATUS          :=          Trim(FieldByName('PRC_STATUS').AsString);
                    gvPRC_NOME            := NameCase(Trim(FieldByName('PRC_NOME').AsString), 'y');
                    gvPRC_DESC            :=          Trim(FieldByName('PRC_DESC').AsString);
                    gvPRC_DURACAO         :=               FieldByName('PRC_DURACAO').AsInteger;
                    gvPRC_VALOR           :=               FieldByName('PRC_VALOR').AsFloat;
                    gvPRC_REQUISITO       :=          Trim(FieldByName('PRC_REQUISITO').AsString);
                    gvPRC_CUIDADOS        :=          Trim(FieldByName('PRC_CUIDADOS').AsString);
                    gvPRC_RISCOS          :=          Trim(FieldByName('PRC_RISCOS').AsString);
                    gvPRC_DATA_ATUALIZADO :=               FieldByName('PRC_DATA_ATUALIZADO').AsDateTime;
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

function atdGetID(vfValue: string): Integer;
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
                SQL.Add(' INSERT INTO ATENDIMENTOS ');
                SQL.Add(' (ATD_FPG_ID) VALUES (-5) ');
                ExecSQL; // executa o SQL
                SQL.Clear; // limpa

                // insere o SQL
                SQL.Add(' SELECT ATD_ID         ');
                SQL.ADD(' FROM ATENDIMENTOS     ');
                SQL.ADD(' WHERE ATD_FPG_ID = -5 ');
                Open; // abre

                gvATD_ID := FieldByName('ATD_ID').AsInteger; // armazena o id gerado
                Result   := gvATD_ID; // define o resultado
            end;
        except
            Result := 0; // define o resultado
        end;
    finally
        cDisconnect(); // desconecta
    end;
end;

function atdUpdate(vfValue: Integer): Boolean;
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
//## TABELA ATENDIMENTOS ###########
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

        atdSearch(IntToStr(vfValue));
    end;
end;

end.
