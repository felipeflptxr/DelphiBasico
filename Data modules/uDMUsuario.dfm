object DMUsuario: TDMUsuario
  OldCreateOrder = False
  Height = 411
  Width = 691
  object qryUsuario: TFDQuery
    Connection = DMConexaoBancoDados.conBancoDados
    SQL.Strings = (
      'select * from usuario')
    Left = 280
    Top = 64
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
    Left = 400
    Top = 64
    object cdsUsuarioUSU_ID: TIntegerField
      FieldName = 'USU_ID'
    end
    object cdsUsuarioUSU_NOME: TStringField
      FieldName = 'USU_NOME'
      Size = 100
    end
    object cdsUsuarioUSU_SENHA: TStringField
      FieldName = 'USU_SENHA'
      Size = 50
    end
    object cdsUsuarioUSU_DATA_CADASTRO: TDateField
      FieldName = 'USU_DATA_CADASTRO'
    end
    object cdsUsuarioUSU_HORA_CADASTRO: TTimeField
      FieldName = 'USU_HORA_CADASTRO'
    end
    object cdsUsuarioUSU_STATUS: TIntegerField
      FieldName = 'USU_STATUS'
    end
  end
  object dspUsuario: TDataSetProvider
    DataSet = qryUsuario
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 344
    Top = 64
  end
end
