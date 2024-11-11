unit untLst_Registro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untStandard, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Datasnap.DBClient, Datasnap.Provider,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmLst_Registro = class(TfrmStandard)
    qryLst: TFDQuery;
    dspLst: TDataSetProvider;
    cdsLst: TClientDataSet;
    dtsLst: TDataSource;
    dbgList: TDBGrid;
    btnSet: TImage;

    procedure FormActivate(Sender: TObject);

    procedure dbgListDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);

    procedure btnSetClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_Registro: TfrmLst_Registro;

implementation

{$R *.dfm}

uses untSource, untStyle;

procedure TfrmLst_Registro.btnSetClick(Sender: TObject);
begin
//  inherited;
    //
    Self.Tag := cdsLst.FieldByName('ID').AsInteger;
    //
    Close;
end;

procedure TfrmLst_Registro.dbgListDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
//  inherited;
    //
    setZebraDbg(Self.dbgList, (Sender as TObject), Rect, DataCol, Column, State);
end;

procedure TfrmLst_Registro.FormActivate(Sender: TObject);
begin
//  inherited;
    //
    if Self.Hint <> '' then
        lblTitleForm.Caption := 'Correspondências encontradas para "' + Self.Hint + '"'
    else
        lblTitleForm.Caption := 'Localizar...';

    // seleciona dos dados
    with qryLst do
    begin
        Close;
        SQL.Clear;

        if Self.Caption = 'Cliente' then
        begin
            SQL.Add(' SELECT PES_NOME AS NOME, PES_ID AS ID ');
            SQL.Add(' FROM PESSOAS WHERE PES_NOME           ');
            SQL.Add(' LIKE ' + QuotedStr('%' +
                                Self.Hint + '%')             );
            SQL.Add(' AND PES_ID > 0                        ');
        end
        else
        if Self.Caption = 'Procedimento' then
        begin
            SQL.Add(' SELECT PRC_NOME AS NOME, PRC_ID AS ID ');
            SQL.Add(' FROM PROCEDIMENTOS WHERE PRC_NOME     ');
            SQL.Add(' LIKE ' + QuotedStr('%' +
                                Self.Hint + '%')             );
            SQL.Add(' AND PRC_ID > 0                        ');
        end
        else
        if Self.Caption = 'Pagamento' then
        begin
            SQL.Add(' SELECT FPG_NOME AS NOME, FPG_ID AS ID ');
            SQL.Add(' FROM FORMA_PGTO WHERE FPG_NOME        ');
            SQL.Add(' LIKE ' + QuotedStr('%' +
                                Self.Hint + '%')             );
            SQL.Add(' AND FPG_ID > 0                        ');
        end
        else
        if Self.Caption = 'Compromisso' then
        begin
            SQL.Add(' SELECT CMP_NOME AS NOME, CMP_ID AS ID ');
            SQL.Add(' FROM COMPROMISSO WHERE CMP_NOME       ');
            SQL.Add(' LIKE ' + QuotedStr('%' +
                                Self.Hint + '%')             );
            SQL.Add(' AND CMP_ID > 0                        ');
        end;

        Open;
    end;

    // carrega os dados no CDS
    cdsLst.Open;
    cdsLst.Refresh;

    // oculta a barra de rolagem horizontal
    ShowScrollBar(dbgList.handle, SB_HORZ, False);
end;

end.




