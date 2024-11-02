unit untObjetos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    Shape2: TShape;
    Panel3: TPanel;
    Image1: TImage;
    Label5: TLabel;
    Panel10: TPanel;
    Image4: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure tmrSendTimer(Sender: TObject);

    procedure radTextClick(Sender: TObject);

    procedure pcgTabClick(Sender: TObject);

    procedure pnlConfigEnter(Sender: TObject);

    procedure btnCloseClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnVerPassClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);

    procedure dspRegistrosAfterApplyUpdates(Sender: TObject; var OwnerData: OleVariant);
    procedure dtsRegistrosDataChange(Sender: TObject; Field: TField);

  private
    { Private declarations }
    vScreenWidth, vScreenHeight: integer;
  public
    { Public declarations }
  end;

var
  frmMain_v1: TfrmMain_v1;

implementation

{$R *.dfm}

uses untSource, untFunctions, untDM;

var
    vType : string  = 'text';
    vCount: Integer = 0;
    vSend : Integer = 0;

procedure TfrmMain.btnResetClick(Sender: TObject);
begin
    // atualiza as variaveis
    txtAttachPath.Text := gvAttachPath;
    txtURL.Text        := gvURL;
    txtAPIKey.Text     := gvAPIKey;
    txtPhoneFrom.Text  := gvPhoneFrom;
    txtInterval.Text   := IntToStr(gvInterval);
    txtEmail.Text      := gvEMail;
    txtSMTP.Text       := gvSMTP;
    txtPorta.Text      := IntToStr(gvPorta);
    txtSenha.Text      := gvSenha;
    txtNome.Text       := gvNome;
    txtHost.Text       := gvServer;
    txtBase.Text       := gvBase;
    txtPort.Text       := gvPort;
    txtDriver.Text     := gvDriver;
    txtUser.Text       := gvUser;
    txtPass.Text       := gvPass;
end;

procedure TfrmMain.btnSaveClick(Sender: TObject);
var
    zero: integer;
    vDBDriver: string;
begin
    //
    if pgcConfig.ActivePageIndex = 2 then
    begin
        //
        frmDBConnect.SaveINI;

        // define o driver
        vDBDriver := LowerCase(gvDriver);

        if frmDBConnect.ReadINI then
        begin
            // verifica qual driver usar
            if vDBDriver = 'mysql' then
                frmDBConnect.FDDriverLink.VendorLib := exePathRequest + 'dll\libmysql_32.dll' // define o caminho da dll do MySQL
            else
            if vDBDriver = 'outro banco' then
                vDBDriver := 'mysql'; //troca no futuro
        end;
    end
    else
    begin
        if pgcConfig.ActivePageIndex = 0 then
        begin
            // atualiza as variaveis
            gvAttachPath := txtAttachPath.Text;
            gvURL        := txtURL.Text;
            gvAPIKey     := txtAPIKey.Text;
            gvPhoneFrom  := txtPhoneFrom.Text;
            gvInterval   := StrToIntDef(txtInterval.Text, 1);
        end
        else
        if pgcConfig.ActivePageIndex = 1 then
        begin
            // atualiza as variaveis
            gvEMail := txtEmail.Text;
            gvSMTP  := txtSMTP.Text;
            gvPorta := StrToInt(txtPorta.Text);
            gvSenha := txtSenha.Text;
            gvNome  := txtNome.Text;
        end;

        // grava no banco de dados
        postConfigs;
    end;

    // faz a conexão com o banco de dados
    if frmDBConnect.DBConnect then
        getConfigs; // carrega as configurações do banco de dados

    // define as configurações do timer
    tmrSend.Interval := gvInterval * (1000 * 60); // intervalo
    tmrSend.Enabled  := False; // desativa o timer
    tmrSend.Enabled  := True;  // ativa o timer
end;

procedure TfrmMain.pcgTabClick(Sender: TObject);
begin
    // exibe a page especificada
    pgcConfig.ActivePageIndex := (Sender as TSpeedButton).Tag;

    if pgcConfig.ActivePageIndex = 0 then
    begin
        //
        shpWhatsApp.Brush.Style := bsSolid;
        shpEmail.Brush.Style    := bsClear;
        shpINI.Brush.Style      := bsClear;

        //
        btnWhatsApp.Font.Color  := $00AE7803;
        btnEmail.Font.Color     := clCream;
        btnINI.Font.Color       := clCream;
    end
    else
    if pgcConfig.ActivePageIndex = 1 then
    begin
        //
        shpEmail.Brush.Style    := bsSolid;
        shpINI.Brush.Style      := bsClear;
        shpWhatsApp.Brush.Style := bsClear;

        //
        btnEmail.Font.Color     := $00AE7803;
        btnINI.Font.Color       := clCream;
        btnWhatsApp.Font.Color  := clCream;
    end
    else
    if pgcConfig.ActivePageIndex = 2 then
    begin
        //
        shpINI.Brush.Style      := bsSolid;
        shpWhatsApp.Brush.Style := bsClear;
        shpEmail.Brush.Style    := bsClear;

        //
        btnINI.Font.Color       := $00AE7803;
        btnWhatsApp.Font.Color  := clCream;
        btnEmail.Font.Color     := clCream;
    end
end;

procedure TfrmMain.pnlConfigEnter(Sender: TObject);
var
    i: Integer;
begin
    //
    for i := 0 to 2 do
    begin
        pgcConfig.Pages[i].TabVisible := False; // oculta as tabs
    end;

    // verifica se está preenchido
    if gvServer.IsEmpty then
    begin
        pgcConfig.ActivePageIndex := 2; // seleciona a gui a de configuração do arquivo ini
        pnlBtnVoltar.Visible      := False; // oculta o botão
        btnWhatsApp.Font.Color    := clCream;
        btnEmail.Font.Color       := clCream;
        shpINI.Brush.Style        := bsSolid;
    end
    else
    begin
        pgcConfig.ActivePageIndex := 0; // seleciona a guia inicial
        pnlBtnVoltar.Visible      := True; // mostra o botão
        shpWhatsApp.Brush.Style   := bsSolid;
        btnEmail.Font.Color       := clCream;
        btnINI.Font.Color         := clCream;
    end;
end;

procedure TfrmMain.radTextClick(Sender: TObject);
begin
    // verifica qual rad está selecionado
    if radText.Checked then
        vType := 'text' // define como texto simples
    else
        vType := 'document'; // define como documento (imagem, pdf...)
end;

procedure TfrmMain.btnConfigClick(Sender: TObject);
var
    i: Integer;
begin
    // verifica se já recebeu os dados do banco
    if gvResponse = 0 then
        getConfigs; // pega os dados do banco

    // passa os valores das variaveis para os campos
    txtURL.Text        := gvURL;
    txtAPIKey.Text     := gvAPIKey;
    txtPhoneFrom.Text  := gvPhoneFrom;
    txtInterval.Text   := IntToStr(gvInterval);
    txtAttachPath.Text := gvAttachPath;

    txtEmail.Text      := gvEMail;
    txtSMTP.Text       := gvSMTP;
    txtPorta.Text      := IntToStr(gvPorta);
    txtSenha.Text      := gvSenha;
    txtNome.Text       := gvNome;

    txtHost.Text       := gvServer;
    txtBase.Text       := gvBase;
    txtPort.Text       := gvPort;
    txtDriver.Text     := gvDriver;
    txtUser.Text       := gvUser;
    txtPass.Text       := gvPass;

    // exibe o painel com as configurações
    pnlConfig.Visible := True;

    // oculta o painel principal
    pnlMain.Visible := False;

    //
    for i := 0 to 2 do
    begin
        pgcConfig.Pages[i].TabVisible := False; // oculta as tabs
    end;

    shpWhatsApp.Brush.Style   := bsSolid;
    btnEmail.Font.Color       := clCream;
    btnINI.Font.Color         := clCream;
    pgcConfig.ActivePageIndex := 0; // seleciona a guia inicial

    // oculta o botão
    btnConfig.Visible := False;
end;

procedure TfrmMain.tmrSendTimer(Sender: TObject);
var
    i, noAtt: Integer;

    vBody, vDescription, vName, vPDF,

    vREG_ID,
    vREG_ORIGEM_NOME,
    vREG_DESTINO_NOME,
    vREG_DESTINO_NUMERO,
    vREG_DESTINO_EMAIL,
    vREG_MENSAGEM,
    vREG_ANEXO: string;
begin
    try
        // verifica a conexão com o banco
        if not frmDBConnect.DBConnect then
        begin
            Exit;
        end;

        // verifica se já recebeu os dados do banco
        if gvResponse = 0 then
            getConfigs; // pega os dados do banco

//#### Atualizar essas variaveis com os dados corretos #########################
//##############################################################################
        vDescription := 'Detalhe do Meu Arquivo';
        vName        := 'MeuArquivo.pdf';
//##############################################################################
//##############################################################################

        // define o parametro da pesquisa
        qryRegistros.ParamByName('REG_ENVIADO').AsInteger := 0;

        cdsRegistros.Close; // fecha o cds
        cdsRegistros.Open;  // abre o cds

        // passa por todos os registros
        while not cdsRegistros.Eof do
        begin
            //dados do cds
            vREG_ID             := cdsRegistros.FieldByName('REG_ID').AsString;
            vREG_ORIGEM_NOME    := cdsRegistros.FieldByName('REG_ORIGEM_NOME').AsString;
            vREG_DESTINO_NOME   := cdsRegistros.FieldByName('REG_DESTINO_NOME').AsString;
            vREG_DESTINO_NUMERO := cdsRegistros.FieldByName('REG_DESTINO_NUMERO').AsString;
            vREG_DESTINO_EMAIL  := cdsRegistros.FieldByName('REG_DESTINO_EMAIL').AsString;
            vREG_MENSAGEM       := cdsRegistros.FieldByName('REG_MENSAGEM').AsString;
            vREG_ANEXO          := cdsRegistros.FieldByName('REG_ANEXO').AsString;

            // define o nome do PDF
            vPDF := 'sysPDF_ID' + vREG_ID;

            // verifica se tem anexo
            if vREG_ANEXO.IsEmpty then
            begin
                vType := 'text'; // define como texto simples
                vBody := vREG_MENSAGEM; // mensagem assossiada
            end
            else
            begin
                vType := 'document'; // define como documento (imagem, pdf...)
                vBody := vREG_ANEXO; // arquivo em Base64
                Base64ToFile(vREG_ANEXO, vPDF); // faz o donload do anexo
            end;

            // envia a mensagem
            if getSendResult(
                    SendToWhatsapp(vREG_DESTINO_NUMERO, // telefone destino
                                   'reg_n_' + vREG_ID, // id para mensagem
                                   vType, // tipo d amensagem
                                   vDescription, // descrição do arquivo
                                   vName, // nome do arquivo
                                   vBody // corpo da mensagem
                                  )
                            ) then

            begin
                // atualiza o registro marcando como enviado
                UpdateShipping(StrToInt(vREG_ID), message_id);

                // verifica se o e-mail foi informado
                if not vREG_DESTINO_EMAIL.IsEmpty then
                    SendToMail(vREG_DESTINO_EMAIL, vDescription, vREG_MENSAGEM, vPDF);// envia a mensagem por e-mail

                // move o arquivo para enviados
                MoveFile(pchar(gvAttachPath + vPDF + '.pdf'),
                         pchar(gvAttachPath + 'send\' + vPDF + '.pdf'));
            end;

            // move para o proximo registro
            cdsRegistros.Next;
        end;

    finally
        // desconecta do banco
        frmDBConnect.DBDisconnect;
    end;
end;

end.


