unit uFrmCadastroBase;

interface

uses
  Enumerados,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXPanels, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.ToolWin;

type
  TFrmCadastroBase = class(TForm)
    crdpBase: TCardPanel;
    crdCadastro: TCard;
    crdConsulta: TCard;
    pnlPesquisa: TPanel;
    pnlGrid: TPanel;
    pnlRodaPe: TPanel;
    grdConsulta: TDBGrid;
    lblConsulta: TLabel;
    edtConsulta: TEdit;
    chkAtivo: TCheckBox;
    tlbRodaPe: TToolBar;
    btnFechar: TToolButton;
    btnNovo: TToolButton;
    btnAlterar: TToolButton;
    btnRelatorios: TToolButton;
    btnExcluir: TToolButton;
    btnGravar: TToolButton;
    btnCancelar: TToolButton;
    dsConsulta: TDataSource;
    tmrConsulta: TTimer;
    pnlFundoCadastro: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure tmrConsultaTimer(Sender: TObject);
    procedure edtConsultaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure grdConsultaDblClick(Sender: TObject);
    procedure chkAtivoClick(Sender: TObject);
  public
    fSQL: TStringList;
    fProcesso: TStatusProcesso;
    fMensagemErro: TStringList;
    fComponeteFocarAposErro: TComponent;

    procedure AdicionarCampoInvalido(mMensagem: String; mComponenteFocar: TComponent);
    procedure Cancelar; virtual;
    procedure CarregarConsultaCadastro; virtual;
    procedure CarregarTela; virtual;
    procedure Consultar;
    procedure Excluir; virtual;
    procedure GetProximoId; virtual;
    procedure Gravar;
    procedure InicializarTelaCadastro; virtual;
    procedure LimpaTela; virtual;
    procedure LimparCampoInvalido;
    procedure MostrarOcultarBotoes;
    procedure PosicionarBotoes;
    procedure PreencherDadosCadastro; virtual;
    procedure SQLConsulta; virtual;
    procedure ValidaCadastro; virtual;
    function ValidaCadastroMostrouMensagem: Boolean;
    function ValidaFechar: Boolean;
  end;

var
  FrmCadastroBase: TFrmCadastroBase;

implementation

uses
  uDMImagem, LibUtil, uDMUsuario;

{$R *.dfm}

procedure TFrmCadastroBase.AdicionarCampoInvalido(mMensagem: String; mComponenteFocar: TComponent);
begin
  fMensagemErro.Add(mMensagem);
  fComponeteFocarAposErro := fComponeteFocarAposErro;
end;

procedure TFrmCadastroBase.btnAlterarClick(Sender: TObject);
begin
  fProcesso := spAlterando;
  CarregarTela;
  CarregarConsultaCadastro;
end;

procedure TFrmCadastroBase.btnCancelarClick(Sender: TObject);
begin
  Cancelar;
  CarregarTela;
end;

procedure TFrmCadastroBase.btnExcluirClick(Sender: TObject);
begin
  try
    if Confirma('Exclusão é irreversível!' + cgEnterEmString + 'Deseja continuar?') then
      Excluir
    else
      Exit;
  except
    Erro('Não foi possível realizar a exclusão');
  end;

  if (crdpBase.ActiveCard = crdCadastro) then
    CarregarTela;

  Informa('Resgistro excluído');
end;

procedure TFrmCadastroBase.btnFecharClick(Sender: TObject);
begin
  if ValidaFechar then
    Close;
end;

procedure TFrmCadastroBase.btnGravarClick(Sender: TObject);
begin
  LimparCampoInvalido;
  ValidaCadastro;

  if ValidaCadastroMostrouMensagem then
    Exit;

  Gravar;
  CarregarTela;
end;

procedure TFrmCadastroBase.btnNovoClick(Sender: TObject);
begin
  fProcesso := spInserindo;
  CarregarTela;
end;

procedure TFrmCadastroBase.Cancelar;
begin

end;

procedure TFrmCadastroBase.CarregarConsultaCadastro;
begin

end;

procedure TFrmCadastroBase.CarregarTela;
begin
  if (crdpBase.ActiveCard = crdCadastro) then
    crdpBase.ActiveCard := crdConsulta
  else
    crdpBase.ActiveCard := crdCadastro;

  if (fProcesso = spInserindo) then
    begin
      LimpaTela;
      GetProximoId;
      InicializarTelaCadastro;
    end;

  MostrarOcultarBotoes;
  PosicionarBotoes;
end;

procedure TFrmCadastroBase.chkAtivoClick(Sender: TObject);
begin
  tmrConsulta.Enabled := False;
  tmrConsulta.Enabled := True;
end;

procedure TFrmCadastroBase.Consultar;
begin
  SQLConsulta;

  DMUsuario.cdsUsuario.Close;
  DMUsuario.cdsUsuario.CommandText := fSQL.Text;
  DMUsuario.cdsUsuario.Open;
end;

procedure TFrmCadastroBase.edtConsultaChange(Sender: TObject);
begin
  tmrConsulta.Enabled := False;
  tmrConsulta.Enabled := True;
end;

procedure TFrmCadastroBase.Excluir;
begin

end;

procedure TFrmCadastroBase.FormCreate(Sender: TObject);
begin
  fSQL          := TStringList.Create;
  fMensagemErro := TStringList.Create;
end;

procedure TFrmCadastroBase.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fSQL);
  FreeAndNil(fMensagemErro);
end;

procedure TFrmCadastroBase.FormResize(Sender: TObject);
begin
  PosicionarBotoes;
end;

procedure TFrmCadastroBase.FormShow(Sender: TObject);
begin
  crdpBase.ActiveCard := crdConsulta;
  MostrarOcultarBotoes;
  PosicionarBotoes;
  tmrConsulta.Enabled := True;
end;

procedure TFrmCadastroBase.GetProximoId;
begin

end;

procedure TFrmCadastroBase.Gravar;
begin
  PreencherDadosCadastro;
  Informa('Registro salvo com sucesso!');
  CarregarConsultaCadastro;
end;

procedure TFrmCadastroBase.grdConsultaDblClick(Sender: TObject);
begin
  btnAlterarClick(nil);
end;

procedure TFrmCadastroBase.InicializarTelaCadastro;
begin

end;

procedure TFrmCadastroBase.LimparCampoInvalido;
begin
  fMensagemErro.Clear;
  fComponeteFocarAposErro := nil;
end;

procedure TFrmCadastroBase.LimpaTela;
begin

end;

procedure TFrmCadastroBase.MostrarOcultarBotoes;
begin
  btnNovo.Visible       := (crdpBase.ActiveCard = crdConsulta);
  btnAlterar.Visible    := (crdpBase.ActiveCard = crdConsulta);
  btnRelatorios.Visible := (crdpBase.ActiveCard = crdConsulta);
  btnGravar.Visible     := (crdpBase.ActiveCard = crdCadastro);
  btnCancelar.Visible   := (crdpBase.ActiveCard = crdCadastro);
end;

procedure TFrmCadastroBase.PosicionarBotoes;
begin
  var mLargura := 0;

  if btnNovo.Visible then
    mLargura := mLargura + btnNovo.Width;

  if btnAlterar.Visible then
    mLargura := mLargura + btnAlterar.Width;

  if btnRelatorios.Visible then
    mLargura := mLargura + btnRelatorios.Width;

  if btnExcluir.Visible then
    mLargura := mLargura + btnExcluir.Width;

  if btnGravar.Visible then
    mLargura := mLargura + btnGravar.Width;

  if btnCancelar.Visible then
    mLargura := mLargura + btnCancelar.Width;

  if btnFechar.Visible then
    mLargura := mLargura + btnFechar.Width;

  tlbRodaPe.Width := mLargura;
  tlbRodaPe.Left := Trunc((Width - tlbRodaPe.Width) / 2);
end;

procedure TFrmCadastroBase.PreencherDadosCadastro;
begin

end;

procedure TFrmCadastroBase.SQLConsulta;
begin
  inherited;

end;

procedure TFrmCadastroBase.tmrConsultaTimer(Sender: TObject);
begin
  tmrConsulta.Enabled := False;
  Consultar;
end;

procedure TFrmCadastroBase.ValidaCadastro;
begin

end;

function TFrmCadastroBase.ValidaCadastroMostrouMensagem: Boolean;
begin
  if (fMensagemErro.Count <= 0) then
    Exit(False);

  Result := True;
  Erro(fMensagemErro.Text);
  //(fComponeteFocarAposErro as TWinControl).SetFocus;
end;

function TFrmCadastroBase.ValidaFechar: Boolean;
begin
  Result := (crdpBase.ActiveCard = crdConsulta);

  if (not Result) then
    Result := Confirma('Todo o progresso não salvo será perdido!' + cgEnterEmString + 'Deseja sair?');
end;

end.

