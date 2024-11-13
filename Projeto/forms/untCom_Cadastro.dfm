inherited frmCom_Cadastro: TfrmCom_Cadastro
  Caption = 'Cadastro de Compromisso'
  ClientHeight = 568
  ClientWidth = 417
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 417
  ExplicitHeight = 568
  TextHeight = 23
  inherited lblTitleForm: TLabel
    Width = 417
    ExplicitWidth = 438
  end
  inherited btnCloseForm: TLabel
    Left = 371
    Visible = False
    ExplicitLeft = 392
  end
  inherited pnlFooter: TPanel
    Top = 501
    Width = 407
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 501
    inherited pnlFootButton02: TPanel
      Left = 332
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 195
      ExplicitTop = 0
      ExplicitHeight = 62
      inherited label02: TLabel
        Width = 50
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited btnExit: TImage
        ExplicitLeft = 343
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
