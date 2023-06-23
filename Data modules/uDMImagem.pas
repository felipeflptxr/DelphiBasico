unit uDMImagem;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls;

type
  TdmImagem = class(TDataModule)
    imgIcones16x16: TImageList;
    imgIcones32x32: TImageList;
    imgImagens: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmImagem: TdmImagem;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
