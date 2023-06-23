object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Controle financeiro'
  ClientHeight = 541
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmMenu
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 541
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlTopo: TPanel
      Left = 0
      Top = 0
      Width = 784
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Color = clHighlightText
      ParentBackground = False
      TabOrder = 0
      DesignSize = (
        784
        41)
      object btnLogout: TSpeedButton
        Left = 736
        Top = 0
        Width = 48
        Height = 41
        Align = alRight
        ImageIndex = 1199
        Images = dmImagem.imgIcones32x32
        Flat = True
        OnClick = btnLogoutClick
      end
      object lblUsuarioLogado: TLabel
        Left = 653
        Top = 20
        Width = 81
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'lblUsuarioLogado'
      end
    end
  end
  object mmMenu: TMainMenu
    Left = 16
    Top = 16
    object mniCadastro: TMenuItem
      Caption = 'Cadastros'
      object mniCadastroUsuarios: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = mniCadastroUsuariosClick
      end
    end
    object mniRelatorios: TMenuItem
      Caption = 'Relat'#243'rios'
    end
    object mniAjuda: TMenuItem
      Caption = 'Ajuda'
    end
  end
end
