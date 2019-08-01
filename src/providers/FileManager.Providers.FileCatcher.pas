unit FileManager.Providers.FileCatcher;

interface

uses ShellAPI, Winapi.Windows;

type
  TFileCatcher = class(TObject)
  private
    FDropHandle: HDROP;
    function GetFile(Idx: Integer): string;
    function GetFileCount: Integer;
    function GetPoint: TPoint;
  public
    constructor Create(const DropHandle: HDROP);
    destructor Destroy; override;
    property FileCount: Integer read GetFileCount;
    property Files[Idx: Integer]: string read GetFile;
    property DropPoint: TPoint read GetPoint;
  end;

implementation

{ TFileCatcher }

constructor TFileCatcher.Create(const DropHandle: HDROP);
begin
  inherited Create;
  FDropHandle := DropHandle;
end;

destructor TFileCatcher.Destroy;
begin
  DragFinish(FDropHandle);
  inherited;
end;

function TFileCatcher.GetFile(Idx: Integer): string;
var
  FileNameLength: Integer;
begin
  FileNameLength := DragQueryFile(fDropHandle, Idx, nil, 0);
  SetLength(Result, FileNameLength);
  DragQueryFile(fDropHandle, Idx, PChar(Result), FileNameLength + 1);
end;

function TFileCatcher.GetFileCount: Integer;
begin
  Result := DragQueryFile(fDropHandle, $FFFFFFFF, nil, 0);
end;

function TFileCatcher.GetPoint: TPoint;
begin
  DragQueryPoint(FDropHandle, Result);
end;

end.
