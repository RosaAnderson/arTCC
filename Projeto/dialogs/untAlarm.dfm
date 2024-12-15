inherited frmAlarm: TfrmAlarm
  Caption = 'frmAlarm'
  ClientHeight = 604
  ClientWidth = 808
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 808
  ExplicitHeight = 604
  TextHeight = 23
  inherited lblTitleForm: TLabel
    Width = 808
    Visible = False
  end
  inherited btnCloseForm: TLabel
    Left = 762
    Visible = False
  end
  object Image1: TImage [3]
    Left = 0
    Top = 264
    Width = 808
    Height = 268
    Align = alBottom
  end
  inherited pnlFooter: TPanel
    Top = 537
    Width = 798
    StyleElements = [seFont, seClient, seBorder]
    inherited pnlFootButton02: TPanel
      Left = 723
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 195
      ExplicitTop = 0
      ExplicitHeight = 62
      inherited label02: TLabel
        Width = 50
        StyleElements = [seFont, seClient, seBorder]
      end
    end
    inherited pnlFootButton01: TPanel
      Visible = False
      StyleElements = [seFont, seClient, seBorder]
      ExplicitHeight = 62
      inherited Label01: TLabel
        Width = 50
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
end
