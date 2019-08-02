unit FileManager.Providers.Request;

interface

uses Data.DB, REST.Client, REST.Response.Adapter, FileManager.Providers.Request.Authentication, REST.Types,
  System.SysUtils, System.JSON, FileManager.Providers.Constants, FileManager.Providers.Response.Intf, System.Math,
  System.Classes;

type
  TRequest = class
  private
    FBeforeExecute: TProc;
    FAuthentication: TRequestAuthentication;
    FRESTRequest: TRESTRequest;
    FRESTResponse: TRESTResponse;
    FRESTClient: TRESTClient;
    procedure Execute(const Method: TRESTRequestMethod; const Response: IResponse);
  public
    constructor Create(const ABaseURL: string = '');
    function AddBody(const AContent: string): TRequest; overload;
    function AddBody(const AContent: TJSONObject; const AOwns: Boolean = True): TRequest; overload;
    function AddFile(const AName: string; const AContent: TStream): TRequest;
    function AddParam(const AName, AValue: string): TRequest; overload;
    function AddURLParam(const AName, AValue: string): TRequest; overload;
    function AddHeader(const AName, AValue: string; const AOptions: TRESTRequestParameterOptions = []): TRequest;
    function ClearBody: TRequest;
    function ClearParams: TRequest;
    function Clear: TRequest;
    function SetBaseURL(const ABaseURL: string = ''): TRequest;
    function SetResource(const AResource: string = ''): TRequest;
    function SetResourceSuffix(const AResourceSuffix: string = ''): TRequest;
    function SetBeforeExecute(const BeforeRequest: TProc): TRequest;
    function GET(const Response: IResponse = nil): TRequest;
    function DELETE(const Response: IResponse = nil): TRequest;
    function POST(const Response: IResponse = nil): TRequest;
    function PUT(const Response: IResponse = nil): TRequest;
    function Authentication: TRequestAuthentication;
    function Response: TRESTResponse;
    function ProcessResponse(const Response: IResponse; const IgnoreNotFound: Boolean = False): Boolean; overload;
    function ProcessResponse: Boolean; overload;
    destructor Destroy; override;
  end;

implementation

{ TRequest }

constructor TRequest.Create(const ABaseURL: string = '');
begin
  FRESTResponse := TRESTResponse.Create(nil);
  FRESTClient := TRESTClient.Create(nil);
  FRESTRequest := TRESTRequest.Create(nil);
  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Response := FRESTResponse;
  Self.SetBaseURL(ABaseURL);
end;

function TRequest.AddBody(const AContent: string): TRequest;
begin
  Result := Self;
  if not AContent.Trim.IsEmpty then
    FRESTRequest.Body.Add(AContent, ctAPPLICATION_JSON);
end;

function TRequest.AddBody(const AContent: TJSONObject; const AOwns: Boolean): TRequest;
begin
  Result := Self;
  if Assigned(AContent) then
  begin
    FRESTRequest.Body.Add(AContent);
    if AOwns then
      AContent.Free;
  end;
end;

function TRequest.AddFile(const AName: string; const AContent: TStream): TRequest;
begin
  Result := Self;
  if Assigned(AContent) then
  begin
    with FRESTRequest.Params.AddItem do
    begin
      Name := AName;
      SetStream(AContent);
      Value := AContent.ToString;
      Kind := TRESTRequestParameterKind.pkFILE;
      ContentType := TRESTContentType.ctAPPLICATION_OCTET_STREAM;
    end;
  end;
end;

function TRequest.AddHeader(const AName, AValue: string; const AOptions: TRESTRequestParameterOptions): TRequest;
begin
  Result := Self;
  if (not AName.Trim.IsEmpty) and (not AValue.Trim.IsEmpty) then
  begin
    FRESTRequest.Params.AddHeader(AName, AValue);
    FRESTRequest.Params.ParameterByName(AName).Options := AOptions;
  end;
end;

function TRequest.AddURLParam(const AName, AValue: string): TRequest;
begin
  Result := Self;
  if (not AName.Trim.IsEmpty) and (not AValue.Trim.IsEmpty) then
    FRESTRequest.AddParameter(AName, AValue, TRESTRequestParameterKind.pkURLSEGMENT);
end;

function TRequest.AddParam(const AName, AValue: string): TRequest;
begin
  Result := Self;
  if (not AName.Trim.IsEmpty) and (not AValue.Trim.IsEmpty) then
    FRESTRequest.AddParameter(AName, AValue);
end;

function TRequest.Authentication: TRequestAuthentication;
begin
  if not Assigned(FAuthentication) then
    FAuthentication := TRequestAuthentication.Create(FRESTClient);
  Result := FAuthentication;
end;

function TRequest.Clear: TRequest;
begin
  Result := Self;
  Self.ClearBody;
  Self.ClearParams;
end;

function TRequest.ClearBody: TRequest;
begin
  Result := Self;
  FRESTRequest.Body.ClearBody;
end;

function TRequest.ClearParams: TRequest;
begin
  Result := Self;
  FRESTRequest.Params.Clear;
end;

function TRequest.DELETE(const Response: IResponse): TRequest;
begin
  Result := Self;
  Execute(rmDELETE, Response);
end;

destructor TRequest.Destroy;
begin
  FAuthentication.Free;
  FRESTRequest.Free;
  FRESTClient.Free;
  FRESTResponse.Free;
  inherited;
end;

procedure TRequest.Execute(const Method: TRESTRequestMethod; const Response: IResponse);
begin
  if Assigned(FBeforeExecute) then
    FBeforeExecute;
  FRESTRequest.Method := Method;
  try
    FRESTRequest.Execute;
  except
    if Assigned(Response) then
      Response.SetError(REQUEST_ERROR_MESSAGE);
  end;
end;

function TRequest.GET(const Response: IResponse): TRequest;
begin
  Result := Self;
  Execute(rmGET, Response);
end;

function TRequest.Response: TRESTResponse;
begin
  Result := FRESTResponse;
end;

function TRequest.POST(const Response: IResponse): TRequest;
begin
  Result := Self;
  Execute(rmPOST, Response);
end;

function TRequest.ProcessResponse: Boolean;
begin
  Result := (FRESTResponse.StatusCode = TResponseCode.Sucess);
end;

function TRequest.ProcessResponse(const Response: IResponse; const IgnoreNotFound: Boolean = False): Boolean;
var
  ResponseMessage: string;
  RequiredField: TJSONValue;
begin
  Result := False;
  if not Response.Success then
    Exit;
  if (FRESTResponse.StatusCode = TResponseCode.Sucess) then
    Result := True
  else
  begin
    if (FRESTResponse.StatusCode = TResponseCode.NotFound) and (IgnoreNotFound) then
      Exit;
    if not FRESTResponse.JSONValue.TryGetValue<string>('description', ResponseMessage) then
      if not FRESTResponse.JSONValue.TryGetValue<string>('message', ResponseMessage) then
        if not FRESTResponse.JSONValue.TryGetValue<string>('error', ResponseMessage) then
          if (FRESTResponse.JSONValue is TJSONArray) then
          begin
            for RequiredField in FRESTResponse.JSONValue.GetValue<TJSONArray> do
              if RequiredField.TryGetValue<string>('message', ResponseMessage) then
                Response.SetError(ResponseMessage);
             Exit;
          end
          else if Response.Success then
            ResponseMessage := REQUEST_ERROR_MESSAGE;
    Response.SetError(ResponseMessage);
  end;
end;

function TRequest.PUT(const Response: IResponse): TRequest;
begin
  Result := Self;
  Execute(rmPUT, Response);
end;

function TRequest.SetBaseURL(const ABaseURL: string = ''): TRequest;
begin
  Result := Self;
  FRESTClient.BaseURL := ABaseURL;
end;

function TRequest.SetBeforeExecute(const BeforeRequest: TProc): TRequest;
begin
  Result := Self;
  FBeforeExecute := BeforeRequest;
end;

function TRequest.SetResource(const AResource: string = ''): TRequest;
begin
  Result := Self;
  Self.ClearBody;
  Self.ClearParams;
  FRESTRequest.ResourceSuffix := EmptyStr;
  FRESTRequest.Resource := AResource;
end;

function TRequest.SetResourceSuffix(const AResourceSuffix: string = ''): TRequest;
begin
  Result := Self;
  Self.ClearBody;
  Self.ClearParams;
  FRESTRequest.ResourceSuffix := AResourceSuffix;
end;

end.
