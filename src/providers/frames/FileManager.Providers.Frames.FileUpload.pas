unit FileManager.Providers.Frames.FileUpload;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, FileManager.Providers.Response.Intf,
  System.JSON, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Registry, Vcl.BaseImageCollection, Vcl.ImageCollection, FileManager.Providers.Types.TipoArquivo, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  cxImageList, cxGraphics, cxClasses, System.IOUtils, System.Math, FileManager.Providers.ObserverFile.Intf,
  FileManager.Providers.Response.Handler.Default, Vcl.WinXCtrls, FileManager.Providers.Dialogs.Input, IdCustomHTTPServer,
  FileManager.Providers.Modulos.Imagens, FileManager.Providers.Frames.Base;

type
  TFrameFileUpload = class(TFrameBase)
    imgFileKind: TImage;
    lblFileName: TLabel;
    imgRemoveFile: TImage;
    Shape: TShape;
    ActivityIndicator: TActivityIndicator;
    imgOK: TImage;
    imgEdit: TImage;
    lblFileSize: TLabel;
    lblErrorMessage: TLabel;
    procedure imgRemoveFileClick(Sender: TObject);
    procedure imgEditClick(Sender: TObject);
  private
    FFileData: TJSONObject;
    FFilePath: string;
    procedure ShowActivityIndicator(const Animate: Boolean);
  public
    ObserverFile: IObserverFile;
    procedure LoadFileData(const FilePath, IdFolder: string);
    function GetFileData: TJSONObject;
    function GetFilePath: string;
    procedure StartUpload;
    procedure EndUpload(const Send: Boolean);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

constructor TFrameFileUpload.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if (AOwner is TWinControl) then
    Self.Parent := TWinControl(AOwner);
  Self.Align := TAlign.alTop;
  FFileData := TJSONObject.Create;
  ShowActivityIndicator(False);
  imgOK.Visible := False;
  lblErrorMessage.Caption := EmptyStr;
end;

destructor TFrameFileUpload.Destroy;
begin
  if Assigned(FFileData) then
    FFileData.Free;
  inherited;
end;

procedure TFrameFileUpload.EndUpload(const Send: Boolean);
begin
  ShowActivityIndicator(False);
  imgOK.Visible := Send;
  imgRemoveFile.Visible := not(Send);
  if Send then
    TThread.CreateAnonymousThread(
      procedure
      begin
        Sleep(500);
        TThread.Synchronize(nil,
          procedure
          begin
            ObserverFile.RemoveFileItem(Self);
          end);
      end).Start;
end;

function TFrameFileUpload.GetFileData: TJSONObject;
begin
  Result := FFileData;
end;

function TFrameFileUpload.GetFilePath: string;
begin
  Result := FFilePath;
end;

procedure TFrameFileUpload.imgEditClick(Sender: TObject);
var
  Descricao: string;
begin
  if TDialogsInput.Show('Informações do Arquivo', Descricao, FFileData.GetValue<string>('DESCRICAO_ARQ')) then
    if not Descricao.Trim.IsEmpty then
    begin
      FFileData.RemovePair('DESCRICAO_ARQ');
      FFileData.AddPair('DESCRICAO_ARQ', Descricao);
      lblFileName.Caption := Descricao;
    end;
end;

procedure TFrameFileUpload.imgRemoveFileClick(Sender: TObject);
begin
  ObserverFile.RemoveFileItem(Self);
end;

procedure TFrameFileUpload.LoadFileData(const FilePath, IdFolder: string);
begin
  lblFileName.Caption := StringReplace(ExtractFileName(FilePath), ExtractFileExt(FilePath), EmptyStr, [rfIgnoreCase, rfReplaceAll]);
  lblFileSize.Caption := FormatFileSize(GetFileSize(FilePath));
  imgFileKind.Picture := DMImagens.cxImageCollection.Items.Items[StrToTipoDocumento(ExtractFileExt(FilePath)).GetImageIndex].Picture;
  FFilePath := FilePath;
  TThread.CreateAnonymousThread(
    procedure
    begin
      FFileData.AddPair('CONTENT_TYPE_ARQ', GetFileMIMEType(FilePath));
      FFileData.AddPair('NOME_ARQ', ExtractFileName(FilePath));
      FFileData.AddPair('DESCRICAO_ARQ', lblFileName.Caption);
      FFileData.AddPair('TAMANHO_ARQ', TJSONNumber.Create(GetFileSize(FilePath)));
      FFileData.AddPair('COD_PAS_ARQ', IdFolder);
    end).Start;
end;

procedure TFrameFileUpload.ShowActivityIndicator(const Animate: Boolean);
begin
  ActivityIndicator.Animate := Animate;
  ActivityIndicator.Visible := Animate;
end;

procedure TFrameFileUpload.StartUpload;
begin
  imgRemoveFile.Visible := False;
  lblErrorMessage.Caption := EmptyStr;
  ShowActivityIndicator(True);
end;

end.
