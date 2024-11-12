object frmDBConnect: TfrmDBConnect
  Height = 197
  Width = 112
  object FDDriverLink: TFDPhysMySQLDriverLink
    Left = 40
    Top = 72
  end
  object FDConnect: TFDConnection
    Params.Strings = (
      'Database=arEasyCare'
      'User_Name=adm'
      'Password=#@Ar*79*55*54@#'
      'Server=100.10.1.254'
      'Port=5455'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object FDWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 40
    Top = 128
  end
end
