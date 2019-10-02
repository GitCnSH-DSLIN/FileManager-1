unit FileManager;

interface

uses FileManager.Views.FileControl, Vcl.Forms, FileManager.Providers.Modulos.Imagens, FileManager.Providers.FileServer, JOSE.Core.JWT,
  System.SysUtils, FileManager.Providers.Constants, System.DateUtils, JOSE.Core.Builder;

type
  TFileManager = class
  private
    FFileControl: TFrmFileControl;
    procedure SetMaxFileSize(const Value: Int64);
    procedure SetToken(const Value: string);
    procedure SetServerURL(const Value: string);
  public
    const ONE_MB_SIZE = 1048577;
    property MaxFileSize: Int64 write SetMaxFileSize;
    constructor Create;
    function FileServer: TFileServer;
    function GenerateToken(const AUserName: string): string;
    property Token: string write SetToken;
    property ServerURL: string write SetServerURL;
    procedure Execute;
    destructor Destroy; override;
  end;

implementation

{ TFileServer }

constructor TFileManager.Create;
begin
  FFileControl := TFrmFileControl.Create(Application.MainForm);
  DMImagens := TDMImagens.Create(Application.MainForm);
end;

destructor TFileManager.Destroy;
begin
  FFileControl.Free;
  DMImagens.Free;
  inherited;
end;

procedure TFileManager.Execute;
begin
  FFileControl.ShowModal;
end;

function TFileManager.FileServer: TFileServer;
begin
  Result := FFileControl.FileServer;
end;

function TFileManager.GenerateToken(const AUserName: string): string;
var
  LToken: TJWT;
begin
  LToken := TJWT.Create;
  try
    LToken.Claims.SetClaimOfType<string>('username', AUserName);
    LToken.Claims.Expiration := IncHour(Now);
    Result := TJOSE.SHA256CompactToken(FILE_SERVER_SECRET_KEY, LToken);
  finally
    LToken.Free;
  end;
end;

procedure TFileManager.SetMaxFileSize(const Value: Int64);
begin
  FFileControl.Controller.MaxFileSize := Value;
end;

procedure TFileManager.SetServerURL(const Value: string);
begin
  FFileControl.Controller.SetServerURL(Value);
  FFileControl.FileServer.Controller.SetServerURL(Value);
end;

procedure TFileManager.SetToken(const Value: string);
begin
  FFileControl.Controller.SetToken(Value);
  FFileControl.FileServer.Controller.SetToken(Value);
end;

end.
