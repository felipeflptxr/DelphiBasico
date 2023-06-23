object DMSQLConsulta: TDMSQLConsulta
  OldCreateOrder = False
  Height = 398
  Width = 439
  object qryUsuario: TFDQuery
    Active = True
    Connection = DMConexaoBancoDados.conBancoDados
    SQL.Strings = (
      'SELECT *'
      'FROM usuario')
    Left = 56
    Top = 24
  end
  object cdsUsuario: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'USU_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'USU_NOME'
        Attributes = [faRequired]
        DataType = ftString
        Size = 100
      end
      item
        Name = 'USU_SENHA'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'USU_STATUS'
        DataType = ftInteger
      end
      item
        Name = 'USU_DATA_CADASTRO'
        DataType = ftDate
      end
      item
        Name = 'USU_HORA_CADASTRO'
        DataType = ftTime
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'dspUsuario'
    StoreDefs = True
    Left = 168
    Top = 24
  end
  object dspUsuario: TDataSetProvider
    DataSet = qryUsuario
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 112
    Top = 24
  end
end
