unit c.compromissos;

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
    TCompromissos = class

    private
        {Private declarations}
    public
        {Public declarations}
//        constructor Create(ccConnection: TFDConnection);
//        destructor  Destroy; override;
    end;

        procedure cDisconnect();

        function atdSearchClk(vfData, vfHora: string): Boolean;
        function atdSearchOne(vfValue: string): Boolean;
        function atdSearchAll(vfValue: string): Boolean;
        function atdGetID(vfValue: string): Integer;
        function atdUpdate(vfValue: Integer): Boolean;
        function atdChange(vfValue: Integer; vfTo: string): Boolean;

var
    qryAuxATD            : TFDQuery;
    vFound               : Boolean;

    vcATD_ID             : Integer;
    vcATD_FPG_ID         : Integer;
    vcATD_INCLUSAO       : TDateTime;
    vcATD_STATUS         : string;
    vcATD_DATA           : TDate;
    vcATD_HORA           : TTime;
    vcATD_DURACAO        : Integer;
    vcATD_VALOR          : Double;
    vcATD_OBSERVACOES    : string;
    vcATD_DATA_ATUALIZADO: TDateTimeField;

    vcAPS_ID             : Integer;
    vcAPS_ATD_ID         : Integer;
    vcAPS_PES_ID         : Integer;
    vcAPS_DATA_ATUALIZADO: TDateTime;

    vcAPC_ID             : Integer;
    vcAPC_ATD_ID         : Integer;
    vcAPC_PRC_ID         : Integer;
    vcAPC_DATA_ATUALIZADO: TDateTime;

    vcAPF_ID             : Integer;
    vcAPF_ATD_ID         : Integer;
    vcAPF_PRF_ID         : Integer;
    vcAPF_DATA_ATUALIZADO: TDateTime;

    vcCLK_ATD_ID         : Integer;
    vcCLK_ATD_NOME       : string;
    vcCLK_ATD_STATUS     : string;

implementation

{ TAtendimentos }

uses untDBConnect, untFunctions, untSource;

procedure cDisconnect();
begin
    qryAuxATD.Close; // fecha a query
    qryAuxATD.Free; // descarrega a query

    frmDBConnect.DBDisconnect; // desconecta
end;

function atdSearchOne(vfValue: string): Boolean;
begin
    //
    Result := True;

    // remove possiveis espa�os
    vfValue := Trim(vfValue);

    try
        // conecta
        if not(frmDBConnect.DBConnect) then
            Exit
        else
            qryAuxATD := TFDQuery.Create(nil); // cria a query

        try
            with qryAuxATD do
            begin
                Connection := frmDBConnect.FDConnect; // define o bando de dados

                // insere o sql
                SQL.Add(' SELECT * FROM ATENDIMENTOS ');
                SQL.Add(' WHERE ATD_ID = :ATD_BUSCA  ');
//                SQL.Add('   AND ATD_STATUS = ''A''   ');

                ParamByName('ATD_BUSCA').AsString := vfValue; // passa o valor do parametro
                Open; // faz a pesquisa

                if not(IsEmpty) then
                begin
                    // insere os dados nos campos
                    gvATD_ID              :=      FieldByName('ATD_ID').AsInteger;
                    gvATD_FPG_ID          :=      FieldByName('ATD_FPG_ID').AsInteger;
                    gvATD_INCLUSAO        :=      FieldByName('ATD_INCLUSAO').AsDateTime;
                    gvATD_STATUS          := Trim(FieldByName('ATD_STATUS').AsString);
                    gvATD_DATA            :=      FieldByName('ATD_DATA').AsDateTime;
                    gvATD_HORA            :=      FieldByName('ATD_HORA').AsDateTime;
                    gvATD_DURACAO         :=      FieldByName('ATD_DURACAO').AsInteger;
                    gvATD_VALOR           :=      FieldByName('ATD_VALOR').AsFloat;
                    gvATD_OBSERVACOES     := Trim(FieldByName('ATD_OBSERVACOES').AsString);
                    gvATD_DATA_ATUALIZADO :=      FieldByName('ATD_DATA_ATUALIZADO').AsDateTime;
                end;
            end;

            Result := not(qryAuxATD.IsEmpty); // derfine o resultado
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
            qryAuxATD := TFDQuery.Create(nil); // cria a query

        try
            with qryAuxATD do
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
    //
    Result := True;

    try
        // conecta
        if not(frmDBConnect.DBConnect) then
            Exit
        else
            qryAuxATD := TFDQuery.Create(nil); // cria a query

        try
            with qryAuxATD do
            begin
                Connection := frmDBConnect.FDConnect; // define o bando de dados

//##############################################################################
//## TABELA ATENDIMENTOS #######################################################
//##############################################################################

                // insere o sql
                SQL.Add(' UPDATE ATENDIMENTOS SET            ');
                SQL.Add(' ATD_FPG_ID      = :ATD_FPG_ID,     ');
                SQL.Add(' ATD_DATA        = :ATD_DATA,       ');
                SQL.Add(' ATD_HORA        = :ATD_HORA,       ');
                SQL.Add(' ATD_DURACAO     = :ATD_DURACAO,    ');
                SQL.Add(' ATD_VALOR       = :ATD_VALOR,      ');
                SQL.Add(' ATD_OBSERVACOES = :ATD_OBSERVACOES ');
                SQL.Add(' WHERE ATD_ID = :ATD_ID             ');

                // insere os dados na query
                ParamByName('ATD_ID').AsInteger         := vfValue;
                ParamByName('ATD_FPG_ID').AsInteger     := vcATD_FPG_ID;
                ParamByName('ATD_DATA').AsDateTime      := vcATD_DATA;
                ParamByName('ATD_HORA').AsDateTime      := StrToTime(FormatDateTime('hh:MM', vcATD_HORA));
                ParamByName('ATD_DURACAO').AsInteger    := vcATD_DURACAO;
                ParamByName('ATD_VALOR').AsFloat        := vcATD_VALOR;
                ParamByName('ATD_OBSERVACOES').AsString := vcATD_OBSERVACOES;
                ExecSQL; // executa o SQL
                SQL.Clear; // limpa

//##############################################################################
//## TABELA ATENDIMENTOS PESSOAS ###############################################
//##############################################################################

                // verifica se encontrou um telefone
                SQL.Add(' SELECT APS_ID FROM ATENDIMENTOS_PESS ');
                SQL.Add(' WHERE APS_ATD_ID = :APS_ATD_ID       ');
                ParamByName('APS_ATD_ID').AsInteger := vfValue; //
                Open; // abre
                vFound := not(IsEmpty); // encontrou
                Close; // fecha
                SQL.Clear; // limpa

                // se n�o encontrou
                if vFound then
                begin
                    // atualiza o telefone
                    SQL.Add(' UPDATE ATENDIMENTOS_PESS SET   ');
                    SQL.Add(' APS_PES_ID = :APS_PES_ID       ');
                    SQL.ADD(' WHERE APS_ATD_ID = :APS_ATD_ID ');
                end
                else
                begin
                    // insere o telefone
                    SQL.Add(' INSERT INTO ATENDIMENTOS_PESS ');
                    SQL.ADD(' (APS_ATD_ID, APS_PES_ID)      ');
                    SQL.ADD(' VALUES                        ');
                    SQL.ADD(' (:APS_ATD_ID, :APS_PES_ID)    ');
                end;

                // passa os valores
                ParamByName('APS_ATD_ID').AsInteger := vfValue;
                ParamByName('APS_PES_ID').AsInteger := gvPES_ID;
                ExecSQL; // executa
                SQL.Clear; // limpa

//##############################################################################
//## TABELA ATENDIMENTOS PROCEDIMENTOS #########################################
//##############################################################################

                // verifica se encontrou um telefone
                SQL.Add(' SELECT APC_ID FROM ATENDIMENTOS_PROC ');
                SQL.Add(' WHERE APC_ATD_ID = :APC_ATD_ID       ');
                ParamByName('APC_ATD_ID').AsInteger := vfValue; //
                Open; // abre
                vFound := not(IsEmpty); // encontrou
                Close; // fecha
                SQL.Clear; // limpa

                // se n�o encontrou
                if vFound then
                begin
                    // atualiza o telefone
                    SQL.Add(' UPDATE ATENDIMENTOS_PROC SET   ');
                    SQL.Add(' APC_PRC_ID = :APC_PRC_ID       ');
                    SQL.ADD(' WHERE APC_ATD_ID = :APC_ATD_ID ');
                end
                else
                begin
                    // insere o telefone
                    SQL.Add(' INSERT INTO ATENDIMENTOS_PROC ');
                    SQL.ADD(' (APC_ATD_ID, APC_PRC_ID)      ');
                    SQL.ADD(' VALUES                        ');
                    SQL.ADD(' (:APC_ATD_ID, :APC_PRC_ID)    ');
                end;

                // passa os valores
                ParamByName('APC_ATD_ID').AsInteger := vfValue;
                ParamByName('APC_PRC_ID').AsInteger := gvPRC_ID;
                ExecSQL; // executa
                SQL.Clear; // limpa

//##############################################################################
//## TABELA ATENDIMENTOS PROFISSIONAL ##########################################
//##############################################################################

                // verifica se encontrou um telefone
                SQL.Add(' SELECT APF_ID FROM ATENDIMENTOS_PROF ');
                SQL.Add(' WHERE APF_ATD_ID = :APF_ATD_ID       ');
                ParamByName('APF_ATD_ID').AsInteger := vfValue; //
                Open; // abre
                vFound := not(IsEmpty); // encontrou
                Close; // fecha
                SQL.Clear; // limpa

                // se n�o encontrou
                if vFound then
                begin
                    // atualiza o telefone
                    SQL.Add(' UPDATE ATENDIMENTOS_PROF SET   ');
                    SQL.Add(' APF_PRF_ID = :APF_PRF_ID       ');
                    SQL.ADD(' WHERE APF_ATD_ID = :APF_ATD_ID ');
                end
                else
                begin
                    // insere o telefone
                    SQL.Add(' INSERT INTO ATENDIMENTOS_PROF ');
                    SQL.ADD(' (APF_ATD_ID, APF_PRF_ID)      ');
                    SQL.ADD(' VALUES                        ');
                    SQL.ADD(' (:APF_ATD_ID, :APF_PRF_ID)    ');
                end;

                // passa os valores
                ParamByName('APF_ATD_ID').AsInteger := vfValue;
                ParamByName('APF_PRF_ID').AsInteger := gvPRF_ID;
                ExecSQL; // executa
                SQL.Clear; // limpa
            end;

            // atualiza as vari�veis
            gvATD_ID          := vfValue;
            gvATD_FPG_ID      := vcATD_FPG_ID;
            gvATD_INCLUSAO    := vcATD_INCLUSAO;
            gvATD_STATUS      := vcATD_STATUS;
            gvATD_DATA        := vcATD_DATA;
            gvATD_HORA        := vcATD_HORA;
            gvATD_DURACAO     := vcATD_DURACAO;
            gvATD_VALOR       := vcATD_VALOR;
            gvATD_OBSERVACOES := vcATD_OBSERVACOES;

            gvAPS_ID          := vfValue;
            gvAPS_ATD_ID      := vcAPS_ATD_ID;
            gvAPS_PES_ID      := vcAPS_PES_ID;

            gvAPC_ID          := vfValue;
            gvAPC_ATD_ID      := vcAPC_ATD_ID;
            gvAPC_PRC_ID      := vcAPC_PRC_ID;

            gvAPF_ID          := vfValue;
            gvAPF_ATD_ID      := vcAPF_ATD_ID;
            gvAPF_PRF_ID      := vcAPF_PRF_ID;
        except
            //
            with qryAuxATD do
            begin
                Connection := frmDBConnect.FDConnect; // define o bando de dados
                SQL.Clear;
                SQL.Add(' DELETE FROM ATENDIMENTOS WHERE ATD_ID = ' +
                          QuotedStr(IntToStr(vfValue)) +
                        ' AND ATD_STATUS = ''A''');
                ExecSQL;
            end;

            //
            Result := False;
        end;
    finally
        cDisconnect(); // desconecta
    end;
end;

function atdSearchAll(vfValue: string): Boolean;
begin
    //
    Result := True;

    // remove possiveis espa�os
    vfValue := Trim(vfValue);

    try
        // conecta
        if not(frmDBConnect.DBConnect) then
            Exit
        else
            qryAuxATD := TFDQuery.Create(nil); // cria a query

        try
            with qryAuxATD do
            begin
                Connection := frmDBConnect.FDConnect; // define o bando de dados

                // insere o sql
                SQL.Add(' SELECT * FROM ATENDIMENTOS ');
                Open; // faz a pesquisa

                if not(IsEmpty) then
                begin
                    // insere os dados nos campos
                    gvATD_ID              :=      FieldByName('ATD_ID').AsInteger;
                    gvATD_FPG_ID          :=      FieldByName('ATD_FPG_ID').AsInteger;
                    gvATD_INCLUSAO        :=      FieldByName('ATD_INCLUSAO').AsDateTime;
                    gvATD_STATUS          := Trim(FieldByName('ATD_STATUS').AsString);
                    gvATD_DATA            :=      FieldByName('ATD_DATA').AsDateTime;
                    gvATD_HORA            :=      FieldByName('ATD_HORA').AsDateTime;
                    gvATD_DURACAO         :=      FieldByName('ATD_DURACAO').AsInteger;
                    gvATD_VALOR           :=      FieldByName('ATD_VALOR').AsFloat;
                    gvATD_OBSERVACOES     := Trim(FieldByName('ATD_OBSERVACOES').AsString);
                    gvATD_DATA_ATUALIZADO :=      FieldByName('ATD_DATA_ATUALIZADO').AsDateTime;
                end;
            end;

            Result := not(qryAuxATD.IsEmpty); // derfine o resultado
        except
            //
            Result := False;
        end;
    finally
        cDisconnect(); // desconecta
    end;
end;

function atdChange(vfValue: Integer; vfTo: string): Boolean;
begin
    Result := True;

    try
        // conecta
        if not(frmDBConnect.DBConnect) then
        begin
            Result := False;
            Exit;
        end
        else
            qryAuxATD := TFDQuery.Create(nil); // cria a query

        try
            with qryAuxATD do
            begin
                Connection := frmDBConnect.FDConnect; // define o bando de dados
                SQL.Clear;
                SQL.Add(' UPDATE ATENDIMENTOS SET    ');
                SQL.Add(' ATD_STATUS = ''C'',        ');
                SQL.Add(' ATD_STATUS = ' +
                          QuotedStr(UpperCase(vfTo))  );
                SQL.Add(' WHERE ATD_ID = ' +
                          QuotedStr(IntToStr(vfValue)));
                ExecSQL;
            end;
        except
            Result := False;
        end;
    finally
        cDisconnect(); // desconecta
    end;
end;

function atdSearchClk(vfData, vfHora: string): Boolean;
begin
    //
    Result           := True;
    vcCLK_ATD_ID     := 0;
    vcCLK_ATD_NOME   := '';
    vcCLK_ATD_STATUS := '';

    try
        // conecta
        if not(frmDBConnect.DBConnect) then
        begin
            Result := False;
            Exit;
        end
        else
            qryAuxATD := TFDQuery.Create(nil); // cria a query

        try
            with qryAuxATD do
            begin
                Connection := frmDBConnect.FDConnect; // define o bando de dados

                SQL.Add(' SELECT                                            ');
                SQL.Add('    ATD_ID, ATD_STATUS, ATD_DATA, ATD_HORA,        ');
                SQL.Add('    PES_NOME                                       ');
                SQL.Add('   FROM ATENDIMENTOS                               ');
                SQL.Add('   JOIN ATENDIMENTOS_PESS ON (APS_ATD_ID = ATD_ID) ');
                SQL.Add('   JOIN PESSOAS ON (PES_ID = APS_PES_ID)           ');
                SQL.Add('  WHERE ATD_DATA = ' + QuotedStr(vfData)            );
                SQL.Add('    AND ATD_HORA = ' + QuotedStr(vfHora + ':00')    );
                SQL.Add('    AND ATD_STATUS <> ''C''                        ');
                Open;

                if not(IsEmpty) then
                begin
                    // insere os dados nos campos
                    vcCLK_ATD_ID     := FieldByName('ATD_ID').AsInteger;
                    vcCLK_ATD_STATUS := FieldByName('ATD_STATUS').AsString;
                    vcCLK_ATD_NOME   := FieldByName('PES_NOME').AsString;
                end;

                Result := not(IsEmpty);
            end;
        except
            //
            Result := False;
        end;
    finally
        cDisconnect(); // desconecta
    end;
end;

end.
