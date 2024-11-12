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
    pnlHoraDia: TPanel;
    pnlHora: TPanel;
    Label1: TLabel;
    Shape2: TShape;
    txtHora: TTimePicker;
    pnlData: TPanel;
    Label3: TLabel;
    Shape3: TShape;
    txtData: TDatePicker;
    pnlProcDetalhes: TPanel;
    pnlValor: TPanel;
    Label2: TLabel;
    Shape5: TShape;
    pnlDuracao: TPanel;
    Label5: TLabel;
    Shape6: TShape;
    pnlProcedimento: TPanel;
    Label36: TLabel;
    Shape19: TShape;
    btnProcedimento: TImage;
    txtProcedimento: TArEdit;
    pnlCliente: TPanel;
    Label7: TLabel;
    Shape7: TShape;
    btnCliente: TImage;
    txtCliente: TArEdit;
    Shape1: TShape;
    Shape8: TShape;
    txtObservacoes: TMemo;
    Shape9: TShape;
    txtDuracao: TArEdit;
    txtValor: TArEdit;
    pnlPagamento: TPanel;
    Label6: TLabel;
    Shape10: TShape;
    btnPagamento: TImage;
    txtPagamento: TArEdit;
    lblDia: TLabel;

    function wasChanged(): Boolean;
    function requiredField():Boolean;
    function getObjName(Sender: TObject):string;

    procedure clearFields();
    procedure vTransfer();
    procedure vSearch(vpSearch, vpField: string);

    procedure FormCreate(Sender: TObject);

    procedure txtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure txtDataChange(Sender: TObject);

    procedure btnSearchClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseFormClick(Sender: TObject);

  private
    { Private declarations }
    vField: string;
    vCount: Integer;

  public
    { Public declarations }
  end;

var
  frmAtd_Cadastro: TfrmAtd_Cadastro;

implementation

{$R *.dfm}

uses untDBConnect, untFunctions, untSource,
    c.procedimentos, c.atendimentos, c.forma_pgto, untPrepareMessage,
  untCli_Cadastro, untLst_Registro;


procedure TfrmAtd_Cadastro.btnCloseFormClick(Sender: TObject);
begin
  inherited;

  exit;




    // verifica se alguma informação foi alterada
//    if ((wasChanged) and (requiredField)) then
    if  (requiredField) then
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
            if gvATD_ID = 0 then
                atdUpdate(atdGetID(txtCliente.Text)) // atualiza o cadastro
            else
                atdUpdate(gvATD_ID); // atualiza o cadastro
        end;
    end;

    inherited;
end;

procedure TfrmAtd_Cadastro.btnSaveClick(Sender: TObject);
var
    vSuccess    : Boolean;
    vActMsg     : string;
    vSND_MESSAGE: string;
begin
  inherited;
{
    // verifica se alguma informação foi alterada
    if not(wasChanged) then
        Exit;
//}
{
    // valida os campos obrigatórios
    if not(requiredField) then
        Exit;
//}
    // transfere os dados
    vTransfer();

    // se não houver um cadastro
    if gvATD_ID = 0 then
    begin
        vSuccess := (atdUpdate(atdGetID(txtCliente.Text))); // atualiza o cadastro
        vActMsg := 'question';
    end
    else
    begin
        vSuccess := (atdUpdate(gvATD_ID)); // atualiza o cadastro
        vActMsg := 'check';
    end;

    //
    if vSuccess then
        try
            if vActMsg = 'question' then
            begin
                // gera a mensagem
                vSND_MESSAGE := createMessage('cadastra', gvPES_NOME,
                                                           FormatDateTime('dd/mm/yyyy', gvATD_DATA),
                                                            FormatDateTime('hh:MM', gvATD_HORA),
                                                             gvPRC_NOME);

                // exibe a mensagem para o usuario
                if (showMsg({janela de ogigem}    Self.Caption,
                            {título da mensagem}  'Atendimento Registrado!',
                            {mensagem ao usuário} 'O atendimento de ' + gvPES_NOME +
                                                  ' para ' + FormatDateTime('dd/mm/yyyy', gvATD_DATA) +
                                                  ' às '   + FormatDateTime('hh:MM', gvATD_DATA) +
                                                  ' foi registrado com sucesso!' +
                                                  sLineBreak + sLineBreak +
                                                  'Deseja cadastrar outro?',
                            {caminho do ícone}    'question', {check/error/question/exclamation}
                            {botão}               'y/n', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                            {nome do link}        '',
                            {link}                ''
                           )) then
                begin
                    //
                    clearFields();
                    txtCliente.SetFocus;
                end
                else
                begin
                    Close;
                end;
            end
            else
            if vActMsg = 'check' then
            begin
                // gera a mensagem
                vSND_MESSAGE := createMessage('altera', gvPES_NOME,
                                                         FormatDateTime('dd/mm/yyyy', gvATD_DATA),
                                                          FormatDateTime('hh:MM', gvATD_HORA),
                                                           gvPRC_NOME);

                // exibe a mensagem para o usuario
                showMsg({janela de ogigem}    Self.Caption,
                        {título da mensagem}  'Atendimento Atualizado!',
                        {mensagem ao usuário} 'O atendimento de ' + gvPES_NOME +
                                              ' foi atualizado com sucesso! ' +
                                              sLineBreak + sLineBreak +
                                              'Data: ' + FormatDateTime('dd/mm/yyyy', gvATD_DATA) + sLineBreak +
                                              'Hora: ' + FormatDateTime('hh:MM', gvATD_DATA),
                        {caminho do ícone}    'check', {check/error/question/exclamation}
                        {botão}               'ok', {'y/n', 'y/n/a', 'ok', 'ok/cancel', 'ok/link'}
                        {nome do link}        '',
                        {link}                '');

                Close;
            end;
        finally
            // valida o numero
            if vcCLK_TEL_TELEFONE = '' then
                vcCLK_TEL_TELEFONE := ValidarPhone(gvTEL_DDI + gvTEL_DDD + gvTEL_TELEFONE)
            else
                vcCLK_TEL_TELEFONE := ValidarPhone(vcCLK_TEL_TELEFONE);

            // envia a mensagem
            vSuccess := getSendResult(SendToWhatsapp(vcCLK_TEL_TELEFONE,
                                                     'mult-notification', 'text', '', '',
                                                     vSND_MESSAGE));
        end;
end;

procedure TfrmAtd_Cadastro.btnSearchClick(Sender: TObject);
begin
    vField := getObjName(Sender); // define a origem

    // verifica se o form foi criado
    if not Assigned(frmLst_Registro) then
        frmLst_Registro := TfrmLst_Registro.Create(nil); // cria o form

    try
        frmLst_Registro.Caption := vField;
        frmLst_Registro.ShowModal; // exibe o form

        if frmLst_Registro.Tag <> 0 then
            vSearch(frmLst_Registro.cdsLst.FieldByName('NOME').AsString, vField) // faz a busca
    finally
        frmLst_Registro := nil;
        frmLst_Registro.Free; // descarrega o objeto
    end;
end;

procedure TfrmAtd_Cadastro.clearFields;
begin
    // limpa os campos
    txtCliente.Text := '';
    pnlCliente.Tag  := 0;

    if (FormatDateTime('ss', txtHora.Time) <> '00') then
    begin
        txtData.Date := Now;
        txtHora.Time := Now;
    end;

    txtProcedimento.Text := '';
    pnlProcedimento.Tag  := 0;
    txtDuracao.Text      := '0 min.';
    txtValor.Text        := 'R$ 0,00';
    txtPagamento.Text    := '';
    pnlPagamento.Tag     := 0;
    txtObservacoes.Clear;
end;

procedure TfrmAtd_Cadastro.FormCreate(Sender: TObject);
begin
    // define o tamanho do form
    Self.ClientHeight := 570;
    Self.ClientWidth  := 350;

//    txtData.Date      := Now;
//    txtHora.Time      := Now;

    if Self.Tag = 0 then
    begin
        gvATD_ID          := 0;
        gvATD_DATA        := Now - 1;
        gvATD_HORA        := Now - 1;
        gvATD_DURACAO     := 0;
        gvATD_VALOR       := 0.00;
        gvATD_OBSERVACOES := '';

        clearFields();
    end;

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

procedure TfrmAtd_Cadastro.txtDataChange(Sender: TObject);
begin
  inherited;
    // exibe o dia da semana
    lblDia.Caption := doWeek(txtData.Date);
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
            vSearch(txtProcedimento.Text, vField) // faz a busca
        else
        if vField = 'Pagamento' then
            vSearch(txtPagamento.Text, vField); // faz a busca
    end;
end;

procedure TfrmAtd_Cadastro.vSearch(vpSearch, vpField: string);
begin
    // verifica se o campo está vazio
    if Trim(vpSearch) = '' then
        Exit;

    // faz a pesquisa dos dados informados no campo código
    if ((not pesSearchOne(vpSearch)) and
            (not prcSearchOne(vpSearch)) and
                (not fpgSearchOne(vpSearch))) then
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
                ToCreate(frmCli_Cadastro, TfrmCli_Cadastro, Self, nil, nil);
            end
            else
            // se for procedimento
            if vpField = 'Procedimento' then
            begin
                // abrir janela de cadastro de procedimento
            end
            else
            // se for forma de pgto
            if vpField = 'Pagamento' then
            begin
                // abrir janela de cadastro de procedimento
            end;
        end;
    end
    else
    begin
        try
            // se for cliente
            if vpField = 'Cliente' then
            begin
                // verifica sem encontrou mais de 1 registro
                if c.pessoas.vOutCount > 1 then
                begin
                    gvPES_ID := 0;

                    // verifica se o form foi criado
                    if not Assigned(frmLst_Registro) then
                        frmLst_Registro := TfrmLst_Registro.Create(nil); // cria o form

                    try
                        frmLst_Registro.Hint := vpSearch; // carrega os dados no form
                        frmLst_Registro.Caption := vpField;

                        frmLst_Registro.ShowModal; // exibe o form

                        if frmLst_Registro.Tag <> 0 then
                            txtCliente.Text := frmLst_Registro.cdsLst.FieldByName('NOME').AsString;
                    finally
                        frmLst_Registro := nil;
                        frmLst_Registro.Free; // descarrega o objeto
                    end;
                end;
            end
            else
            // se for procedimento
            if vpField = 'Procedimento' then
            begin
                // verifica sem encontrou mais de 1 registro
                if c.procedimentos.vOutCount > 1 then
                begin
                    gvPES_ID := 0;

                    // verifica se o form foi criado
                    if not Assigned(frmLst_Registro) then
                        frmLst_Registro := TfrmLst_Registro.Create(nil); // cria o form

                    try
                        frmLst_Registro.Hint := vpSearch; // carrega os dados no form
                        frmLst_Registro.Caption := vpField;

                        frmLst_Registro.ShowModal; // exibe o form

                        if frmLst_Registro.Tag <> 0 then
                            txtProcedimento.Text := frmLst_Registro.cdsLst.FieldByName('NOME').AsString;
                    finally
                        frmLst_Registro := nil;
                        frmLst_Registro.Free; // descarrega o objeto
                    end;
                end;
            end
            else
            // se for forma de pgto
            if vpField = 'Pagamento' then
            begin
                // verifica sem encontrou mais de 1 registro
                if c.forma_pgto.vOutCount > 1 then
                begin
                    gvPES_ID := 0;

                    // verifica se o form foi criado
                    if not Assigned(frmLst_Registro) then
                        frmLst_Registro := TfrmLst_Registro.Create(nil); // cria o form

                    try
                        frmLst_Registro.Hint := vpSearch; // carrega os dados no form
                        frmLst_Registro.Caption := vpField;

                        frmLst_Registro.ShowModal; // exibe o form

                        if frmLst_Registro.Tag <> 0 then
                            txtPagamento.Text := frmLst_Registro.cdsLst.FieldByName('NOME').AsString;
                    finally
                        frmLst_Registro := nil;
                        frmLst_Registro.Free; // descarrega o objeto
                    end;
                end;
            end;
        finally
            //
        end;

        // preenche os campos
        pnlCliente.Tag := gvPES_ID;
        if gvPES_ID <> 0 then
            txtCliente.Text := gvPES_NOME;

        pnlProcedimento.Tag := gvPRC_ID;
        if gvPRC_ID <> 0 then
            txtProcedimento.Text := gvPRC_NOME;

        pnlPagamento.Tag := gvFPG_ID;
        if gvFPG_ID <> 0 then
            txtPagamento.Text := gvFPG_NOME;

        txtDuracao.Text := IntToStr(gvPRC_DURACAO) + ' min.';
        txtValor.Text   := FormatMoney(gvPRC_VALOR);

        if ((vpField = 'Cliente') and (gvPES_ID <> 0)) then // se for cliente
            txtProcedimento.SetFocus
        else
        if ((vpField = 'Procedimento') and (gvPRC_ID <> 0)) then // se for procedimento
            txtDuracao.SetFocus
        else
        if ((vpField = 'Pagamento') and (gvFPG_ID <> 0)) then // se for procedimento
            txtObservacoes.SetFocus;
    end;
end;

procedure TfrmAtd_Cadastro.vTransfer;
begin
    //
    c.atendimentos.vcATD_FPG_ID      := gvFPG_ID;
    c.atendimentos.vcAPS_PES_ID      := gvPES_ID;
    c.atendimentos.vcAPC_PRC_ID      := gvPRC_ID;
    c.atendimentos.vcAPF_PRF_ID      := gvPRF_ID;

    c.atendimentos.vcATD_DATA        := txtData.Date;
    c.atendimentos.vcATD_HORA        := txtHora.Time;
    c.atendimentos.vcATD_DURACAO     := toMinute(txtDuracao.Text);
    c.atendimentos.vcATD_VALOR       := toCurrency(getNumber(txtValor.Text));
    c.atendimentos.vcATD_OBSERVACOES := txtObservacoes.Text;
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





