unit FileManager.Providers.Controllers.Base;

interface

uses
  System.SysUtils, System.Classes, FileManager.Providers.Constants, FileManager.Providers.Request, FireDAC.Comp.Client,
  FileManager.Providers.Response.Default, FileManager.Providers.Response.Intf, Winapi.Windows, System.Math;

type
  TFileManagerController = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    Request: TRequest;
    FTempDirectory: string;
    FFileServerURL: string;
  protected
    function GetRequest: TRequest;
    function GetFileServerURL: string;
    function GetTempDirectory: string;
    function FormatFileSize(const FileSize: Int64): string;
  public
    constructor Create(const ServerURL: string); reintroduce;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TFileManagerController.Create(const ServerURL: string);
begin
  inherited Create(nil);
  FFileServerURL := ServerURL;
end;

procedure TFileManagerController.DataModuleCreate(Sender: TObject);
begin
  Request := TRequest.Create(FFileServerURL);
  FTempDirectory := EmptyStr;
end;

procedure TFileManagerController.DataModuleDestroy(Sender: TObject);
begin
  Request.Free;
end;

function TFileManagerController.FormatFileSize(const FileSize: Int64): string;
const
  Description: Array [0 .. 8] of string = ('Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB');
var
  I: Integer;
begin
  I := 0;
  while FileSize > Power(1024, I + 1) do
    Inc(I);
  Result := FormatFloat('###0.##', FileSize / IntPower(1024, I)) + ' ' + Description[I];
end;

function TFileManagerController.GetFileServerURL: string;
begin
 Result := FFileServerURL;
end;

function TFileManagerController.GetRequest: TRequest;
begin
  Result := Request;
end;

function TFileManagerController.GetTempDirectory: string;
var
  TempFolder: array[0..MAX_PATH] of Char;
begin
  if FTempDirectory.Trim.IsEmpty then
  begin
    GetTempPath(MAX_PATH, @TempFolder);
    FTempDirectory := StrPas(TempFolder);
  end;
  Result := FTempDirectory;
end;

end.
