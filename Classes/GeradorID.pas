unit GeradorID;

interface

type
  TGeradorID = class
    class function GetID: String;
  end;

implementation

uses
  System.SysUtils;

{ TGeradorID }

class function TGeradorID.GetID: String;
begin
  Result := TGUID.NewGuid.ToString;
  Result := StringReplace(Result, '{', '', [rfReplaceAll]);
  Result := StringReplace(Result, '}', '', [rfReplaceAll]);
end;

end.
