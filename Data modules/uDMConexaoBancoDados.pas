unit uDMConexaoBancoDados;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Datasnap.Provider, Datasnap.DBClient;

type
  TDMConexaoBancoDados = class(TDataModule)
    conBancoDados: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    const
      cfArquivoConfig = 'DBDados.cfg';
    { Private declarations }
  public
    procedure CarregarConfiguracao;
    procedure Conectar;
    procedure Desconectar;
    { Public declarations }
  end;

var
  DMConexaoBancoDados: TDMConexaoBancoDados;

implementation

uses
  LibUtil;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMConexaoBancoDados }

procedure TDMConexaoBancoDados.CarregarConfiguracao;
begin
  conBancoDados.Params.Clear;

  if (not FileExists(cfArquivoConfig)) then
    raise Exception.Create('Arquivo de configuração do banco de dados não encontrado');

  var mListaParametros := TStringList.Create;
  try
    var mParametroNome : String;
    var mParametroValor : String;
    mListaParametros.LoadFromFile(cfArquivoConfig);

    for var mI := 0 to Pred(mListaParametros.Count) do
      begin
        if (mListaParametros[mI].IndexOf('=') > 0) then
          begin
            mParametroNome  := mListaParametros[mI].Split(['='])[0].Trim;
            mParametroValor := mListaParametros[mI].Split(['='])[1].Trim;
            conBancoDados.Params.Add(mParametroNome + '=' + mParametroValor);
          end;
      end;
  finally
    FreeAndNil(mListaParametros);
  end;
end;

procedure TDMConexaoBancoDados.Conectar;
begin
  conBancoDados.Connected := True;
end;

procedure TDMConexaoBancoDados.DataModuleCreate(Sender: TObject);
begin
  CarregarConfiguracao;
  Conectar;
end;

procedure TDMConexaoBancoDados.Desconectar;
begin
  conBancoDados.Connected := False;
end;

end.
