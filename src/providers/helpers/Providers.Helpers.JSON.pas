unit Providers.Helpers.JSON;

interface

uses System.JSON;

type
  TJSONHelper = class helper for TJSONObject
    procedure UpdatePair(const PairName, PairValue: string);
  end;

implementation

{ TJSONHelper }

procedure TJSONHelper.UpdatePair(const PairName, PairValue: string);
begin
  Self.RemovePair(PairName).Free;
  Self.AddPair(PairName, PairValue);
end;

end.
