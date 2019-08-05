unit FileManager.Providers.Controllers.Base;

interface

uses
  System.SysUtils, System.Classes, FileManager.Providers.Constants, FileManager.Providers.Request, FireDAC.Comp.Client,
  FileManager.Providers.Response.Default, FileManager.Providers.Response.Intf, Winapi.Windows, System.Math;

type
  TFileManagerController = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    FTempDirectory: string;
    FServerURL: string;
    FToken: string;
  protected
    function GetServerURL: string;
    function GetTempDirectory: string;
    function GetToken: string;
    function FormatFileSize(const FileSize: Int64): string;
  public
    procedure SetToken(const Vaue: string);
    procedure SetServerURL(const Value: string);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TFileManagerController.DataModuleCreate(Sender: TObject);
begin
  FServerURL := EmptyStr;
  FTempDirectory := EmptyStr;
  FToken := EmptyStr;
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

function TFileManagerController.GetServerURL: string;
begin
 Result := FServerURL;
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

function TFileManagerController.GetToken: string;
begin
  Result := FToken;
end;

procedure TFileManagerController.SetServerURL(const Value: string);
begin
  FServerURL := Value;
end;

procedure TFileManagerController.SetToken(const Vaue: string);
begin
  FToken := Vaue;
end;

end.
