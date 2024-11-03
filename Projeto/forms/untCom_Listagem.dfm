inherited frmCom_Listagem: TfrmCom_Listagem
  Caption = 'Lista de Compromissos'
  ClientHeight = 600
  ClientWidth = 350
  Visible = False
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 350
  ExplicitHeight = 600
  TextHeight = 23
  inherited lblTitleForm: TLabel
    Width = 350
    ExplicitWidth = 363
  end
  inherited btnCloseForm: TLabel
    Left = 304
    Visible = False
    ExplicitLeft = 317
  end
  object Panel1: TPanel [3]
    AlignWithMargins = True
    Left = 1
    Top = 31
    Width = 348
    Height = 458
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object ArCalendarEmptyNotice1: TArCalendarEmptyNotice
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 338
      Height = 62
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      BevelOuter = bvNone
      Caption = 'ArCalendarEmptyNotice1'
      Color = 15201770
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2773792
      Font.Height = -19
      Font.Name = 'Open Sans'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      ShowCaption = False
      TabOrder = 0
      OnClick = ArCalendarEmptyNotice1Click
      DesignSize = (
        338
        62)
    end
  end
  inherited pnlFooter: TPanel
    Top = 523
    Width = 340
    TabOrder = 1
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 523
    ExplicitWidth = 340
    inherited btnExit: TImage
      Left = 255
      ExplicitLeft = 255
    end
  end
end
