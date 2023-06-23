object FrmCadastroBase: TFrmCadastroBase
  Left = 0
  Top = 0
  Caption = 'Cadastro base'
  ClientHeight = 561
  ClientWidth = 784
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object crdpBase: TCardPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 516
    Align = alClient
    ActiveCard = crdConsulta
    BevelOuter = bvNone
    TabOrder = 0
    object crdCadastro: TCard
      Left = 0
      Top = 0
      Width = 784
      Height = 516
      Caption = 'crdCadastro'
      CardIndex = 0
      TabOrder = 0
      object pnlFundoCadastro: TPanel
        Left = 0
        Top = 0
        Width = 784
        Height = 516
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
    object crdConsulta: TCard
      Left = 0
      Top = 0
      Width = 784
      Height = 516
      Caption = 'crdConsulta'
      CardIndex = 1
      TabOrder = 1
      object pnlPesquisa: TPanel
        Left = 0
        Top = 0
        Width = 784
        Height = 48
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          784
          48)
        object lblConsulta: TLabel
          Left = 8
          Top = 3
          Width = 96
          Height = 13
          Caption = 'Consultar cadastros'
        end
        object edtConsulta: TEdit
          Left = 8
          Top = 18
          Width = 709
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
          TabOrder = 0
          OnChange = edtConsultaChange
        end
        object chkAtivo: TCheckBox
          Left = 729
          Top = 20
          Width = 47
          Height = 17
          Anchors = [akTop, akRight]
          Caption = 'Ativo'
          TabOrder = 1
          OnClick = chkAtivoClick
        end
      end
      object pnlGrid: TPanel
        Left = 0
        Top = 48
        Width = 784
        Height = 468
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          784
          468)
        object grdConsulta: TDBGrid
          Left = 8
          Top = 0
          Width = 768
          Height = 468
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dsConsulta
          DrawingStyle = gdsGradient
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDblClick = grdConsultaDblClick
        end
      end
    end
  end
  object pnlRodaPe: TPanel
    Left = 0
    Top = 516
    Width = 784
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object tlbRodaPe: TToolBar
      Left = 266
      Top = 5
      Width = 500
      Height = 36
      Align = alNone
      ButtonHeight = 36
      ButtonWidth = 55
      Caption = 'tlbRodaPe'
      Images = dmImagem.imgIcones16x16
      ShowCaptions = True
      TabOrder = 0
      object btnNovo: TToolButton
        Left = 0
        Top = 0
        Caption = 'Novo'
        ImageIndex = 1
        OnClick = btnNovoClick
      end
      object btnAlterar: TToolButton
        Left = 55
        Top = 0
        Caption = 'Alterar'
        ImageIndex = 1339
        OnClick = btnAlterarClick
      end
      object btnExcluir: TToolButton
        Left = 110
        Top = 0
        Caption = 'Excluir'
        ImageIndex = 1093
        OnClick = btnExcluirClick
      end
      object btnRelatorios: TToolButton
        Left = 165
        Top = 0
        Caption = 'Relatorios'
        ImageIndex = 1049
      end
      object btnGravar: TToolButton
        Left = 220
        Top = 0
        Caption = 'Gravar'
        ImageIndex = 1132
        OnClick = btnGravarClick
      end
      object btnCancelar: TToolButton
        Left = 275
        Top = 0
        Caption = 'Cancelar'
        ImageIndex = 210
        OnClick = btnCancelarClick
      end
      object btnFechar: TToolButton
        Left = 330
        Top = 0
        Caption = 'Fechar'
        ImageIndex = 250
        OnClick = btnFecharClick
      end
    end
  end
  object dsConsulta: TDataSource
    Left = 48
    Top = 96
  end
  object tmrConsulta: TTimer
    Enabled = False
    OnTimer = tmrConsultaTimer
    Left = 112
    Top = 96
  end
end
