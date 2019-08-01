unit FileManager.Providers.Frames.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.IOUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Math, IdCustomHTTPServer;

type
  TFrameBase = class(TFrame)
    procedure FrameMouseEnter(Sender: TObject);
    procedure FrameMouseLeave(Sender: TObject);
  protected
    const clSelected = $00F1F2F3;
    function GetFileSize(const FilePath: string): Int64;
    function GetFileMIMEType(const FilePath: string): string;
    function FormatFileSize(const FileSize: Int64): string;
  end;

implementation

{$R *.dfm}

{ TFrameBase }

function TFrameBase.FormatFileSize(const FileSize: Int64): string;
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

procedure TFrameBase.FrameMouseEnter(Sender: TObject);
begin
  if Self.Color <> clSelected then
    Self.Color := clSelected;
end;

procedure TFrameBase.FrameMouseLeave(Sender: TObject);
begin
  if Self.Color <> clWhite then
    Self.Color := clWhite;
end;

function TFrameBase.GetFileMIMEType(const FilePath: string): string;
var
  MIMETable: TIdThreadSafeMimeTable;
begin
  MIMETable := TIdThreadSafeMimeTable.Create(True);
  try
    Result := MIMETable.GetFileMIMEType(FilePath);
  finally
    MIMETable.Free;
  end
end;

function TFrameBase.GetFileSize(const FilePath: string): Int64;
var
  Reader: TFileStream;
begin
  Reader := TFile.OpenRead(FilePath);
  try
    Result := Reader.Size;
  finally
    Reader.Free;
  end;
end;

end.
