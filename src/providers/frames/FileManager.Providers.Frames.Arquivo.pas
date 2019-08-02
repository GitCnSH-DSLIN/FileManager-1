unit FileManager.Providers.Frames.Arquivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, dxGDIPlusClasses, cxClasses, cxGraphics, FileManager.Providers.Modulos.Imagens,
  FileManager.Providers.Types.TipoArquivo, Data.DB, FileManager.Providers.Response.Handler.Default,
  FileManager.Providers.Response.Intf, System.UITypes, System.JSON, FileManager.Providers.Dialogs.Input,
  FileManager.Providers.Frames.Base;

type
  TDownloadFile = reference to procedure(const IdFile: string);
  TEditFile = reference to procedure(const FolderData: TJSONObject);
  TDeleteFile = reference to procedure(const IdFile: string; const FrameFile: TFrameBase);
  TFrameArquivo = class(TFrameBase)
    imgFileKind: TImage;
    Shape: TShape;
    lblFileSize: TLabel;
    lblDataInclusao: TLabel;
    pnlFileContentName: TPanel;
    lblFileName: TLabel;
    pnlEdit: TPanel;
    imgEdit: TImage;
    imgDelete: TImage;
    procedure lblFileNameMouseEnter(Sender: TObject);
    procedure lblFileNameMouseLeave(Sender: TObject);
    procedure lblFileNameClick(Sender: TObject);
    procedure FrameMouseEnter(Sender: TObject);
    procedure FrameMouseLeave(Sender: TObject);
    procedure imgDeleteClick(Sender: TObject);
    procedure imgEditClick(Sender: TObject);
  private
    FFileData: TJSONObject;
    procedure EnableOptions(const Enabled: Boolean);
  public
    OnDownloadFile: TDownloadFile;
    OnEditFile: TEditFile;
    OnDeleteFile: TDeleteFile;
    constructor Create(const AOwner: TComponent); reintroduce;
    procedure LoadFileData(const FileData: TJSONObject);
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

{ TFrameFileListItem }

constructor TFrameArquivo.Create(const AOwner: TComponent);
begin
  inherited Create(AOwner);
  if (AOwner is TWinControl) then
    Self.Parent := TWinControl(AOwner);
  Self.Align := TAlign.alTop;
end;

destructor TFrameArquivo.Destroy;
begin
  if Assigned(FFileData) then
    FFileData.Free;
  inherited;
end;

procedure TFrameArquivo.EnableOptions(const Enabled: Boolean);
begin
  imgEdit.Visible := Enabled;
  imgDelete.Visible := Enabled;
end;

procedure TFrameArquivo.FrameMouseEnter(Sender: TObject);
begin
  inherited;
  EnableOptions(True);
end;

procedure TFrameArquivo.FrameMouseLeave(Sender: TObject);
begin
  inherited;
  EnableOptions(False);
end;

procedure TFrameArquivo.imgDeleteClick(Sender: TObject);
begin
  if Assigned(OnDeleteFile) then
    OnDeleteFile(FFileData.GetValue<string>('COD_ARQ'), Self);
end;

procedure TFrameArquivo.imgEditClick(Sender: TObject);
var
  Descricao: string;
begin
  if TDialogsInput.Show('Informações do Arquivo', Descricao, lblFileName.Caption) then
    if not Descricao.Trim.IsEmpty then
    begin
      lblFileName.Caption := Descricao;
      FFileData.RemovePair('DESCRICAO_ARQ');
      FFileData.AddPair('DESCRICAO_ARQ', Descricao);
      if Assigned(OnEditFile) then
        OnEditFile(FFileData);
    end;
end;

procedure TFrameArquivo.lblFileNameClick(Sender: TObject);
begin
  if Assigned(OnDownloadFile) then
    OnDownloadFile(FFileData.GetValue<string>('COD_ARQ'));
end;

procedure TFrameArquivo.lblFileNameMouseEnter(Sender: TObject);
begin
  lblFileName.Font.Style := lblFileName.Font.Style + [TFontStyle.fsUnderline];
  if Self.Color <> clSelected then
    Self.Color := clSelected;
  EnableOptions(True);
end;

procedure TFrameArquivo.lblFileNameMouseLeave(Sender: TObject);
begin
  lblFileName.Font.Style := lblFileName.Font.Style - [TFontStyle.fsUnderline];
  if Self.Color <> clWhite then
    Self.Color := clWhite;
  EnableOptions(False);
end;

procedure TFrameArquivo.LoadFileData(const FileData: TJSONObject);
begin
  FFileData := FileData;
  lblFileName.Caption := FFileData.GetValue<string>('DESCRICAO_ARQ');
  lblFileSize.Caption := FormatFileSize(FFileData.GetValue<Int64>('TAMANHO_ARQ'));
  lblDataInclusao.Caption := FormatDateTime('dd/mm/yyyy', FFileData.GetValue<TDateTime>('DTA_INC_ARQ'));
  imgFileKind.Picture := DMImagens.cxImageCollection.Items.Items[StrToTipoDocumento(ExtractFileExt(FFileData.GetValue<string>('NOME_ARQ'))).GetImageIndex].Picture;
end;

end.
