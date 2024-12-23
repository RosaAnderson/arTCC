unit c.procedimentos;

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
    TProcedimentos = class

    private
        {Private declarations}
    public
        {Public declarations}
//        constructor Create(ccConnection: TFDConnection);
//        destructor  Destroy; override;
    end;

        procedure cDisconnect();

        function prcSearchOne(vfValue: string): Boolean;
        function prcGetID(vfValue: string): Integer;
        function prcUpdate(vfValue: Integer): Boolean;

var
    qryAuxPRC : TFDQuery;
    vOutCount : Integer;

implementation

{ TProcedimentos }

uses untDBConnect, untFunctions, untSource;

procedure cDisconnect();
begin
    qryAuxPRC.Close; // fecha a query
    qryAuxPRC.Free; // descarrega a query

    frmDBConnect.DBDisconnect; // desconecta
end;

function prcSearchOne(vfValue: string): Boolean;
begin
    // remove possiveis espa�os
    vfValue := Trim(vfValue);

    try
        // conecta
        if not(frmDBConnect.DBConnect) then
            Exit
        else
            qryAuxPRC := TFDQuery.Create(nil); // cria a query

        try
            with qryAuxPRC do
            begin
                Connection := frmDBConnect.FDConnect; // define o bando de dados

                // insere o sql
                SQL.Add(' SELECT * FROM PROCEDIMENTOS     ');
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
                    gvPRC_INCLUSAO        :=               FieldByName('PRC_INCLUSAO').AsDateTime;
                    gvPRC_STATUS          :=          Trim(FieldByName('PRC_STATUS').AsString);
                    gvPRC_NOME            := NameCase(Trim(FieldByName('PRC_NOME').AsString), 'y');
                    gvPRC_DESCRICAO       :=          Trim(FieldByName('PRC_DESCRICAO').AsString);
                    gvPRC_DURACAO         :=               FieldByName('PRC_DURACAO').AsInteger;
                    gvPRC_VALOR           :=               FieldByName('PRC_VALOR').AsFloat;
                    gvPRC_REQUISITO       :=          Trim(FieldByName('PRC_REQUISITO').AsString);
                    gvPRC_CUIDADOS        :=          Trim(FieldByName('PRC_CUIDADOS').AsString);
                    gvPRC_RISCOS          :=          Trim(FieldByName('PRC_RISCOS').AsString);
                    gvPRC_DATA_ATUALIZADO :=               FieldByName('PRC_DATA_ATUALIZADO').AsDateTime;
                end;

                vOutCount := RecordCount;
            end;
        except
            //
            Result := False;
        end;
    finally
        Result := not(qryAuxPRC.IsEmpty); // derfine o resultado

        cDisconnect(); // desconecta
    end;
end;

function prcGetID(vfValue: string): Integer;
begin
    //
end;

function prcUpdate(vfValue: Integer): Boolean;
begin
    //
end;

end.
