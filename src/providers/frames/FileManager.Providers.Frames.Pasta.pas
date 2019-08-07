unit FileManager.Providers.Frames.Pasta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, dxGDIPlusClasses,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FileManager.Providers.Frames.Base, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, System.UITypes,
  System.JSON, FileManager.Providers.Dialogs.Input, Providers.Helpers.JSON, Providers.Types.CallBack;

type
  TFramePasta = class(TFrameBase)
    imgFolder: TImage;
    lblDataInclusao: TLabel;
    lblFolderSize: TLabel;
    Shape: TShape;
    pnlFolderContentName: TPanel;
    lblFolderName: TLabel;
    imgDelete: TImage;
    pnlEdit: TPanel;
    imgEdit: TImage;
    procedure lblFolderNameMouseLeave(Sender: TObject);
    procedure lblFolderNameMouseEnter(Sender: TObject);
    procedure lblFolderNameClick(Sender: TObject);
    procedure FrameMouseEnter(Sender: TObject);
    procedure FrameMouseLeave(Sender: TObject);
    procedure imgDeleteClick(Sender: TObject);
    procedure imgEditClick(Sender: TObject);
  private
    FFolderData: TJSONObject;
    procedure EnableOptions(const Enabled: Boolean);
  public
    OnOpenFolder: TOpenFolder;
    OnEditFolder: TEditFolder;
    OnDeleteGroup: TDeleteGroup;
    constructor Create(const AOwner: TComponent); reintroduce;
    procedure LoadFolderData(const FolderData: TJSONObject);
    function GetIdFolder: string;
    function GetIdGroupFolder: string;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

{ TFramePasta }

constructor TFramePasta.Create(const AOwner: TComponent);
begin
  inherited Create(AOwner);
  if (AOwner is TWinControl) then
    Self.Parent := TWinControl(AOwner);
  Self.Align := TAlign.alTop;
  OnOpenFolder := OnOpenFolder;
end;

destructor TFramePasta.Destroy;
begin
  if Assigned(FFolderData) then
    FFolderData.Free;
  inherited;
end;

procedure TFramePasta.EnableOptions(const Enabled: Boolean);
begin
  imgEdit.Visible := Enabled;
  imgDelete.Visible := Enabled;
end;

procedure TFramePasta.FrameMouseEnter(Sender: TObject);
begin
  inherited;
  EnableOptions(True);
end;

procedure TFramePasta.FrameMouseLeave(Sender: TObject);
begin
  inherited;
  EnableOptions(False);
end;

function TFramePasta.GetIdFolder: string;
begin
  FFolderData.TryGetValue<string>('COD_PAS', Result);
end;

function TFramePasta.GetIdGroupFolder: string;
begin
  FFolderData.TryGetValue<string>('COD_AGR_PAS', Result);
end;

procedure TFramePasta.imgDeleteClick(Sender: TObject);
begin
  if Assigned(OnDeleteGroup) then
    OnDeleteGroup(GetIdGroupFolder, Self);
end;

procedure TFramePasta.imgEditClick(Sender: TObject);
var
  Descricao: string;
begin
  if TDialogsInput.Show('Informações da Pasta', Descricao, lblFolderName.Caption) then
    if not Descricao.Trim.IsEmpty and not Descricao.Trim.Equals(lblFolderName.Caption) then
    begin
      FFolderData.UpdatePair('DESCR_PAS', Descricao);
      if Assigned(OnEditFolder) then
        OnEditFolder(FFolderData, False,
          procedure(const Response: Boolean)
          begin
            if Response then
              lblFolderName.Caption := Descricao
            else
              FFolderData.UpdatePair('DESCR_PAS', lblFolderName.Caption);
          end);
    end;
end;

procedure TFramePasta.lblFolderNameClick(Sender: TObject);
begin
  if Assigned(OnOpenFolder) then
    OnOpenFolder(GetIdGroupFolder, GetIdFolder, lblFolderName.Caption);
end;

procedure TFramePasta.lblFolderNameMouseEnter(Sender: TObject);
begin
  lblFolderName.Font.Style := lblFolderName.Font.Style + [TFontStyle.fsUnderline];
  if Self.Color <> clSelected then
    Self.Color := clSelected;
  EnableOptions(True);
end;

procedure TFramePasta.lblFolderNameMouseLeave(Sender: TObject);
begin
  lblFolderName.Font.Style := lblFolderName.Font.Style - [TFontStyle.fsUnderline];
  if Self.Color <> clWhite then
    Self.Color := clWhite;
  EnableOptions(False);
end;

procedure TFramePasta.LoadFolderData(const FolderData: TJSONObject);
begin
  FFolderData := FolderData;
  lblFolderName.Caption := FFolderData.GetValue<string>('DESCR_PAS');
  lblDataInclusao.Caption := FormatDateTime('dd/mm/yyyy', FFolderData.GetValue<TDateTime>('DTA_INC_PAS'));
end;

end.
