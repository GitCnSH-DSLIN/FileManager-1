unit FileManager.Views.FileControl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, FileManager.Providers.Frames.FileUpload, Vcl.ComCtrls,
  FileManager.Providers.ObserverFile.Intf, FileManager.Controllers.FileControl, dxGDIPlusClasses, System.Generics.Collections,
  FileManager.Providers.Response.Handler.Default, FileManager.Providers.Response.Intf, VCL.BlockUI, VCL.BlockUI.Intf,
  FileManager.Providers.Aguarde.Impl, Vcl.WinXCtrls, Dialogs4D.Factory, FileManager.Views.DragDropArea,
  FileManager.Providers.Frames.Base, Vcl.WinXPanels, FileManager.Providers.FileServer;

type
  TFrmFileControl = class(TForm, IObserverFile)
    OpenDialog: TFileOpenDialog;
    pclFileControl: TPageControl;
    tabFilesList: TTabSheet;
    tabUploadFiles: TTabSheet;
    pnlHeaderUpload: TPanel;
    lblTitleUpload: TLabel;
    ShapeUpload: TShape;
    pnlFiles: TPanel;
    pnlContentFiles: TPanel;
    pnlDragToUpload: TPanel;
    imgBack: TImage;
    lblZeroFiles: TLabel;
    pnlFooterUpload: TPanel;
    btnAnexar: TButton;
    btnEnviar: TButton;
    pnlHeaderList: TPanel;
    lblTitleList: TLabel;
    ShapeList: TShape;
    imgClose: TImage;
    pnlFooterList: TPanel;
    btnUpload: TButton;
    pnlFileListContent: TPanel;
    pnlFileList: TPanel;
    pnlHeaderFileList: TPanel;
    lblDescricao: TLabel;
    lblFileSize: TLabel;
    lblDataInclusao: TLabel;
    ShapeFileListHeader: TShape;
    lblFileKind: TLabel;
    btnNovaPasta: TButton;
    lblCurrentPath: TLabel;
    imgPreviousFolder: TImage;
    lblCurrentPath2: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure imgBackClick(Sender: TObject);
    procedure btnAnexarClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure imgCloseClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure btnNovaPastaClick(Sender: TObject);
    procedure imgPreviousFolderClick(Sender: TObject);
    procedure tabUploadFilesShow(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FilesList: TObjectList<TFrameFileUpload>;
    FBlockUI: IBlockUI;
    FDragDropArea: TFrmDragDropArea;
    FRefreshFolder: Boolean;
    procedure RemoveFileItem(const FileFrame: TFrame);
    procedure AddFileItem(const FilePath: string);
  public
    Controller: TControllerFileControl;
    FileServer: TFileServer;
  end;

implementation

{$R *.dfm}

procedure TFrmFileControl.AddFileItem(const FilePath: string);
var
  FileItem: TFrameFileUpload;
begin
  lblZeroFiles.Visible := False;
  FileItem := TFrameFileUpload.Create(pnlContentFiles);
  FileItem.Name := FileServer.GetNewFrameName;
  FileItem.LoadFileData(FilePath, FileServer.GetCurrentFolderId);
  FileItem.ObserverFile := Self;
  FilesList.Add(FileItem);
  OpenDialog.DefaultFolder := ExtractFilePath(FilePath);
end;

procedure TFrmFileControl.btnAnexarClick(Sender: TObject);
var
  I: Integer;
begin
  if OpenDialog.Execute then
    for I := 0 to Pred(OpenDialog.Files.Count) do
      AddFileItem(OpenDialog.Files[I]);
end;

procedure TFrmFileControl.btnEnviarClick(Sender: TObject);
var
  FrameFileItem: TFrameFileUpload;
begin
  if (FilesList.Count = 0) then
  begin
    TDialogs.Warning('Não existe nenhum anexo para enviar');
    Exit;
  end;
  for FrameFileItem in FilesList do
  begin
    FrameFileItem.StartUpload;
    Controller.UploadArquivo(FrameFileItem,
      procedure(const Response: IResponse; const FileItem: TFrameFileUpload)
      begin
        FileItem.EndUpload(Response.Success);
        if Response.Error then
          FileItem.lblErrorMessage.Caption := Response.GetErrorMessage
        else
          FRefreshFolder := True;
      end);
  end;
end;

procedure TFrmFileControl.btnUploadClick(Sender: TObject);
begin
  pclFileControl.ActivePage := tabUploadFiles;
end;

procedure TFrmFileControl.btnNovaPastaClick(Sender: TObject);
begin
  FileServer.CreateFolder;
end;

procedure TFrmFileControl.FormCreate(Sender: TObject);
begin
  FBlockUI := TBlockUI.Create(TWinControl(Self.Owner));
  FDragDropArea := TFrmDragDropArea.Create(pnlDragToUpload, AddFileItem);
  FilesList :=  TObjectList<TFrameFileUpload>.Create;
  Controller := TControllerFileControl.Create(Self);
  FileServer := TFileServer.Create(pnlFileList, Self);
  FileServer.PathTree := lblCurrentPath;
  FileServer.PreviousImage := imgPreviousFolder;
  FRefreshFolder := False;
  pclFileControl.ActivePage := tabFilesList;
end;

procedure TFrmFileControl.FormDestroy(Sender: TObject);
begin
  FBlockUI := nil;
  Controller.Free;
  FDragDropArea.Free;
  FilesList.Free;
  FileServer.Free;
end;

procedure TFrmFileControl.FormShow(Sender: TObject);
begin
  FileServer.Start;
end;

procedure TFrmFileControl.imgBackClick(Sender: TObject);
begin
  pclFileControl.ActivePage := tabFilesList;
  if FRefreshFolder then
  begin
    FileServer.RefreshFolder;
    FRefreshFolder := False;
  end;
end;

procedure TFrmFileControl.imgPreviousFolderClick(Sender: TObject);
begin
  FileServer.PreviousFolder;
end;

procedure TFrmFileControl.imgCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmFileControl.RemoveFileItem(const FileFrame: TFrame);
begin
  FilesList.Remove(TFrameFileUpload(FileFrame));
  lblZeroFiles.Visible := (FilesList.Count = 0);
end;

procedure TFrmFileControl.tabUploadFilesShow(Sender: TObject);
begin
  lblCurrentPath2.Caption := lblCurrentPath.Caption;
end;

end.
