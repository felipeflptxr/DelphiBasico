unit uDMUsuario;

interface

uses
  uDMConexaoBancoDados,

  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.Provider, Datasnap.DBClient;

type
  TDMUsuario = class(TDataModule)
    qryUsuario: TFDQuery;
    cdsUsuario: TClientDataSet;
    dspUsuario: TDataSetProvider;
    cdsUsuarioUSU_ID: TIntegerField;
    cdsUsuarioUSU_NOME: TStringField;
    cdsUsuarioUSU_SENHA: TStringField;
    cdsUsuarioUSU_DATA_CADASTRO: TDateField;
    cdsUsuarioUSU_HORA_CADASTRO: TTimeField;
    cdsUsuarioUSU_STATUS: TIntegerField;
  private
    FNomeLogin: String;
    FIdLogin: Integer;

    procedure SetNomeLogin(const Value: String);
    procedure SetIdLogin(const Value: Integer);
    { Private declarations }
  public
    function Get(mNome: String; mId: Integer): Boolean;
    function GetProximoId: Integer;
    function ValidaLoginSistema(mId: Integer; mSenha: String): Boolean;

    property NomeLogin : String read FNomeLogin write SetNomeLogin;
    property IdLogin : Integer read FIdLogin write SetIdLogin;
    { Public declarations }
  end;

var
  DMUsuario: TDMUsuario;

implementation

uses
  LibUtil;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMUsuario }

function TDMUsuario.Get(mNome: String; mId: Integer): Boolean;
begin
  var mQry := TFDQuery.Create(nil);
  var mSQL := TStringList.Create;
  try
    mQry.Connection := DMConexaoBancoDados.conBancoDados;
    mQry.SQL.Clear;

    mSQL.Add('SELECT *');
    mSQL.Add('FROM usuario');
    mSQL.Add('WHERE (usu_nome = :mUsuNome)');
    SQLParam.SubstituirTexto(mSQL, 'mUsuNome', mNome);

    mQry.SQL.Add(mSQL.Text);
    mQry.Open;

    Result := (not mQry.IsEmpty) and (mQry.FieldByName('USU_ID').AsInteger <> mId);
  finally
    mQry.Close;
    FreeAndNil(mQry);
    FreeAndNil(mSQL);
  end;
end;

function TDMUsuario.GetProximoId: Integer;
begin
  var mQry := TFDQuery.Create(nil);
  var mSQL := TStringList.Create;
  try
    mQry.Connection := DMConexaoBancoDados.conBancoDados;
    mQry.SQL.Clear;

    mSQL.Add('SELECT (MAX(usu_id) + 1) AS usu_id');
    mSQL.Add('FROM usuario');

    mQry.SQL.Add(mSQL.Text);
    mQry.Open;

    Result := mQry.FieldByName('USU_ID').AsInteger;
  finally
    mQry.Close;
    FreeAndNil(mQry);
    FreeAndNil(mSQL);
  end;
end;

procedure TDMUsuario.SetIdLogin(const Value: Integer);
begin
  FIdLogin := Value;
end;

procedure TDMUsuario.SetNomeLogin(const Value: String);
begin
  FNomeLogin := Value;
end;

function TDMUsuario.ValidaLoginSistema(mId: Integer; mSenha: String): Boolean;
begin
  var mQry := TFDQuery.Create(nil);
  var mSQL := TStringList.Create;
  try
    mQry.Connection := DMConexaoBancoDados.conBancoDados;
    mQry.SQL.Clear;

    mSQL.Add('SELECT *');
    mSQL.Add('FROM usuario');
    mSQL.Add('WHERE (usu_status = 0)');
    mSQL.Add('  AND (usu_id = :mUsuId)');
    SQLParam.SubstituirInteiro(mSQL, 'mUsuId', mId);

    mQry.SQL.Add(mSQL.Text);
    mQry.Open;

    Result := (not mQry.IsEmpty) and (mQry.FieldByName('USU_SENHA').AsString = mSenha);

    if (not Result) then
      Exit;

    FIdLogin   := mId;
    FNomeLogin := mQry.FieldByName('USU_NOME').AsString
  finally
    mQry.Close;
    FreeAndNil(mQry);
    FreeAndNil(mSQL);
  end;
end;

end.
