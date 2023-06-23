unit uFrmPrincipal;

interface

uses
  uFrmLogin, uDMImagem, uDMUsuario,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, LibUtil, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls;

type
  TFrmPrincipal = class(TForm)
    mmMenu: TMainMenu;
    mniCadastro: TMenuItem;
    mniRelatorios: TMenuItem;
    mniAjuda: TMenuItem;
    mniCadastroUsuarios: TMenuItem;
    btnLogout: TSpeedButton;
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    lblUsuarioLogado: TLabel;
    procedure mniCadastroUsuariosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure LoginSistema;
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  uFrmCadastroUsuario, uFrmSplash;

{$R *.dfm}

procedure TFrmPrincipal.btnLogoutClick(Sender: TObject);
begin
  LoginSistema;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  LoginSistema;

  FrmSplash := TFrmSplash.Create(nil);
  try
    FrmSplash.ShowModal;
  finally
    FreeAndNil(FrmSplash);
  end;
end;

procedure TFrmPrincipal.LoginSistema;
begin
  FrmLogin := TFrmLogin.Create(nil);
  try
    FrmLogin.ShowModal;
    if (FrmLogin.ModalResult <> mrOK) then
      Application.Terminate;
  finally
    FreeAndNil(FrmLogin);
  end;

  lblUsuarioLogado.Caption := DMUsuario.NomeLogin;
end;

procedure TFrmPrincipal.mniCadastroUsuariosClick(Sender: TObject);
begin
  Form.Abrir(TFrmCadastroUsuario, FrmCadastroUsuario);
end;

end.
