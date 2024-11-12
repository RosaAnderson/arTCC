unit untObjects;

interface

uses
  System.SysUtils, System.Classes,

  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Forms, Vcl.Graphics, Vcl.Controls,

  ArSinglePanel;


type
    tObjects = class

    private
        {Private declarations}
    public
        {Public declarations}
    end;

    procedure loadSchedule(vfForm: TForm; vfParentPanel: TPanel; vfData: TDate);

var
    FScheduleScroll: TScrollBox;

implementation

uses c.atendimentos, untFunctions, untMain;

procedure loadSchedule(vfForm: TForm; vfParentPanel: TPanel; vfData: TDate);
var
    vHIExp, vHFExp, vH: TTime;
    vHoraE, vI: Integer;
    vHora, vObjName, vBoxName: string;

    FScheduleBox,
    FBorPanel, FBasPanel, FHorPanel,
    FCliPanel, FBtnPanel              : TPanel;
    FAddImage, FDelImage, FEdtImage,
    FCloImage, FSenImage              : TImage;
    FHorLabel, FCliLabel              : TLabel;
    FSeparator                        : TShape;
    vFComponent                       : TComponent;
begin
    //
    FScheduleBox := vfParentPanel;
    vBoxName     := FScheduleBox.Hint + 'Box';
    vFComponent  := nil;
    vFComponent  := vfForm.FindComponent(vBoxName);

    // define a hora inicial e final
    vHIExp := StrToTime('08:00');
    vHFExp := StrToTime('18:00');

    // calcula o expediente
    vHoraE := StrToInt(FormatDateTime('hh', (vHFExp - vHIExp)));// * 2;

    // verifica se existe o objeto
    if Assigned(vFComponent) then
        vfForm.FindComponent(vBoxName).Destroy;

//##############################################################################
//##############################################################################
//# cria o scrollbox ###########################################################
//##############################################################################
    FScheduleScroll        := TScrollBox.Create(vfForm);
    FScheduleScroll.Parent := FScheduleBox;
    FScheduleScroll.Name   := vBoxName;

    // definições
    FScheduleScroll.AutoScroll           := True;
    FScheduleScroll.BorderStyle          := bsNone;
    FScheduleScroll.Color                := clWhite;
    FScheduleScroll.UseWheelForScrolling := True;

    // posicionamento
    FScheduleScroll.Top              := -1000;
    FScheduleScroll.Left             := -1000;
    FScheduleScroll.Height           := 1;
    FScheduleScroll.Width            := 600;
    FScheduleScroll.Align            := alBottom;
    FScheduleScroll.AlignWithMargins := True;
    FScheduleScroll.Margins.Bottom   := 0;
    FScheduleScroll.Margins.Left     := 0;
    FScheduleScroll.Margins.Right    := 0;
    FScheduleScroll.Margins.Top      := 0;
//##############################################################################
//##############################################################################

    // insere os horarios na agenda
    for vI := 0 to vHoraE do
    begin
        // incrementa a hora
        vH := StrToTime(IntToStr(StrToInt(FormatDateTime('hh', vHIExp)) + vI));

        // formata a hora
        vHora := FormatDateTime('hh:MM', vH);

        // remove o separador de hora
        vObjName := Copy(FScheduleScroll.Name, 1, 1) + getNumber(vHora);

        // procura o registro no bando de dados
        if vBoxName = 'AtendimentosBox' then
            atdSearchClk(FormatDateTime('yyyy-mm-dd)', vfData), vHora, 0)
        else
        if vBoxName = 'CompromissoBox' then
            atdSearchClk(FormatDateTime('yyyy-mm-dd)', vfData), vHora, 0);

//##############################################################################
//##############################################################################
//# cria o panel base (borda) ##################################################
//##############################################################################
        FBorPanel        := TArSinglePanel.Create(vfForm);
        FBorPanel.Parent := FScheduleScroll;
        FBorPanel.Name   := 'pnl' + vObjName;

        // posicionamento
        FBorPanel.Top              := 0;
        FBorPanel.Left             := 0;
        FBorPanel.Height           := 60;
        FBorPanel.Align            := alBottom;
        FBorPanel.Align            := alTop;
        FBorPanel.AlignWithMargins := True;
        FBorPanel.Margins.Bottom   := 5;
        FBorPanel.Margins.Left     := 5;
        FBorPanel.Margins.Right    := 5;
        FBorPanel.Margins.Top      := 5;
//##############################################################################
//##############################################################################
//# cria o panel base (interno) ################################################
//##############################################################################
        FBasPanel             := TPanel.Create(vfForm);
        FBasPanel.Parent      := FBorPanel;
        FBasPanel.Name        := 'pnlO_' + vObjName;
        FBasPanel.ShowCaption := False;
        FBasPanel.BevelOuter  := bvNone;

        // posicionamento
        FBasPanel.Top              := 0;
        FBasPanel.Left             := 0;
        FBasPanel.Align            := alClient;
        FBasPanel.AlignWithMargins := True;
        FBasPanel.Margins.Bottom   := 3;
        FBasPanel.Margins.Left     := 3;
        FBasPanel.Margins.Right    := 3;
        FBasPanel.Margins.Top      := 3;
//##############################################################################
//##############################################################################
//# cria o painel da label hora ################################################
//##############################################################################
        FHorPanel             := TPanel.Create(vfForm);
        FHorPanel.Parent      := FBasPanel;
        FHorPanel.Name        := 'pnlH_' + vObjName;
        FHorPanel.ShowCaption := False;
        FHorPanel.BevelOuter  := bvNone;

        // posicionamento
        FHorPanel.Top   := 0;
        FHorPanel.Left  := 0;
        FHorPanel.Width := 65;
        FHorPanel.Align := alLeft;
//##############################################################################
//##############################################################################
//# cria a label hora ##########################################################
//##############################################################################
        FHorLabel        := TLabel.Create(vfForm);
        FHorLabel.Parent := FHorPanel;
        FHorLabel.Name   := 'lblH_' + vObjName;

        // texto
        FHorLabel.Caption     := vHora;
        FHorLabel.Font.Style  := [fsBold];
        FHorPanel.Font.Size   := 14;
        FHorLabel.Layout      := tlCenter;
        FHorLabel.Alignment   := taCenter;

        // posicionamento
        FHorLabel.Top   := 0;
        FHorLabel.Left  := 0;
        FHorLabel.Align := alClient;
//##############################################################################
//##############################################################################
//# cria a shape separador #####################################################
//##############################################################################
        FSeparator        := TShape.Create(vfForm);
        FSeparator.Parent := FBasPanel;

        // posicionamento
        FSeparator.Top              := 0;
        FSeparator.Left             := 0;
        FSeparator.Width            := 1;
        FSeparator.Align            := alRight;
        FSeparator.Align            := alLeft;
        FSeparator.AlignWithMargins := True;
        FSeparator.Margins.Bottom   := 5;
        FSeparator.Margins.Left     := 5;
        FSeparator.Margins.Right    := 5;
        FSeparator.Margins.Top      := 5;

        // ajustes (borda e perenchimento)
        FSeparator.Pen.color := $00448F0B;
//##############################################################################
//##############################################################################
//# cria o painel da label cliente #############################################
//##############################################################################
        FCliPanel             := TPanel.Create(vfForm);
        FCliPanel.Parent      := FBasPanel;
        FCliPanel.Name        := 'pnlC_' + vObjName;
        FCliPanel.ShowCaption := False;
        FCliPanel.BevelOuter  := bvNone;

        // posicionamento
        FCliPanel.Top   := 0;
        FCliPanel.Left  := 0;
        FCliPanel.Width := 65;
        FCliPanel.Align := alRight;
        FCliPanel.Align := alClient;
//##############################################################################
//##############################################################################
//# cria a image de botão enviar mensagem ######################################
//##############################################################################
        if vcCLK_PES_NOME <> '' then
        begin
            FSenImage          := TImage.Create(vfForm);
            FSenImage.Parent   := FCliPanel;
            FSenImage.Name     := 'btnN_' + vObjName;
            FSenImage.Cursor   := crHandPoint;
            FSenImage.Hint     := 'Notificação Enviada';
            FSenImage.ShowHint := True;

            // posicionamento
            FSenImage.Top              := 0;
            FSenImage.Left             := 0;
            FSenImage.Width            := 15;
            FSenImage.Align            := alRight;
            FSenImage.Align            := alLeft;
            FSenImage.AlignWithMargins := True;
            FSenImage.Margins.Bottom   := 0;
            FSenImage.Margins.Left     := 2;
            FSenImage.Margins.Right    := 10;
            FSenImage.Margins.Top      := 0;

            //
            FSenImage.Picture      := frmMain.imgEnv.Picture;
            FSenImage.Center       := True;
            FSenImage.Proportional := True;
            FSenImage.Stretch      := True;
        end;
//##############################################################################
//##############################################################################
//# cria a label cliente #######################################################
//##############################################################################
        FCliLabel        := TLabel.Create(vfForm);
        FCliLabel.Parent := FCliPanel;
        FCliLabel.Name   := 'lblC_' + vObjName;

        // texto
        FCliLabel.Caption    := vcCLK_PES_NOME;
        FCliLabel.Font.Size  := 11;
        FCliLabel.Layout     := tlCenter;
        FCliLabel.Alignment  := taCenter;
        FCliLabel.Alignment  := taLeftJustify;
        FCliLabel.WordWrap   := True;

        // posicionamento
        FCliLabel.Top   := 0;
        FCliLabel.Left  := 0;
        FCliLabel.Align := alClient;
//##############################################################################
//##############################################################################
//# cria o painel dos botões de acão ###########################################
//##############################################################################
        FBtnPanel             := TPanel.Create(vfForm);
        FBtnPanel.Parent      := FCliPanel;
        FBtnPanel.Name        := 'pnlB_' + vObjName;
        FBtnPanel.ShowCaption := False;
        FBtnPanel.BevelOuter  := bvNone;
        FBtnPanel.Tag         := vcCLK_ATD_ID;
        FBtnPanel.Hint        := vHora;

        // posicionamento
        FBtnPanel.Top    := 0;
        FBtnPanel.Left   := 0;
        FBtnPanel.Height := 15;
        FBtnPanel.Align  := alBottom;
//##############################################################################
//##############################################################################
//# cria a image de botão excluir ##############################################
//##############################################################################
        FDelImage          := TImage.Create(vfForm);
        FDelImage.Parent   := FBtnPanel;
        FDelImage.Name     := 'btnD_' + vObjName;
        FDelImage.Cursor   := crHandPoint;
        FDelImage.Hint     := 'Cancelar';
        FDelImage.ShowHint := True;

        // posicionamento
        FDelImage.Top              := 0;
        FDelImage.Left             := 0;
        FDelImage.Width            := 15;
        FDelImage.Align            := alLeft;
        FDelImage.Align            := alRight;
        FDelImage.AlignWithMargins := True;
        FDelImage.Margins.Bottom   := 0;
        FDelImage.Margins.Left     := 0;
        FDelImage.Margins.Right    := 15;
        FDelImage.Margins.Top      := 0;

        //
        if vcCLK_PES_NOME <> '' then
            FDelImage.Picture  := frmMain.imgDel.Picture;
        FDelImage.Center       := True;
        FDelImage.Proportional := True;
        FDelImage.Stretch      := True;

        FDelImage.OnClick      := frmMain.btnCanClick;
//##############################################################################
//##############################################################################
//# cria a image de botão editar ###############################################
//##############################################################################
        FEdtImage          := TImage.Create(vfForm);
        FEdtImage.Parent   := FBtnPanel;
        FEdtImage.Name     := 'btnE_' + vObjName;
        FEdtImage.Cursor   := crHandPoint;
        FEdtImage.Hint     := 'Editar';
        FEdtImage.ShowHint := True;

        // posicionamento
        FEdtImage.Top              := 0;
        FEdtImage.Left             := 0;
        FEdtImage.Width            := 15;
        FEdtImage.Align            := alLeft;
        FEdtImage.Align            := alRight;
        FEdtImage.AlignWithMargins := True;
        FEdtImage.Margins.Bottom   := 0;
        FEdtImage.Margins.Left     := 0;
        FEdtImage.Margins.Right    := 15;
        FEdtImage.Margins.Top      := 0;

        //
        if vcCLK_PES_NOME <> '' then
            FEdtImage.Picture  := frmMain.imgEdt.Picture;
        FEdtImage.Center       := True;
        FEdtImage.Proportional := True;
        FEdtImage.Stretch      := True;

        FEdtImage.OnClick      := frmMain.btnEdtClick;
//##############################################################################
//##############################################################################
//# cria a image de botão adicionar ############################################
//##############################################################################
        FAddImage          := TImage.Create(vfForm);
        FAddImage.Parent   := FBtnPanel;
        FAddImage.Name     := 'btnA_' + vObjName;
        FAddImage.Cursor   := crHandPoint;
        FAddImage.Hint     := 'Novo';
        FAddImage.ShowHint := True;

        // posicionamento
        FAddImage.Top              := 0;
        FAddImage.Left             := 0;
        FAddImage.Width            := 15;
        FAddImage.Align            := alLeft;
        FAddImage.Align            := alRight;
        FAddImage.AlignWithMargins := True;
        FAddImage.Margins.Bottom   := 0;
        FAddImage.Margins.Left     := 0;
        FAddImage.Margins.Right    := 15;
        FAddImage.Margins.Top      := 0;

        //
        if vcCLK_PES_NOME = '' then
            FAddImage.Picture  := frmMain.imgAdd.Picture;
        FAddImage.Center       := True;
        FAddImage.Proportional := True;
        FAddImage.Stretch      := True;

        FAddImage.OnClick      := frmMain.btnAddClick;
//##############################################################################
//##############################################################################
//# cria a image de botão finalizar ############################################
//##############################################################################
        FCloImage          := TImage.Create(vfForm);
        FCloImage.Parent   := FBtnPanel;
        FCloImage.Name     := 'btnC_' + vObjName;
        FCloImage.Cursor   := crHandPoint;
        FCloImage.Hint     := 'Finalizar';
        FCloImage.ShowHint := True;

        // posicionamento
        FCloImage.Top              := 0;
        FCloImage.Left             := 0;
        FCloImage.Width            := 15;
        FCloImage.Align            := alLeft;
        FCloImage.Align            := alRight;
        FCloImage.AlignWithMargins := True;
        FCloImage.Margins.Bottom   := 0;
        FCloImage.Margins.Left     := 0;
        FCloImage.Margins.Right    := 15;
        FCloImage.Margins.Top      := 0;

        //
        if vcCLK_PES_NOME <> '' then
            FCloImage.Picture  := frmMain.imgClo.Picture;
        FCloImage.Center       := True;
        FCloImage.Proportional := True;
        FCloImage.Stretch      := True;

        FCloImage.OnClick      := frmMain.btnCloClick;
//##############################################################################
//##############################################################################
//# cria a image de botão enviar mensagem ######################################
//##############################################################################
        if vBoxName = 'AtendimentosBox' then
        begin
            FSenImage          := TImage.Create(vfForm);
            FSenImage.Parent   := FBtnPanel;
            FSenImage.Name     := 'btnS_' + vObjName;
            FSenImage.Cursor   := crHandPoint;
            FSenImage.Hint     := 'Enviar Mensagem';
            FSenImage.ShowHint := True;

            // posicionamento
            FSenImage.Top              := 0;
            FSenImage.Left             := 0;
            FSenImage.Width            := 15;
            FSenImage.Align            := alLeft;
            FSenImage.Align            := alRight;
            FSenImage.AlignWithMargins := True;
            FSenImage.Margins.Bottom   := 0;
            FSenImage.Margins.Left     := 0;
            FSenImage.Margins.Right    := 15;
            FSenImage.Margins.Top      := 0;

            //
            if vcCLK_PES_NOME <> '' then
                FSenImage.Picture  := frmMain.imgSen.Picture;
            FSenImage.Center       := True;
            FSenImage.Proportional := True;
            FSenImage.Stretch      := True;

            FSenImage.OnClick      := frmMain.btnSenClick;
        end;
//##############################################################################
//##############################################################################
    end;

    // ajusta o painel
    FScheduleScroll.Align := alClient;
end;

end.
