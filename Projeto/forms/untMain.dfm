object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Easy Care'
  ClientHeight = 840
  ClientWidth = 1300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object pnlHoje: TPanel
    AlignWithMargins = True
    Left = 15
    Top = 10
    Width = 1270
    Height = 60
    Margins.Left = 15
    Margins.Top = 10
    Margins.Right = 15
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvNone
    Color = clBlack
    ParentBackground = False
    TabOrder = 0
    object pboxTopo: TPaintBox
      Left = 0
      Top = 0
      Width = 1270
      Height = 60
      Align = alClient
      Color = clBlack
      ParentColor = False
      OnPaint = TopoPaint
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 340
      ExplicitHeight = 120
    end
    object lblHoje: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 5
      Width = 1250
      Height = 50
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alClient
      AutoSize = False
      Caption = 'lblHoje'
      Color = 2773792
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Open Sans'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitLeft = 5
      ExplicitTop = 7
      ExplicitWidth = 578
      ExplicitHeight = 29
    end
  end
  object Panel1: TPanel
    Left = 192
    Top = 576
    Width = 521
    Height = 73
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = 7521404
    ParentBackground = False
    TabOrder = 1
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 73
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'Panel2'
      Color = 3770147
      ParentBackground = False
      TabOrder = 0
      ExplicitLeft = 56
      ExplicitTop = 48
      ExplicitHeight = 41
    end
  end
end