inherited FrmCadastroBase1: TFrmCadastroBase1
  Caption = 'FrmCadastroBase1'
  ClientHeight = 419
  ExplicitHeight = 458
  PixelsPerInch = 96
  TextHeight = 13
  inherited crdpBase: TCardPanel
    Height = 374
    inherited crdCadastro: TCard
      Height = 374
    end
    inherited crdConsulta: TCard
      Height = 374
      inherited pnlGrid: TPanel
        Height = 326
        inherited grdConsulta: TDBGrid
          Height = 326
        end
      end
    end
  end
  inherited pnlRodaPe: TPanel
    Top = 374
  end
end
