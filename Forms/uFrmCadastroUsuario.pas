unit uFrmCadastroUsuario;

interface

uses
  uFrmCadastroBase, LibUtil,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.WinXPanels, Vcl.Mask, JvExMask, JvToolEdit, JvExStdCtrls, JvCombobox;

type
  TFrmCadastroUsuario = class(TFrmCadastroBase)
    lbl1: TLabel;
    edtUSU_NOME: TEdit;
    lbl2: TLabel;
    edtUSU_SENHA: TEdit;
    lbl3: TLabel;
    edtUSU_ID: TEdit;
    edtUSU_DATA_CADASTRO: TJvDateEdit;
    lbl4: TLabel;
    cbbUSU_STATUS: TJvComboBox;
    lbl5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Cancelar; override;
    procedure CarregarConsultaCadastro; override;
    procedure Excluir; override;
    procedure GetProximoId; override;
    procedure InicializarTelaCadastro; override;
    procedure LimpaTela; override;
    procedure PreencherDadosCadastro; override;
    procedure SQLConsulta; override;
    procedure ValidaCadastro; override;
    { Public declarations }
  end;

var
  FrmCadastroUsuario: TFrmCadastroUsuario;

implementation

uses
  uDMUsuario, Enumerados;

{$R *.dfm}

procedure TFrmCadastroUsuario.btnGravarClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TFrmCadastroUsuario.Cancelar;
begin
  inherited;

  dmUsuario.cdsUsuario.Cancel;
end;

procedure TFrmCadastroUsuario.CarregarConsultaCadastro;
begin
  inherited;

  edtUSU_ID.Text            := dmUsuario.cdsUsuarioUSU_ID.AsString;
  edtUSU_NOME.Text          := dmUsuario.cdsUsuarioUSU_NOME.AsString;
  edtUSU_DATA_CADASTRO.Date := dmUsuario.cdsUsuarioUSU_DATA_CADASTRO.AsDateTime;
  edtUSU_SENHA.Text         := dmUsuario.cdsUsuarioUSU_SENHA.AsString;
  cbbUSU_STATUS.ItemIndex   := dmUsuario.cdsUsuarioUSU_STATUS.AsInteger;
end;

procedure TFrmCadastroUsuario.Excluir;
begin
  inherited;

  dmUsuario.cdsUsuario.Delete;
  dmUsuario.cdsUsuario.ApplyUpdates(0);
end;

procedure TFrmCadastroUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TFrmCadastroUsuario.FormDestroy(Sender: TObject);
begin
  inherited;
  //
end;

procedure TFrmCadastroUsuario.GetProximoId;
begin
  edtUSU_ID.Text := DMUsuario.GetProximoId.ToString;
end;

procedure TFrmCadastroUsuario.InicializarTelaCadastro;
begin
  inherited;

  edtUSU_DATA_CADASTRO.Date := Date;
  cbbUSU_STATUS.ItemIndex   := 0;
end;

procedure TFrmCadastroUsuario.LimpaTela;
begin
  inherited;

  for var mI := 0 to Pred(ComponentCount) do
    begin
      if (Components[mI] is TCustomEdit) then
        TCustomEdit(Components[mI]).Clear
      else if (Components[mI] is TCustomComboBox) then
        TCustomComboBox(Components[mI]).ItemIndex := 0
      else if (Components[mI] is TJvDateEdit) then
        TJvDateEdit(Components[mI]).Date := Date;
    end;
end;

procedure TFrmCadastroUsuario.PreencherDadosCadastro;
begin
  inherited;

  if (fProcesso = spInserindo) then
    dmUsuario.cdsUsuario.Insert
  else
    dmUsuario.cdsUsuario.Edit;

  if edtUSU_ID.IsNotEmpty then
    dmUsuario.cdsUsuarioUSU_ID.AsInteger           := edtUSU_ID.ToInteger;

  dmUsuario.cdsUsuarioUSU_NOME.AsString            := edtUSU_NOME.Text;
  dmUsuario.cdsUsuarioUSU_DATA_CADASTRO.AsDateTime := edtUSU_DATA_CADASTRO.Date;
  dmUsuario.cdsUsuarioUSU_HORA_CADASTRO.AsDateTime := Now;
  dmUsuario.cdsUsuarioUSU_SENHA.AsString           := edtUSU_SENHA.Text;
  dmUsuario.cdsUsuarioUSU_STATUS.AsInteger         := cbbUSU_STATUS.ItemIndex;
  dmUsuario.cdsUsuario.Post;
  dmUsuario.cdsUsuario.ApplyUpdates(0);
end;

procedure TFrmCadastroUsuario.SQLConsulta;
begin
  if (crdpBase.ActiveCard <> crdConsulta) then
    Exit;

  fSQL.Clear;
  fSQL.Add('SELECT *');
  fSQL.Add('FROM usuario ');
  fSQL.Add('WHERE (1 = 1)');

  if edtConsulta.IsNotEmpty then
    fSQL.Add('  AND ((usu_nome || '' '' || usu_id) LIKE :mFiltro)');

  if chkAtivo.Checked then
    fSQL.Add('  AND (usu_status = 0)');

  SQLParam.SubstituirTexto(fSQL, 'mFiltro', '%' + Trim(edtConsulta.Text) + '%');
end;

procedure TFrmCadastroUsuario.ValidaCadastro;
begin
  if edtUSU_NOME.IsEmpty then
    AdicionarCampoInvalido('Necessário informar o nome!', edtUSU_NOME);

  if edtUSU_SENHA.IsEmpty then
    AdicionarCampoInvalido('Necessário informar a senha!', edtUSU_SENHA);

  if DMUsuario.Get(edtUSU_NOME.Text, edtUSU_ID.ToInteger) then
    AdicionarCampoInvalido('Usuário já cadastrado!', edtUSU_NOME);
end;

end.
