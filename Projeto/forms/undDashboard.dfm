inherited frmDashboard: TfrmDashboard
  Caption = 'AR EasyCare - Dashboard'
  ClientHeight = 141
  ClientWidth = 540
  Color = clWindow
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 540
  ExplicitHeight = 141
  TextHeight = 23
  object shpBG: TShape [0]
    Left = 342
    Top = 7
    Width = 75
    Height = 20
    Hint = 'shpEdgeForm'
    Brush.Style = bsClear
    Pen.Color = 4423189
  end
  inherited lblTitleForm: TLabel
    Width = 540
    ExplicitWidth = 1384
  end
  inherited btnCloseForm: TLabel
    Left = 487
    Top = 7
    Visible = False
    ExplicitLeft = 1117
    ExplicitTop = 7
  end
  inherited pnlFooter: TPanel
    Top = 74
    Width = 530
    Visible = False
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 602
    ExplicitWidth = 1160
    inherited pnlFootButton02: TPanel
      Left = 455
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 1085
      ExplicitTop = 0
      ExplicitHeight = 62
      inherited label02: TLabel
        Width = 50
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited btnExit: TImage
        ExplicitLeft = 1075
      end
    end
    inherited pnlFootButton01: TPanel
      StyleElements = [seFont, seClient, seBorder]
      ExplicitHeight = 62
      inherited Label01: TLabel
        Width = 50
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
end
