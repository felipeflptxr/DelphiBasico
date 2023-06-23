unit uFrmLogin;

interface

uses
  uDMImagem, LibUtil, uDMUsuario,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.Buttons;

type
  TFrmLogin = class(TForm)
    pnlFundo: TPanel;
    pnlImgLogin: TPanel;
    imgLogin: TImage;
    pnlLogin: TPanel;
    pnlMsg: TPanel;
    pnlUsuarioSenha: TPanel;
    lblTitulo: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    edtLogin: TEdit;
    edtSenha: TEdit;
    btnEntrar: TSpeedButton;
    btn1: TSpeedButton;
    procedure edtLoginChange(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Logar;
    function VerificaSePodeTentarLogar: Boolean;
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

procedure TFrmLogin.btn1Click(Sender: TObject);
begin
  if edtSenha.PasswordChar = #0 then
    edtSenha.PasswordChar := #42
  else
    edtSenha.PasswordChar := #0;
end;

procedure TFrmLogin.btnEntrarClick(Sender: TObject);
begin
  Logar;
end;

procedure TFrmLogin.edtLoginChange(Sender: TObject);
begin
  VerificaSePodeTentarLogar;
end;

procedure TFrmLogin.Logar;
begin
  if DMUsuario.ValidaLoginSistema(edtLogin.ToInteger, Trim(edtSenha.Text)) then
    ModalResult := mrOK
  else
    Erro('ID de usuário ou senha incorretos!');
end;

function TFrmLogin.VerificaSePodeTentarLogar: Boolean;
begin
  btnEntrar.Enabled := (not edtLogin.IsEmpty) and (not edtSenha.IsEmpty);
end;

end.
