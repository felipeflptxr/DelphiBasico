unit uFrmSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Imaging.jpeg;

type
  TFrmSplash = class(TForm)
    pnlFundo: TPanel;
    imgLogo: TImage;
    lblTitulo: TLabel;
    pbInicializando: TProgressBar;
    tmrInicializando: TTimer;
    lblStatus: TLabel;
    imgBancoDados: TImage;
    imgDependencias: TImage;
    imgConfiguraoes: TImage;
    imgInicializando: TImage;
    procedure tmrInicializandoTimer(Sender: TObject);
  private
    procedure AtualizarStatus(mMensagem: String; mImagem: TImage);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSplash: TFrmSplash;

implementation

uses
  LibUtil;

{$R *.dfm}

procedure TFrmSplash.AtualizarStatus(mMensagem: String; mImagem: TImage);
begin
  lblStatus.Caption := mMensagem;
  mImagem.Visible   := True;
end;

procedure TFrmSplash.tmrInicializandoTimer(Sender: TObject);
begin
  if (pbInicializando.Position <= 100) then
    begin
      pbInicializando.StepIt;

      case pbInicializando.Position of
        10 : AtualizarStatus('Carregando depedências...', imgDependencias);
        30 : AtualizarStatus('Conectando ao banco de dados...', imgBancoDados);
        50 : AtualizarStatus('Conectando as configurações...', imgConfiguraoes);
        80 : AtualizarStatus('Inciando sistema...', imgInicializando);
      end;
    end;

  if (pbInicializando.Position = 100) then
    Close;
end;

end.
