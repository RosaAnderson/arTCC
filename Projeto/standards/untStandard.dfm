object frmStandard: TfrmStandard
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'frmStandard'
  ClientHeight = 178
  ClientWidth = 379
  Color = clWhite
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    379
    178)
  TextHeight = 15
  object shpEdgeForm: TShape
    Left = 180
    Top = 7
    Width = 40
    Height = 20
    Hint = 'shpEdgeForm'
    Brush.Style = bsClear
    Pen.Color = cl3DDkShadow
  end
  object lblTitleForm: TLabel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 379
    Height = 30
    Hint = 'lblTitleForm'
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    AutoSize = False
    Caption = 'lblTitleForm'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -29
    Font.Name = 'Century Gothic'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    StyleElements = [seClient, seBorder]
    OnMouseMove = MoveForm
    ExplicitTop = 1
    ExplicitWidth = 296
  end
  object shpTitleForm: TShape
    AlignWithMargins = True
    Left = 8
    Top = 31
    Width = 363
    Height = 1
    Hint = 'shpTitleForm'
    Margins.Left = 8
    Margins.Top = 1
    Margins.Right = 8
    Margins.Bottom = 4
    Align = alTop
    Brush.Style = bsClear
    Pen.Color = clGrayText
    Visible = False
    ExplicitLeft = 5
    ExplicitTop = 86
    ExplicitWidth = 935
  end
  object btnCloseForm: TLabel
    Left = 330
    Top = 4
    Width = 45
    Height = 24
    Hint = 'Fechar'
    Alignment = taCenter
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'X'
    Color = clRed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = False
    Layout = tlCenter
    StyleElements = [seClient, seBorder]
    OnClick = btnCloseFormClick
    OnMouseEnter = CloseEnter
    OnMouseLeave = CloseLeave
  end
end
