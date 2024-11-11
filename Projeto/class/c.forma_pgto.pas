unit c.forma_pgto;

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
    TForma_Pgto = class

    private
        {Private declarations}
    public
        {Public declarations}
//        constructor Create(ccConnection: TFDConnection);
//        destructor  Destroy; override;
    end;

        procedure cDisconnect();

        function fpgSearchOne(vfValue: string): Boolean;
        function fpgGetID(vfValue: string): Integer;
        function fpgUpdate(vfValue: Integer): Boolean;

var
    qryAuxFPG             : TFDQuery;
    vFound                : Boolean;
    vOutCount             : Integer;

    vcFPG_ID              : Integer;
    vcFPG_STATUS          : string;
    vcFPG_NOME            : string;
    vcFPG_DATA_ATUALIZADO : TDateTime;

implementation

{ TForma_Pgto }

uses untDBConnect, untFunctions, untSource;

procedure cDisconnect();
begin
    qryAuxFPG.Close; // fecha a query
    qryAuxFPG.Free; // descarrega a query

    frmDBConnect.DBDisconnect; // desconecta
end;

function fpgSearchOne(vfValue: string): Boolean;
begin
    // remove possiveis espaços
    vfValue := Trim(vfValue);

    try
        // conecta
        if not(frmDBConnect.DBConnect) then
            Exit
        else
            qryAuxFPG := TFDQuery.Create(nil); // cria a query

        try
            with qryAuxFPG do
            begin
                Connection := frmDBConnect.FDConnect; // define o bando de dados

                // insere o sql
                SQL.Add(' SELECT * FROM FORMA_PGTO   ');
                SQL.Add('  WHERE FPG_ID = :FPG_BUSCA ');
                SQL.Add('     OR FPG_NOME LIKE'       +
                        QuotedStr('%' + vfValue + '%'));
                SQL.Add('     OR FPG_NOME_SCE LIKE'   +
                        QuotedStr('%' + vfValue + '%'));
                ParamByName('FPG_BUSCA').AsString := vfValue; // passa o valor do parametro
                Open; // faz a pesquisa

                if not(IsEmpty) then
                begin
                    // insere os dados nos campos
                    gvFPG_ID              :=      FieldByName('FPG_ID').AsInteger;
                    gvFPG_STATUS          := Trim(FieldByName('FPG_STATUS').AsString);
                    gvFPG_NOME            := Trim(FieldByName('FPG_NOME').AsString);
                    gvFPG_DATA_ATUALIZADO :=      FieldByName('FPG_DATA_ATUALIZADO').AsDateTime;
                end;

                vOutCount := RecordCount;
            end;

            Result := not(qryAuxFPG.IsEmpty); // derfine o resultado
        except
            //
            Result := False;
        end;
    finally
        cDisconnect(); // desconecta
    end;
end;

function fpgGetID(vfValue: string): Integer;
begin
{
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
                SQL.Add(' (FPG_FPG_ID) VALUES (-5) ');
                ExecSQL; // executa o SQL
                SQL.Clear; // limpa

                // insere o SQL
                SQL.Add(' SELECT FPG_ID         ');
                SQL.ADD(' FROM ATENDIMENTOS     ');
                SQL.ADD(' WHERE FPG_FPG_ID = -5 ');
                Open; // abre

                gvFPG_ID := FieldByName('FPG_ID').AsInteger; // armazena o id gerado
                Result   := gvFPG_ID; // define o resultado
            end;
        except
            Result := 0; // define o resultado
        end;
    finally
        cDisconnect(); // desconecta
    end;
}
end;

function fpgUpdate(vfValue: Integer): Boolean;
begin
{
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

//##############################################################################
//## TABELA ATENDIMENTOS #######################################################
//##############################################################################

                // insere o sql
                SQL.Add(' UPDATE ATENDIMENTOS SET            ');
                SQL.Add(' FPG_FPG_ID      = :FPG_FPG_ID,     ');
                SQL.Add(' FPG_DATA        = :FPG_DATA,       ');
                SQL.Add(' FPG_HORA        = :FPG_HORA,       ');
                SQL.Add(' FPG_DURACAO     = :FPG_DURACAO,    ');
                SQL.Add(' FPG_VALOR       = :FPG_VALOR,      ');
                SQL.Add(' FPG_OBSERVACOES = :FPG_OBSERVACOES ');
                SQL.Add(' WHERE FPG_ID = :FPG_ID             ');

                // insere os dados na query
                ParamByName('FPG_ID').AsInteger         := vfValue;
                ParamByName('FPG_FPG_ID').AsInteger     := vcFPG_FPG_ID;
                ParamByName('FPG_DATA').AsDateTime      := vcFPG_DATA;
                ParamByName('FPG_HORA').AsDateTime      := vcFPG_HORA;
                ParamByName('FPG_DURACAO').AsInteger    := vcFPG_DURACAO;
                ParamByName('FPG_VALOR').AsFloat        := vcFPG_VALOR;
                ParamByName('FPG_OBSERVACOES').AsString := vcFPG_OBSERVACOES;
//                ExecSQL; // executa o SQL
                SQL.Clear; // limpa

//##############################################################################
//## TABELA ATENDIMENTOS PESSOAS ###############################################
//##############################################################################

                // verifica se encontrou um telefone
                SQL.Add(' SELECT APS_ID FROM ATENDIMENTOS_PESS ');
                SQL.Add(' WHERE APS_FPG_ID = :APS_FPG_ID       ');
                ParamByName('APS_FPG_ID').AsInteger := vfValue; //
                Open; // abre
                vFound := not(IsEmpty); // encontrou
                Close; // fecha
                SQL.Clear; // limpa

                // se não encontrou
                if vFound then
                begin
                    // atualiza o telefone
                    SQL.Add(' UPDATE ATENDIMENTOS_PESS SET   ');
                    SQL.Add(' APS_PES_ID = :APS_PES_ID       ');
                    SQL.ADD(' WHERE APS_FPG_ID = :APS_FPG_ID ');
                end
                else
                begin
                    // insere o telefone
                    SQL.Add(' INSERT INTO ATENDIMENTOS_PESS ');
                    SQL.ADD(' (APS_FPG_ID, APS_PES_ID)      ');
                    SQL.ADD(' VALUES                        ');
                    SQL.ADD(' (:APS_FPG_ID, :APS_PES_ID)    ');
                end;

                // passa os valores
                ParamByName('APS_FPG_ID').AsInteger := vfValue;
                ParamByName('APS_PES_ID').AsInteger := gvPES_ID;
//                ExecSQL; // executa
                SQL.Clear; // limpa

//##############################################################################
//## TABELA ATENDIMENTOS PROCEDIMENTOS #########################################
//##############################################################################

                // verifica se encontrou um telefone
                SQL.Add(' SELECT APC_ID FROM ATENDIMENTOS_PROC ');
                SQL.Add(' WHERE APC_FPG_ID = :APC_FPG_ID       ');
                ParamByName('APC_FPG_ID').AsInteger := vfValue; //
                Open; // abre
                vFound := not(IsEmpty); // encontrou
                Close; // fecha
                SQL.Clear; // limpa

                // se não encontrou
                if vFound then
                begin
                    // atualiza o telefone
                    SQL.Add(' UPDATE ATENDIMENTOS_PROC SET   ');
                    SQL.Add(' APC_PCR_ID = :APC_PCR_ID       ');
                    SQL.ADD(' WHERE APC_FPG_ID = :APC_FPG_ID ');
                end
                else
                begin
                    // insere o telefone
                    SQL.Add(' INSERT INTO ATENDIMENTOS_PROC ');
                    SQL.ADD(' (APC_FPG_ID, APC_PCR_ID)      ');
                    SQL.ADD(' VALUES                        ');
                    SQL.ADD(' (:APC_FPG_ID, :APC_PCR_ID)    ');
                end;

                // passa os valores
                ParamByName('APC_FPG_ID').AsInteger := vfValue;
                ParamByName('APC_PCR_ID').AsInteger := gvPRC_ID;
//                ExecSQL; // executa
                SQL.Clear; // limpa

//##############################################################################
//## TABELA ATENDIMENTOS PROFISSIONAL ##########################################
//##############################################################################

                // verifica se encontrou um telefone
                SQL.Add(' SELECT APF_ID FROM ATENDIMENTOS_PROF ');
                SQL.Add(' WHERE APF_FPG_ID = :APF_FPG_ID       ');
                ParamByName('APF_FPG_ID').AsInteger := vfValue; //
                Open; // abre
                vFound := not(IsEmpty); // encontrou
                Close; // fecha
                SQL.Clear; // limpa

                // se não encontrou
                if vFound then
                begin
                    // atualiza o telefone
                    SQL.Add(' UPDATE ATENDIMENTOS_PROF SET   ');
                    SQL.Add(' APF_PCR_ID = :APF_PCR_ID       ');
                    SQL.ADD(' WHERE APF_FPG_ID = :APF_FPG_ID ');
                end
                else
                begin
                    // insere o telefone
                    SQL.Add(' INSERT INTO ATENDIMENTOS_PROF ');
                    SQL.ADD(' (APF_FPG_ID, APF_PCR_ID)      ');
                    SQL.ADD(' VALUES                        ');
                    SQL.ADD(' (:APF_FPG_ID, :APF_PCR_ID)    ');
                end;

                // passa os valores
                ParamByName('APF_FPG_ID').AsInteger := vfValue;
                ParamByName('APF_PCR_ID').AsInteger := gvPRC_ID;
//                ExecSQL; // executa
                SQL.Clear; // limpa
            end;

            // atualiza as variáveis
            gvFPG_FPG_ID      := vcFPG_FPG_ID;
            gvFPG_DATA        := vcFPG_DATA;
            gvFPG_HORA        := vcFPG_HORA;
            gvFPG_DURACAO     := vcFPG_DURACAO;
            gvFPG_VALOR       := vcFPG_VALOR;
            gvFPG_OBSERVACOES := vcFPG_OBSERVACOES;

            Result := not(qryAuxCli.IsEmpty); // derfine o resultado
        except
            //
            Result := False;
        end;
    finally
        cDisconnect(); // desconecta

        fpgSearch(IntToStr(vfValue));
    end;
}
end;

end.
