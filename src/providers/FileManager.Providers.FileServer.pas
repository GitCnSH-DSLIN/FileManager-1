unit FileManager.Providers.FileServer;

interface

uses
  Vcl.Controls, Data.DB, FileManager.Providers.Frames.Arquivo, FileManager.Providers.Frames.Pasta, System.StrUtils,
  System.SysUtils, FileManager.Providers.Controllers.FileManager, FileManager.Providers.Response.Handler.Default,
  FileManager.Providers.Response.Intf, Vcl.WinXCtrls, System.Classes, Vcl.StdCtrls, FileManager.Providers.Dialogs.Input,
  FileManager.Providers.Frames.Base, System.Generics.Collections, FileManager.Providers.PathControl, Vcl.ExtCtrls,
  Dialogs4D.Factory, DataSet.Serialize.Helper, System.JSON;

type
  TFileServer = class
  private
    FContent: TWinControl;
    FOwner: TWinControl;
    FFrameCount: Integer;
    FController: TControllerFileManager;
    FPathControl: TPathControl;
    FWait: TActivityIndicator;
    FIdCadastro: string;
    FTabela: string;
    FSistema: string;
    FFatherGroup: string;
    FMainFolderName: string;
    FOrigem: string;
    FPathTree: TLabel;
    FPreviousImage: TImage;
    procedure OnStart(const Response: IResponse);
    procedure Clear;
    procedure OpenFolder(const IdGroup, IdFolder, FolderName: string);
    procedure EditFolder(const FolderData: TJSONObject);
    procedure EditGroup(const GroupData: TJSONObject);
    procedure DeleteGroup(const IdGroup: string; const FrameFolder: TFrameBase);
    procedure DownloadFile(const IdFile: string);
    procedure EditFile(const FileData: TJSONObject);
    procedure DeleteFile(const IdFile: string; const FrameFile: TFrameBase);
    procedure LoadGroup;
    procedure LoadFolders(const DataSet: TDataSet);
    procedure LoadFiles(const DataSet: TDataSet);
    procedure ShowWait(const Animate: Boolean);
    procedure SetFatherGroup(const Value: string);
    procedure SetIdCadastro(const Value: string);
    procedure SetMainFolderName(const Value: string);
    procedure SetOrigem(const Value: string);
    procedure SetSistema(const Value: string);
    procedure SetTabela(const Value: string);
    procedure SetPathTree(const Value: TLabel);
    procedure SetPreviousImage(const Value: TImage);
  public
    property FatherGroup: string read FFatherGroup write SetFatherGroup;
    property MainFolderName: string read FMainFolderName write SetMainFolderName;
    property Origem: string read FOrigem write SetOrigem;
    property Tabela: string read FTabela write SetTabela;
    property Sistema: string read FSistema write SetSistema;
    property IdCadastro: string read FIdCadastro write SetIdCadastro;
    property PathTree: TLabel read FPathTree write SetPathTree;
    property PreviousImage: TImage read FPreviousImage write SetPreviousImage;
    constructor Create(const Content, AOwner: TWinControl);
    procedure Start;
    procedure CreateFolder;
    procedure PreviousFolder;
    procedure RefreshFolder;
    function GetNewFrameName: string;
    function GetCurrentFolderId: string;
    destructor Destroy; override;
  end;

implementation

{ TFileManager }

procedure TFileServer.PreviousFolder;
begin
  if not FPathControl.PreviousGroup.Trim.IsEmpty then
  begin
    ShowWait(True);
    FController.GetGroup(FPathControl.PreviousGroup,
      procedure(const Response: IResponse)
      begin
        if not TResponseHandler.New(FOwner).Handle(Response) then
        begin
          ShowWait(False);
          Exit;
        end;

        FController.GetFolders(
          procedure(const Response: IResponse)
          begin
            if TResponseHandler.New(FOwner).Handle(Response) then
            begin
              Self.Clear;
              FPathTree.Caption :=  StringReplace(FPathTree.Caption, ' > ' +FPathControl.CurrentFolderName, EmptyStr, [rfIgnoreCase]);
              FPathControl.CurrentGroup := FController.mmtAgrupamentoCOD_AGR.AsString;
              FPathControl.CurrentFolder := FController.mmtPastasCOD_PAS.AsString;
              FPathControl.CurrentFolderName := FController.mmtPastasDESCR_PAS.AsString;
              FPathControl.PreviousGroup := FController.mmtAgrupamentoCOD_AGR_AGR.AsString;
              LoadGroup;
            end;
            ShowWait(False);
          end);
      end);
  end;
end;

procedure TFileServer.Clear;
var
  I: Integer;
begin
  for I := Pred(FContent.ControlCount) downto 0 do
    if not (FContent.Controls[I] = FWait) then
      FContent.Controls[I].Destroy;
end;

constructor TFileServer.Create(const Content, AOwner: TWinControl);
begin
  inherited Create;
  FController := TControllerFileManager.Create(AOwner);
  FPathControl := TPathControl.Create;
  FWait := TActivityIndicator.Create(AOwner);
  FWait.Parent := Content;
  FWait.IndicatorSize := TActivityIndicatorSize.aisXLarge;
  FWait.Left := (Content.Width - FWait.Width) div 2;
  FWait.Top := (Content.Height - FWait.Height) div 2;
  ShowWait(False);
  FContent := Content;
  FOwner := AOwner;
  FFrameCount := 0;
  FFatherGroup := EmptyStr;
  FMainFolderName := EmptyStr;
  FOrigem := EmptyStr;
  FTabela := EmptyStr;
  FSistema := EmptyStr;
  FIdCadastro := EmptyStr;
end;

procedure TFileServer.CreateFolder;
var
  Descricao: string;
begin
  if not TDialogsInput.Show('Informações da Pasta', Descricao) then
    Exit;
  if Descricao.Trim.IsEmpty then
    Exit;
  ShowWait(True);
  FController.CreateGroup(FPathControl.CurrentGroup,
    procedure(const Response: IResponse)
    begin
      if not (TResponseHandler.New(FOwner).Handle(Response)) then
      begin
        ShowWait(False);
        Exit;
      end;

      FController.CreateFolder(Descricao,
        procedure(const Response: IResponse)
        begin
          if (TResponseHandler.New(FOwner).Handle(Response)) then
            Self.LoadFolders(FController.mmtPastas);
          ShowWait(False);
        end);
    end);
end;

procedure TFileServer.DeleteFile(const IdFile: string; const FrameFile: TFrameBase);
begin
  FController.DeleteFiles(IdFile,
    procedure(const Response: IResponse)
    begin
      if (TResponseHandler.New(FOwner).Handle(Response)) then
        FrameFile.Destroy;
    end);
end;

procedure TFileServer.DeleteGroup(const IdGroup: string; const FrameFolder: TFrameBase);
begin
  if TDialogs.Confirm('Deseja realmente excluir essa pasta?' + sLineBreak + sLineBreak + 'Ao excluir todos os arquivos contidos nela serão excluídos também!') then
    FController.DeleteGroup(IdGroup,
      procedure(const Response: IResponse)
      begin
        if (TResponseHandler.New(FOwner).Handle(Response)) then
          FrameFolder.Destroy;
      end);
end;

destructor TFileServer.Destroy;
begin
  FController.Free;
  FPathControl.Free;
  FWait.Free;
  inherited;
end;

function TFileServer.GetCurrentFolderId: string;
begin
  Result := FPathControl.CurrentFolder;
end;

function TFileServer.GetNewFrameName: string;
begin
  Inc(FFrameCount);
  Result := Format('Frame_%d', [FFrameCount]);
end;

procedure TFileServer.OnStart(const Response: IResponse);
begin
  if TResponseHandler.New(FOwner).Handle(Response) then
  begin
    ShowWait(True);
    FController.GetAgrupamentoByCadastro(
      procedure(const Response: IResponse)
      begin
        if not TResponseHandler.New(FOwner).Handle(Response) then
        begin
          ShowWait(False);
          Exit;
        end;

        if not(FFatherGroup.Trim.IsEmpty) and not(FController.mmtAgrupamentoCOD_AGR_AGR.AsString.Equals(FFatherGroup)) then
        begin
          FController.mmtAgrupamento.Edit;
          FController.mmtAgrupamentoCOD_AGR_AGR.AsString := FFatherGroup;
          FController.mmtAgrupamento.Post;
          EditGroup(FController.mmtAgrupamento.ToJSONObject);
        end;

        FController.GetFolders(
          procedure(const Response: IResponse)
          begin
            if FController.mmtAgrupamentoRAIZ_AGR.AsString.Equals('S') then
              if not(FMainFolderName.Trim.IsEmpty) and not(FController.mmtPastasDESCR_PAS.AsString.Equals(FMainFolderName)) then
              begin
                FController.mmtPastas.Edit;
                FController.mmtPastasDESCR_PAS.AsString := FMainFolderName;
                FController.mmtPastas.Post;
                EditFolder(FController.mmtPastas.ToJSONObject);
              end;

            if TResponseHandler.New(FOwner).Handle(Response)  then
              OpenFolder(FController.mmtAgrupamentoCOD_AGR.AsString, FController.mmtPastasCOD_PAS.AsString, 'Arquivos');
            ShowWait(False);
          end);
      end);
  end;
end;

procedure TFileServer.LoadFiles(const DataSet: TDataSet);
var
  FrameArquivo: TFrameArquivo;
begin
  if not DataSet.Active or DataSet.IsEmpty then
    Exit;
  DataSet.First;
  while not DataSet.Eof do
  begin
    FrameArquivo := TFrameArquivo.Create(FContent);
    FrameArquivo.LoadFileData(DataSet.ToJSONObject);
    FrameArquivo.OnDownloadFile := DownloadFile;
    FrameArquivo.OnEditFile := EditFile;
    FrameArquivo.OnDeleteFile := DeleteFile;
    FrameArquivo.Name := GetNewFrameName;
    DataSet.Next;
  end;
end;

procedure TFileServer.LoadFolders(const DataSet: TDataSet);
var
  FramePasta: TFramePasta;
begin
  if not DataSet.Active or DataSet.IsEmpty then
    Exit;
  DataSet.First;
  while not DataSet.Eof do
  begin
    FramePasta := TFramePasta.Create(FContent);
    FramePasta.LoadFolderData(DataSet.ToJSONObject);
    FramePasta.OnOpenFolder := OpenFolder;
    FramePasta.OnEditFolder := EditFolder;
    FramePasta.OnDeleteGroup := DeleteGroup;
    FramePasta.Name := GetNewFrameName;
    DataSet.Next;
  end;
end;

procedure TFileServer.LoadGroup;
begin
  FPreviousImage.Visible := not(FPathControl.PreviousGroup.Trim.IsEmpty);
  ShowWait(True);
  FController.GetSubFolders(FPathControl.CurrentGroup,
    procedure(const Response: IResponse)
    begin
      if not (TResponseHandler.New(FOwner).Handle(Response)) then
      begin
        ShowWait(False);
        Exit;
      end;

      Self.LoadFolders(FController.mmtPastas);
      FController.GetFiles(FPathControl.CurrentFolder,
        procedure(const Response: IResponse)
        begin
          if (TResponseHandler.New(FOwner).Handle(Response)) then
            Self.LoadFiles(FController.mmtArquivos);
          ShowWait(False);
        end);
    end);
end;

procedure TFileServer.DownloadFile(const IdFile: string);
begin
  FController.DownloadFile(IdFile,
    procedure(const Response: IResponse)
    begin
      TResponseHandler.New(FOwner).Handle(Response);
    end);
end;

procedure TFileServer.EditFile(const FileData: TJSONObject);
begin
  FController.EditFile(FileData,
    procedure(const Response: IResponse)
    begin
      TResponseHandler.New(FOwner).Handle(Response);
    end);
end;

procedure TFileServer.EditFolder(const FolderData: TJSONObject);
begin
  FController.EditFolder(FolderData,
    procedure(const Response: IResponse)
    begin
      TResponseHandler.New(FOwner).Handle(Response);
    end);
end;

procedure TFileServer.EditGroup(const GroupData: TJSONObject);
begin
  FController.EditGroup(GroupData,
    procedure(const Response: IResponse)
    begin
      TResponseHandler.New(FOwner).Handle(Response);
    end);
end;

procedure TFileServer.OpenFolder(const IdGroup, IdFolder, FolderName: string);
begin
  FPathControl.CurrentGroup := IdGroup;
  FPathControl.CurrentFolder := IdFolder;
  FPathControl.CurrentFolderName := FolderName;
  FPathTree.Caption := IfThen(Trim(FPathTree.Caption).IsEmpty, FolderName, Format('%s > %s', [FPathTree.Caption, FolderName]));
  LoadGroup;
  Self.Clear;
end;

procedure TFileServer.RefreshFolder;
begin
  Self.Clear;
  LoadGroup;
end;

procedure TFileServer.SetFatherGroup(const Value: string);
begin
  FFatherGroup := Value;
end;

procedure TFileServer.SetIdCadastro(const Value: string);
begin
  FIdCadastro := Value;
end;

procedure TFileServer.SetMainFolderName(const Value: string);
begin
  FMainFolderName := Value;
end;

procedure TFileServer.SetOrigem(const Value: string);
begin
  FOrigem := Value;
end;

procedure TFileServer.SetPathTree(const Value: TLabel);
begin
  FPathTree := Value;
  FPathTree.Caption := EmptyStr;
end;

procedure TFileServer.SetPreviousImage(const Value: TImage);
begin
  FPreviousImage := Value;
end;

procedure TFileServer.SetSistema(const Value: string);
begin
  FSistema := Value;
end;

procedure TFileServer.SetTabela(const Value: string);
begin
  FTabela := Value;
end;

procedure TFileServer.ShowWait(const Animate: Boolean);
begin
  FWait.Animate := Animate;
  FWait.Visible := Animate;
end;

procedure TFileServer.Start;
begin
  FPreviousImage.Visible := False;
  if FIdCadastro.Trim.IsEmpty then
    FController.CreateCadastro(FOrigem, FTabela, FSistema, OnStart)
  else
    FController.GetCadastro(FIdCadastro, OnStart);
end;

end.
