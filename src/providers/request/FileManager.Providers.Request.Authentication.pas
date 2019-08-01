unit FileManager.Providers.Request.Authentication;

interface

uses REST.Client, REST.Authenticator.Basic;

type
  TRequestAuthentication = class
  private
    FRESTClient: TRESTClient;
    FHTTPBasicAuthenticator: THTTPBasicAuthenticator;
  public
    constructor Create(const ARESTClient: TRESTClient);
    function Clear: TRequestAuthentication;
    function SetPassword(const APassword: string): TRequestAuthentication;
    function SetUsername(const AUser: string): TRequestAuthentication;
    function Password: string;
    function Username: string;
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils;

{ TRequestAuthentication }

function TRequestAuthentication.Clear: TRequestAuthentication;
begin
  Result := Self;
  FRESTClient.Authenticator := nil;
  FHTTPBasicAuthenticator.Password := EmptyStr;
  FHTTPBasicAuthenticator.Username := EmptyStr;
end;

constructor TRequestAuthentication.Create(const ARESTClient: TRESTClient);
begin
  FHTTPBasicAuthenticator := THTTPBasicAuthenticator.Create(nil);
  FRESTClient := ARESTClient;
end;

destructor TRequestAuthentication.Destroy;
begin
  FreeAndNil(FHTTPBasicAuthenticator);
  inherited;
end;

function TRequestAuthentication.Password: string;
begin
  Result := FHTTPBasicAuthenticator.Password;
end;

function TRequestAuthentication.SetPassword(const APassword: string): TRequestAuthentication;
begin
  Result := Self;
  if not Assigned(FRESTClient.Authenticator) then
    FRESTClient.Authenticator := FHTTPBasicAuthenticator;
  FHTTPBasicAuthenticator.Password := APassword;
end;

function TRequestAuthentication.SetUsername(const AUser: string): TRequestAuthentication;
begin
  Result := Self;
  if not Assigned(FRESTClient.Authenticator) then
    FRESTClient.Authenticator := FHTTPBasicAuthenticator;
  FHTTPBasicAuthenticator.Username := AUser;
end;

function TRequestAuthentication.Username: string;
begin
  Result := FHTTPBasicAuthenticator.Username;
end;

end.
