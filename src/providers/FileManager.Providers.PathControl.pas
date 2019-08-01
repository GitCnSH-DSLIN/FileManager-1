unit FileManager.Providers.PathControl;

interface

uses System.SysUtils, System.StrUtils;

type
  TPathControl = class
  private
    FCurrentGroup: string;
    FCurrentFolder: string;
    FPreviousGroup: string;
    FCurrentFolderName: string;
    procedure SetCurrentFolder(const Value: string);
    procedure SetCurrentGroup(const Value: string);
    procedure SetPreviousGroup(const Value: string);
    procedure SetCurrentFolderName(const Value: string);
  public
    property CurrentGroup: string read FCurrentGroup write SetCurrentGroup;
    property CurrentFolder: string read FCurrentFolder write SetCurrentFolder;
    property CurrentFolderName: string read FCurrentFolderName write SetCurrentFolderName;
    property PreviousGroup: string read FPreviousGroup write SetPreviousGroup;
    constructor Create;

  end;

implementation

{ TPathControl }

constructor TPathControl.Create;
begin
  FCurrentGroup := EmptyStr;
  FCurrentFolder := EmptyStr;
  FPreviousGroup := EmptyStr;
end;

procedure TPathControl.SetCurrentFolder(const Value: string);
begin
  FCurrentFolder := Value;
end;

procedure TPathControl.SetCurrentFolderName(const Value: string);
begin
  FCurrentFolderName := Value;
end;

procedure TPathControl.SetCurrentGroup(const Value: string);
begin
  FPreviousGroup := FCurrentGroup;
  FCurrentGroup := Value;
end;

procedure TPathControl.SetPreviousGroup(const Value: string);
begin
  FPreviousGroup := Value;
end;

end.
