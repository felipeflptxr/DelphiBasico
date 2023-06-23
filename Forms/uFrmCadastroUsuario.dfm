inherited FrmCadastroUsuario: TFrmCadastroUsuario
  Caption = 'Cadastro de usu'#225'rios'
  ClientHeight = 361
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 13
  inherited crdpBase: TCardPanel
    Height = 316
    ExplicitHeight = 316
    inherited crdCadastro: TCard
      Height = 316
      ExplicitHeight = 316
      object lbl1: TLabel [0]
        Left = 63
        Top = 3
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object lbl2: TLabel [1]
        Left = 376
        Top = 3
        Width = 30
        Height = 13
        Caption = 'Senha'
      end
      object lbl3: TLabel [2]
        Left = 8
        Top = 3
        Width = 11
        Height = 13
        Caption = 'ID'
      end
      object lbl4: TLabel [3]
        Left = 513
        Top = 3
        Width = 83
        Height = 13
        Caption = 'Data de cadastro'
      end
      object lbl5: TLabel [4]
        Left = 621
        Top = 3
        Width = 31
        Height = 13
        Caption = 'Status'
      end
      inherited pnlFundoCadastro: TPanel
        Height = 316
        TabOrder = 5
        ExplicitHeight = 316
      end
      object edtUSU_NOME: TEdit
        Left = 63
        Top = 18
        Width = 297
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
      end
      object edtUSU_SENHA: TEdit
        Left = 376
        Top = 18
        Width = 121
        Height = 21
        PasswordChar = '*'
        TabOrder = 1
      end
      object edtUSU_ID: TEdit
        Left = 8
        Top = 18
        Width = 40
        Height = 21
        TabOrder = 2
      end
      object edtUSU_DATA_CADASTRO: TJvDateEdit
        Left = 512
        Top = 18
        Width = 95
        Height = 21
        ShowNullDate = False
        TabOrder = 3
      end
      object cbbUSU_STATUS: TJvComboBox
        Left = 621
        Top = 18
        Width = 145
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 4
        Text = 'Ativo'
        Items.Strings = (
          'Ativo'
          'Inativo'
          'Temp. bloqueado '
          'Bloqueado')
        ItemIndex = 0
      end
    end
    inherited crdConsulta: TCard
      Height = 316
      ExplicitHeight = 316
      inherited pnlPesquisa: TPanel
        inherited lblConsulta: TLabel
          Width = 46
          Caption = 'Consultar'
          ExplicitWidth = 46
        end
      end
      inherited pnlGrid: TPanel
        Height = 268
        ExplicitHeight = 268
        inherited grdConsulta: TDBGrid
          Height = 268
          Columns = <
            item
              Expanded = False
              FieldName = 'USU_ID'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'USU_NOME'
              Title.Caption = 'Nome'
              Width = 670
              Visible = True
            end>
        end
      end
    end
  end
  inherited pnlRodaPe: TPanel
    Top = 316
    ExplicitTop = 316
  end
  inherited dsConsulta: TDataSource
    DataSet = DMUsuario.cdsUsuario
  end
end
