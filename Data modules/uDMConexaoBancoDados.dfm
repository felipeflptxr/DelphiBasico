object DMConexaoBancoDados: TDMConexaoBancoDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 295
  Width = 459
  object conBancoDados: TFDConnection
    Params.Strings = (
      'Password=scx324112'
      'User_Name=SYSDBA'
      
        'Database=F:\Cursos\Projeto Delphi\Projeto financeiro\Banco de da' +
        'dos\DADOS.FDB'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 16
  end
end
