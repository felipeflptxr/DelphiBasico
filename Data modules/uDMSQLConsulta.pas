unit uDMSQLConsulta;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.Provider, Datasnap.DBClient;

type
  TDMSQLConsulta = class(TDataModule)
    qryUsuario: TFDQuery;
    cdsUsuario: TClientDataSet;
    dspUsuario: TDataSetProvider;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMSQLConsulta: TDMSQLConsulta;

implementation

uses
  uDMConexaoBancoDados;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
