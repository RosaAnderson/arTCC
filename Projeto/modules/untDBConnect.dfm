object frmDBConnect: TfrmDBConnect
  Height = 235
  Width = 118
  object FDDriverLink: TFDPhysMySQLDriverLink
    Left = 24
    Top = 72
  end
  object FDConnect: TFDConnection
    Params.Strings = (
      'Database=gFacil'
      'User_Name=user'
      'Password=795400'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object FDWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 24
    Top = 128
  end
end
