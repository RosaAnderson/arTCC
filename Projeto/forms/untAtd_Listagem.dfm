inherited frmAtd_Listagem: TfrmAtd_Listagem
  Caption = 'frmAtd_Listagem'
  ClientHeight = 600
  ClientWidth = 350
  Visible = False
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 350
  ExplicitHeight = 600
  TextHeight = 23
  inherited lblTitleForm: TLabel
    Width = 350
    ExplicitWidth = 350
  end
  inherited btnCloseForm: TLabel
    Left = 304
    Visible = False
    ExplicitLeft = 304
  end
  object pnlAtendimentos: TPanel [3]
    AlignWithMargins = True
    Left = 5
    Top = 35
    Width = 340
    Height = 326
    Hint = 'pnlForm'
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label13: TLabel
      Left = 0
      Top = 296
      Width = 340
      Height = 30
      Hint = 'lblLabel'
      Align = alBottom
      Alignment = taCenter
      Caption = 'Atendimentos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Visible = False
      ExplicitWidth = 130
    end
    object ArCalendarAppointmentNotice1: TArCalendarAppointmentNotice
      AlignWithMargins = True
      Left = 5
      Top = 50
      Width = 330
      Height = 40
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'ArCalendarAppointmentNotice1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2773792
      Font.Height = -19
      Font.Name = 'Open Sans'
      Font.Style = []
      ParentFont = False
      ShowCaption = False
      TabOrder = 0
      OnClick = ArCalendarAppointmentNotice1Click
      DesignSize = (
        330
        40)
    end
    object ArCalendarAppointmentNotice2: TArCalendarAppointmentNotice
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 330
      Height = 40
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      Caption = 'ArCalendarAppointmentNotice1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2773792
      Font.Height = -19
      Font.Name = 'Open Sans'
      Font.Style = []
      ParentFont = False
      ShowCaption = False
      TabOrder = 1
      OnClick = ArCalendarAppointmentNotice1Click
      DesignSize = (
        330
        40)
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
