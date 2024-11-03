unit untCli_Cadastro;

interface

uses
  untStandard,

  Winapi.Windows,

  System.Variants, System.Classes, System.SysUtils,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.WinXPickers,

  ArEdit;

type
  TfrmCli_Cadastro = class(TfrmStandard)
    pnlForm: TPanel;
    pnlCPF: TPanel;
    Label30: TLabel;
    Shape11: TShape;
    txtCPF: TArEdit;
    pnlNome: TPanel;
    lblNome: TLabel;
    Shape12: TShape;
    txtNome: TArEdit;
    pnlNascimento: TPanel;
    Label32: TLabel;
    Shape13: TShape;
    pnlCelular: TPanel;
    Panel15: TPanel;
    Label33: TLabel;
    Shape14: TShape;
    txtDDD: TArEdit;
    Panel16: TPanel;
    Label34: TLabel;
    Shape15: TShape;
    txtTelefone: TArEdit;
    pnlEmail: TPanel;
    Label35: TLabel;
    Shape16: TShape;
    txtEmail: TArEdit;
    pnlBusca: TPanel;
    Label36: TLabel;
    Shape19: TShape;
    btnBuscar: TImage;
    txtBusca: TArEdit;
    txtNascimento: TDatePicker;

    function wasChanged(): Boolean;
    function requiredField():Boolean;

    procedure clearFields();
    procedure vTransfer();
    procedure vSearch(vpSearch: string);

    procedure FormCreate(Sender: TObject);

    procedure txtBuscaKeyPress(Sender: TObject; var Key: Char);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnCloseFormClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);

  private
    { Private declarations }
    vCount: Integer;

  public
    { Public declarations }
  end;

var
  frmCli_Cadastro: TfrmCli_Cadastro;

implementation

{$R *.dfm}

uses c.pessoas, untFunctions, untSource;

function TfrmCli_Cadastro.requiredField(): Boolean;
begin
    // zera o contador
    vCount := 0;

    // compara os dados
    if Trim(txtNome.Text) = '' then
        inc(vCount);

    if Trim(txtTelefone.Text) = '' then
        inc(vCount);

    // define o resultado final
    Result := (vCount = 0);
end;

function TfrmCli_Cadastro.wasChanged(): Boolean;
begin
    // zera o contador
    vCount := 0;

    // compara os dados
    if removeChar(gvPES_DOC) <> removeChar(txtCPF.Text) then
        inc(vCount);
    if Trim(gvPES_NOME) <> Trim(txtNome.Text) then
        inc(vCount);
    if gvPES_NASCIMENTO <> txtNascimento.Date then
        inc(vCount);
    if Trim(gvTEL_DDD) <> Trim(txtDDD.Text) then
        inc(vCount);
    if Trim(gvTEL_TELEFONE) <> Trim(txtTelefone.Text) then
        inc(vCount);
    if Trim(gvMAI_EMAIL) <> Trim(txtEmail.Text) then
        inc(vCount);

    // define o resultado final
    Result := (vCount <> 0);
end;

procedure TfrmCli_Cadastro.btnBuscarClick(Sender: TObject);
begin
  inherited;
    vSearch(txtBusca.Text); // faz a busca
end;

procedure TfrmCli_Cadastro.btnCloseFormClick(Sender: TObject);
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
            // transfere os dados
            vTransfer();

            // se não houver um cadastro
            if gvPES_ID = 0 then
                pesUpdate(pesGetID(txtNome.Text)) // atualiza o cadastro
            else
                pesUpdate(gvPES_ID); // atualiza o cadastro
        end;
    end;

    inherited;
end;

procedure TfrmCli_Cadastro.btnSaveClick(Sender: TObject);
begin
  inherited;
    // verifica se alguma informação foi alterada
    if not(wasChanged) then
        Exit;

    // valida os campos obrigatórios
    if not(requiredField) then
        Exit;

    // transfere os dados
    vTransfer();

    // se não houver um cadastro
    if gvPES_ID = 0 then
        pesUpdate(pesGetID(txtNome.Text)) // atualiza o cadastro
    else
        pesUpdate(gvPES_ID); // atualiza o cadastro
end;

procedure TfrmCli_Cadastro.clearFields();
begin
    // limpa os campos
    txtCPF.Text        := '';
    txtNome.Text       := '';
    txtNascimento.Date := Now - 1830;
    txtDDD.Text        := '';
    txtTelefone.Text   := '';
    txtEmail.Text      := '';
end;

procedure TfrmCli_Cadastro.FormCreate(Sender: TObject);
begin
    // define o tamanho do form
    Self.ClientHeight := 500;
    Self.ClientWidth  := 350;

    // limpa as variáveis
    gvPES_ID         := 0;
    gvPES_DOC        := '';
    gvPES_NOME       := '';
    gvPES_NASCIMENTO := Now - 1830;
    gvTEL_DDD        := '';
    gvTEL_TELEFONE   := '';
    gvMAI_EMAIL      := '';

    clearFields();

  inherited;
end;

procedure TfrmCli_Cadastro.vSearch(vpSearch: string);
begin
    // verifica se o campo está vazio
    if Trim(vpSearch) = '' then
        Exit;

    // faz a pesquisa dos dados informados no campo código
    if not pesSearch(vpSearch) then
    begin
        // exibe a mensagem para o usuario
        if (showMsg({janela de ogigem}    Self.Caption,
                    {título da mensagem}  'Cliente não encontrado!',
                    {mensagem ao usuário} formatDocs(vpSearch) + sLineBreak + sLineBreak +
                                          'Deseja realizar o cadastro?',
                    {caminho do ícone}    'question', {check/error/question/exclamation}
                    {botão}               'y/n', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                    {nome do link}        '',
                    {link}                ''
                   )) then
        begin
            txtCPF.Text := vpSearch; // preenche o campo
            txtCPF.SetFocus; // envia o foco
        end
        else
        begin
            txtBusca.SetFocus; // envia o foco
        end;
    end
    else
    begin
        // preenche os campos
        txtCPF.Text        := formatDocs(gvPES_DOC);
        txtNome.Text       := gvPES_NOME;
        txtNascimento.Date := gvPES_NASCIMENTO;
        txtDDD.Text        := gvTEL_DDD;
        txtTelefone.Text   := gvTEL_TELEFONE;
        txtEmail.Text      := gvMAI_EMAIL;
    end;
end;

procedure TfrmCli_Cadastro.vTransfer;
begin
    // transfere o valor dos campos para a classe
    c.pessoas.vcPES_DOC        := Trim(txtCPF.Text);
    c.pessoas.vcPES_NOME       := NameCase(Trim(txtNome.Text), 'y');
    c.pessoas.vcPES_NASCIMENTO := txtNascimento.Date;

    c.pessoas.vcTEL_DDI        := getNumber(gvDDI);
    c.pessoas.vcTEL_DDD        := txtDDD.Text;
    c.pessoas.vcTEL_TELEFONE   := txtTelefone.Text;

    c.pessoas.vcMAI_EMAIL      := LowerCase(Trim(txtEmail.Text));
end;

procedure TfrmCli_Cadastro.txtBuscaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
    // verifica se a tecla <enter> foi pressionada
    if Key = #13 then
    begin
        Key := #0; // impede que o som seja emitido
        vSearch(txtBusca.Text); // faz pesquisa
    end;
end;

end.
