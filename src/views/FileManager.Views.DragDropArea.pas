unit FileManager.Views.DragDropArea;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls, ShellAPI, FileManager.Providers.FileCatcher, Vcl.StdCtrls;

type
  TAddFile = reference to procedure(const FileName: string);
  TFrmDragDropArea = class(TForm)
    imgDragToUpload: TImage;
  protected
    FAddFile: TAddFile;
    FShowFilesToUpload: TProc;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
  public
    constructor Create(const AOwner: TComponent; const AddFile: TAddFile; const ShowFilesToUpload: TProc); reintroduce;
  end;

implementation

{$R *.dfm}

{ TFrmDragDropArea }

constructor TFrmDragDropArea.Create(const AOwner: TComponent; const AddFile: TAddFile; const ShowFilesToUpload: TProc);
begin
  inherited Create(AOwner);
  if (AOwner is TWinControl) then
    Self.Parent := TWinControl(AOwner);
  FAddFile := AddFile;
  FShowFilesToUpload := ShowFilesToUpload;
  Self.Show;
end;

procedure TFrmDragDropArea.CreateWnd;
begin
  inherited;
  DragAcceptFiles(Handle, True);
end;

procedure TFrmDragDropArea.DestroyWnd;
begin
  DragAcceptFiles(Handle, False);
  inherited;
end;

procedure TFrmDragDropArea.WMDropFiles(var Msg: TWMDropFiles);
var
  I: Integer;
  Catcher: TFileCatcher;
begin
  inherited;
  Catcher := TFileCatcher.Create(Msg.Drop);
  try
    for I := 0 to Pred(Catcher.FileCount) do
    begin
      if Assigned(FAddFile) then
        FAddFile(Catcher.Files[I]);
      FShowFilesToUpload;
    end;
  finally
    Catcher.Free;
  end;
  Msg.Result := 0;
end;

end.
