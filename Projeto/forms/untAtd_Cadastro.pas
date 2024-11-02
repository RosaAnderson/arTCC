unit untAtd_Cadastro;

interface

uses
  untStandard, c.pessoas,

  Winapi.Windows, Winapi.Messages,

  System.SysUtils, System.Variants, System.Classes,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.WinXCalendars, Vcl.WinXPickers, Vcl.Buttons, Vcl.Imaging.pngimage,

  ArEdit
  ;

type
  TfrmAtd_Cadastro = class(TfrmStandard)
    pnlObsercacoes: TPanel;
    Label4: TLabel;
    Shape4: TShape;
    pnlInicio: TPanel;
    Panel6: TPanel;
    Label1: TLabel;
    Shape2: TShape;
    txtHora: TTimePicker;
    Panel7: TPanel;
    Label3: TLabel;
    Shape3: TShape;
    txtData: TDatePicker;
    pnlFim: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Shape5: TShape;
    Panel3: TPanel;
    Label5: TLabel;
    Shape6: TShape;
    pnlProcedimento: TPanel;
    Label36: TLabel;
    Shape19: TShape;
    btnProcedimentoSearch: TImage;
    txtProcedimento: TArEdit;
    pnlCliente: TPanel;
    Label7: TLabel;
    Shape7: TShape;
    btnClienteSearch: TImage;
    txtCliente: TArEdit;
    Shape1: TShape;
    Shape8: TShape;
    txtObservacoes: TMemo;
    Shape9: TShape;
    txtDuracao: TArEdit;
    txtValor: TArEdit;

    function wasChanged(): Boolean;
    function requiredField():Boolean;
    function getObjName(Sender: TObject):string;

    procedure vSearch(vpSearch, vpField: string);
    procedure txtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure btnSearchClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure btnCloseFormClick(Sender: TObject);

  private
    { Private declarations }
    vField: string;
    vCount: Integer;

//    vDataI, vDataF: TDate;
//    vHoraI, vHoraF: TTime;

  public
    { Public declarations }
  end;

var
  frmAtd_Cadastro: TfrmAtd_Cadastro;

implementation

{$R *.dfm}

uses untDBConnect, untFunctions, untSource, c.procedimentos, c.atendimentos;

procedure TfrmAtd_Cadastro.btnCloseFormClick(Sender: TObject);
begin
    // verifica se alguma informação foi alterada
    if ((wasChanged) and (requiredField)) then
    begin
        if (showMsg({janela de ogigem}    Self.Caption,
                    {título da mensagem}  'Salvar',
                    {mensagem ao usuário} 'Um ou mais dados foram alterados.' + sLineBreak + sLineBreak +
                                          'Deseja salvar antes de sair?',
                    {caminho do ícone}    'question', {check/error/question/exclamation}
                    {botão}               'y/n', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                    {nome do link}        '',
                    {link}                ''
                   )) then
        begin
            // se não houver um cadastro
            if gvATD_ID = 0 then
                atdUpdate(atdGetID(txtCliente.Text)) // atualiza o cadastro
            else
                atdUpdate(gvATD_ID); // atualiza o cadastro
        end;
    end;

    inherited;
end;

procedure TfrmAtd_Cadastro.btnSaveClick(Sender: TObject);
begin
  inherited;
    // verifica se alguma informação foi alterada
    if not(wasChanged) then
        Exit;
{
    // valida os campos obrigatórios
    if not(requiredField) then
        Exit;
}
    // se não houver um cadastro
    if gvATD_ID = 0 then
        atdUpdate(atdGetID(txtCliente.Text)) // atualiza o cadastro
    else
       atdUpdate(gvATD_ID); // atualiza o cadastro
end;

procedure TfrmAtd_Cadastro.btnSearchClick(Sender: TObject);
begin
    vField := getObjName(Sender); // define a origem

    // verifica onde será a busca
    if vField = 'Cliente' then
        vSearch(txtCliente.Text, vField) // faz a busca
    else
    if vField = 'Procedimento' then
        vSearch(txtProcedimento.Text, vField); // faz a busca
end;

procedure TfrmAtd_Cadastro.FormCreate(Sender: TObject);
begin
    // define o tamanho do form
    Self.ClientHeight := 500;
    Self.ClientWidth  := 350;

    txtData.Date      := Now;
    txtHora.Time      := Now;

    gvATD_ID          := 0;
    gvATD_DATA        := Now - 1;
    gvATD_HORA        := Now - 1;
    gvATD_DURACAO     := 0;
    gvATD_VALOR       := 0.00;
    gvATD_OBSERVACOES := '';

  inherited;
end;

function TfrmAtd_Cadastro.getObjName(Sender: TObject): string;
var
    vI, vF: Integer;
begin
    // define a origem e o tamanho
    vI := 4;
    vF := 30;

    // verifica qual a origem
    if (Sender is TArEdit) then
        Result := Copy((Sender as TArEdit).Name, vI, vF)
    else
    if (Sender is TImage) then
        Result := Copy((Sender as TImage).Name, vI, vF)
end;

function TfrmAtd_Cadastro.requiredField: Boolean;
begin
    // zera o contador
    vCount := 0;

    // compara os dados
    if pnlCliente.Tag < 1 then
        inc(vCount);

    if pnlProcedimento.Tag < 1 then
        inc(vCount);

    if Trim(txtDuracao.Text) = '' then
        inc(vCount);

    if Trim(txtvalor.Text) = '' then
        inc(vCount);

    // define o resultado final
    Result := (vCount = 0);
end;

procedure TfrmAtd_Cadastro.txtSearchKeyPress(Sender: TObject; var Key: Char);
var
    vField: string;
begin
  inherited;
    // verifica se a tecla <enter> foi pressionada
    if Key = #13 then
    begin
        Key := #0; // impede que o som seja emitido

        vField := getObjName(Sender); // define a origem

        // verifica onde será a busca
        if vField = 'Cliente' then
            vSearch(txtCliente.Text, vField) // faz a busca
        else
        if vField = 'Procedimento' then
            vSearch(txtProcedimento.Text, vField); // faz a busca
    end;
end;

procedure TfrmAtd_Cadastro.vSearch(vpSearch, vpField: string);
begin
    // verifica se o campo está vazio
    if Trim(vpSearch) = '' then
        Exit;

    // faz a pesquisa dos dados informados no campo código
    if ((not pesSearch(vpSearch)) and (not prcSearch(vpSearch))) then
    begin
        // exibe a mensagem para o usuario
        if (showMsg({janela de ogigem}    Self.Caption,
                    {título da mensagem}  vpField + ' não encontrado!',
                    {mensagem ao usuário} formatDocs(vpSearch) + sLineBreak + sLineBreak +
                                          'Deseja realizar o cadastro?',
                    {caminho do ícone}    'question', {check/error/question/exclamation}
                    {botão}               'y/n', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                    {nome do link}        '',
                    {link}                ''
                   )) then
        begin
            // se for cliente
            if vpField = 'Cliente' then
            begin
                // abrir janela de cadastro de cliente
            end
            else
            // se for procedimento
            if vpField = 'Procedimento' then
            begin
                // abrir janela de cadastro de procedimento
            end;
        end;
    end
    else
    begin
        // preenche os campos
        pnlCliente.Tag       := gvPES_ID;
        txtCliente.Text      := gvPES_NOME;
        pnlProcedimento.Tag  := gvPRC_ID;
        txtProcedimento.Text := gvPRC_NOME;
        txtDuracao.Text      := IntToStr(gvPRC_DURACAO) + ' min.';
        txtValor.Text        := FormatMoney(gvPRC_VALOR);

        if vpField = 'Cliente' then // se for cliente
            txtData.SetFocus// abrir janela de cadastro de cliente
        else
        if vpField = 'Procedimento' then // se for procedimento
            txtDuracao.SetFocus;
    end;
end;

function TfrmAtd_Cadastro.wasChanged: Boolean;
begin
    // zera o contador
    vCount := 0;

    // compara os dados
    if txtData.Date >= Now then
        inc(vCount);

    if txtHora.Time > Now then
        inc(vCount);
{
    if Trim(txtDuracao.Text) = '' then
        inc(vCount);

    if Trim(txtvalor.Text) = '' then
        inc(vCount);
}
    // define o resultado final
    Result := (vCount = 0);
end;

end.





