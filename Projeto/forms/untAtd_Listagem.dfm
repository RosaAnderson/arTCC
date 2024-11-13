inherited frmAtd_Listagem: TfrmAtd_Listagem
  Caption = 'frmAtd_Listagem'
  ClientHeight = 600
  ClientWidth = 350
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
  inherited pnlFooter: TPanel
    Top = 533
    Width = 340
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 533
    ExplicitWidth = 340
    inherited pnlFootButton02: TPanel
      Left = 265
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 265
      ExplicitTop = 0
      ExplicitHeight = 62
      inherited label02: TLabel
        Width = 50
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited btnExit: TImage
        ExplicitLeft = 255
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
