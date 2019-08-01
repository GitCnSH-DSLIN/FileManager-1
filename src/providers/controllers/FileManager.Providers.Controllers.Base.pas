unit FileManager.Providers.Controllers.Base;

interface

uses
  System.SysUtils, System.Classes, FileManager.Providers.Constants, FileManager.Providers.Request, FireDAC.Comp.Client,
  FileManager.Providers.Response.Default, FileManager.Providers.Response.Intf, Winapi.Windows, System.Math;

type
  TDMBase = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    Request: TRequest;
    FTempDirectory: string;
  protected
    function GetRequest: TRequest;
    function GetTempDirectory: string;
    function FormatFileSize(const FileSize: Int64): string;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMBase.DataModuleCreate(Sender: TObject);
begin
  Request := TRequest.Create(URL_SERVIDOR_ARQUIVOS);
  FTempDirectory := EmptyStr;
end;

procedure TDMBase.DataModuleDestroy(Sender: TObject);
begin
  Request.Free;
end;

function TDMBase.FormatFileSize(const FileSize: Int64): string;
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

function TDMBase.GetRequest: TRequest;
begin
  Result := Request;
end;

function TDMBase.GetTempDirectory: string;
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
