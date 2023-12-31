unit DMClient;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, Data.DBXCommon, IPPeerClient, Data.SqlExpr, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect;

type
  TDataModule1 = class(TDataModule)
    dspcServer: TDSProviderConnection;
    conServer: TSQLConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
