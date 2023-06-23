object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 277
  Width = 422
  object dspcServer: TDSProviderConnection
    ServerClassName = 'TDMSM'
    SQLConnection = conServer
    Left = 104
    Top = 24
  end
  object conServer: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
    Left = 32
    Top = 24
    UniqueId = '{DDBF562F-FC8E-4AD3-827C-3BDB3DD47A38}'
  end
end
