unit FileManager.Providers.Response.Default;

interface

uses
  FileManager.Providers.Response.Intf, System.Classes, System.JSON;

type
  TResponse = class(TInterfacedObject, IResponse)
  private
    FRequeiredFields: TStringList;
    FTipo: TResponseType;
    FErrorMessage: TStringList;
    function GetRequiredFields: TStringList;
    function GetErrorMessage: string;
    function SetRequiredField(const Value: string): IResponse;
    function SetError(const Value: string): IResponse; overload;
    function SetError: IResponse; overload;
    function Success: Boolean;
    function Error: Boolean;
    function Clear: IResponse;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils;

destructor TResponse.Destroy;
begin
  FRequeiredFields.Free;
  FErrorMessage.Free;
  inherited;
end;

function TResponse.Error: Boolean;
begin
  Result := (FTipo = TResponseType.Error);
end;

function TResponse.GetErrorMessage: string;
begin
  Result := FErrorMessage.Text;
end;

function TResponse.GetRequiredFields: TStringList;
begin
  FTipo := TResponseType.Error;
  Result := FRequeiredFields;
end;

function TResponse.Clear: IResponse;
begin
  Result := Self;
  FErrorMessage.Clear;
end;

constructor TResponse.Create;
begin
  FTipo := TResponseType.Success;
  FRequeiredFields := TStringList.Create;
  FErrorMessage := TStringList.Create;
end;

function TResponse.SetError: IResponse;
begin
  FTipo := TResponseType.Error;
end;

function TResponse.SetError(const Value: string): IResponse;
begin
  Result := Self;
  FTipo := TResponseType.Error;
  FErrorMessage.Add(Value);
end;

function TResponse.SetRequiredField(const Value: string): IResponse;
begin
  Result := Self;
  FRequeiredFields.Add(Value);
end;

function TResponse.Success: Boolean;
begin
  Result := (FTipo = TResponseType.Success);
end;

end.
