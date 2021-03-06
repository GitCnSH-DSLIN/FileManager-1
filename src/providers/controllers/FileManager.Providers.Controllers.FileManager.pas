unit FileManager.Providers.Controllers.FileManager;

interface

uses
  System.SysUtils, System.Classes, FileManager.Providers.Controllers.Base, System.Math, System.IOUtils,
  FileManager.Providers.Aguarde.Impl, REST.Types,FileManager. Providers.Response.Default, FileManager.Providers.Response.Intf,
  FireDAC.Stan.Intf, System.JSON, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DataSet.Serialize.Helper, FileManager.Providers.Constants,
  FileManager.Providers.Request, IdHTTP, Winapi.ShellAPI, Winapi.Windows, Vcl.Forms, Providers.Types.CallBack;

type
  TControllerFileManager = class(TFileManagerController)
    mmtPastas: TFDMemTable;
    mmtPastasCOD_PAS: TLargeintField;
    mmtPastasCOD_AGR_PAS: TLargeintField;
    mmtPastasDESCR_PAS: TStringField;
    mmtPastasLOGIN_INC_PAS: TStringField;
    mmtPastasDTA_INC_PAS: TDateTimeField;
    mmtPastasLOGIN_ALT_PAS: TStringField;
    mmtPastasDTA_ALT_PAS: TDateTimeField;
    mmtAgrupamento: TFDMemTable;
    mmtAgrupamentoCOD_AGR: TLargeintField;
    mmtAgrupamentoRAIZ_AGR: TStringField;
    mmtAgrupamentoCOD_AGR_AGR: TLargeintField;
    mmtAgrupamentoLOGIN_INC_AGR: TStringField;
    mmtAgrupamentoDTA_INC_AGR: TDateTimeField;
    mmtAgrupamentoLOGIN_ALT_AGR: TStringField;
    mmtAgrupamentoDTA_ALT_AGR: TDateTimeField;
    mmtArquivos: TFDMemTable;
    mmtArquivosCOD_ARQ: TLargeintField;
    mmtArquivosCOD_PAS_ARQ: TLargeintField;
    mmtArquivosCONTENT_TYPE_ARQ: TStringField;
    mmtArquivosCAMINHO_ARQ: TStringField;
    mmtArquivosNOME_ARQ: TStringField;
    mmtArquivosDESCRICAO_ARQ: TStringField;
    mmtArquivosTAMANHO_ARQ: TIntegerField;
    mmtArquivosLOGIN_INC_ARQ: TStringField;
    mmtArquivosDTA_INC_ARQ: TSQLTimeStampField;
    mmtArquivosLOGIN_ALT_ARQ: TStringField;
    mmtArquivosDTA_ALT_ARQ: TSQLTimeStampField;
    mmtCadastro: TFDMemTable;
    mmtAgrupamentoCOD_CAD_AGR: TIntegerField;
    mmtCadastroCOD_CAD: TLargeintField;
    mmtCadastroORIGEM_CAD: TStringField;
    mmtCadastroTABELA_CAD: TStringField;
    mmtCadastroSISTEMA_CAD: TStringField;
    mmtCadastroLOGIN_INC_CAD: TStringField;
    mmtCadastroDTA_INC_CAD: TSQLTimeStampField;
    mmtCadastroLOGIN_ALT_CAD: TStringField;
    mmtCadastroDTA_ALT_CAD: TSQLTimeStampField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    TempFiles: TStringList;
  public
    procedure CreateCadastro(const IdOrigin, TableName, SystemName: string; const CallBack: TResponseCallBack);
    procedure CreateGroup(const IdAgrupamentoPai: string; const CallBack: TResponseCallBack);
    procedure CreateFolder(const FolderName: string; const CallBack: TResponseCallBack);
    procedure EditGroup(const GroupData: TJSONObject; const CallBack: TResponseCallBack);
    procedure EditFolder(const FolderData: TJSONObject; const AOwns: Boolean; const CallBack: TResponseCallBack);
    procedure EditFile(const FileData: TJSONObject; const CallBack: TResponseCallBack);
    procedure GetCadastro(const Codigo: string; const CallBack: TResponseCallBack);
    procedure GetGroup(const IdGroup: string; const CallBack: TResponseCallBack);
    procedure GetAgrupamentoByCadastro(const CallBack: TResponseCallBack);
    procedure GetFolders(const CallBack: TResponseCallBack);
    procedure GetSubFolders(const IdGroup: string; const CallBack: TResponseCallBack);
    procedure GetFiles(const IdFolder: string; const CallBack: TResponseCallBack);
    procedure DownloadFile(const IdFile: string; const CallBack: TResponseCallBack);
    procedure DeleteFiles(const IdFile: string; const CallBack: TResponseCallBack);
    procedure DeleteGroup(const IdGroup: string; const CallBack: TResponseCallBack);
    function GroupExists(const IdGroup: string): Boolean;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TControllerFileItem }

procedure TControllerFileManager.CreateGroup(const IdAgrupamentoPai: string; const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create
    .SetShowScreen(False)
    .SetMainProcess(
      procedure
      var
        Request: TRequest;
      begin
        Request := TRequest.Create(GetServerURL, GetToken);
        try
          mmtAgrupamento.Table.Clear;
          mmtAgrupamento.Append;
          mmtAgrupamentoCOD_CAD_AGR.AsString := mmtCadastroCOD_CAD.AsString;
          mmtAgrupamentoCOD_AGR_AGR.AsString := IdAgrupamentoPai;
          mmtAgrupamento.Post;
          Request.SetResource('Agrupamento').AddBody(mmtAgrupamento.ToJSONObject).POST(Response);
        finally
          if Request.ProcessResponse(Response) then
            mmtAgrupamento.MergeFromJSONObject(Request.Response.JSONValue.GetValue<TJSONObject>, False);
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

procedure TControllerFileManager.CreateCadastro(const IdOrigin, TableName, SystemName: string; const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create
    .SetShowScreen(False)
    .SetMainProcess(
      procedure
      var
        Request: TRequest;
      begin
        Request := TRequest.Create(GetServerURL, GetToken);
        try
          mmtCadastro.Table.Clear;
          mmtCadastro.Append;
          mmtCadastroORIGEM_CAD.AsString := IdOrigin;
          mmtCadastroTABELA_CAD.AsString := TableName;
          mmtCadastroSISTEMA_CAD.AsString := SystemName;
          mmtCadastro.Post;
          Request.SetResource('Cadastro').AddBody(mmtCadastro.ToJSONObject).POST(Response);
        finally
          if Request.ProcessResponse(Response) then
            mmtCadastro.MergeFromJSONObject(Request.Response.JSONValue.GetValue<TJSONObject>, False);
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

procedure TControllerFileManager.CreateFolder(const FolderName: string; const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create
    .SetShowScreen(False)
    .SetMainProcess(
      procedure
      var
        Request: TRequest;
      begin
        Request := TRequest.Create(GetServerURL, GetToken);
        try
          mmtPastas.Table.Clear;
          mmtPastas.Append;
          mmtPastasCOD_AGR_PAS.AsString := mmtAgrupamentoCOD_AGR.AsString;
          mmtPastasDESCR_PAS.AsString := FolderName;
          mmtPastas.Post;
          Request.SetResource('Pasta').AddBody(mmtPastas.ToJSONObject).POST(Response);
        finally
          if Request.ProcessResponse(Response) then
            mmtPastas.MergeFromJSONObject(Request.Response.JSONValue.GetValue<TJSONObject>, False);
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

procedure TControllerFileManager.DataModuleCreate(Sender: TObject);
begin
  inherited;
  mmtCadastro.Open;
  mmtAgrupamento.Open;
  mmtPastas.Open;
  mmtArquivos.Open;
  mmtPastas.Open;
end;

procedure TControllerFileManager.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(TempFiles) then
    TThread.CreateAnonymousThread(
      procedure
      var
        I: Integer;
      begin
        for I := 0 to Pred(TempFiles.Count) do
          DeleteFile(PChar(TempFiles.Strings[I]));
        TempFiles.Free;
      end).Start;
  inherited;
end;

procedure TControllerFileManager.DeleteFiles(const IdFile: string; const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create
    .SetShowScreen(False)
    .SetMainProcess(
      procedure
      var
        Request: TRequest;
      begin
        Request := TRequest.Create(GetServerURL, GetToken);
        try
          Request.SetResource('Arquivo/{Id}').AddParam('Id', IdFile, pkURLSEGMENT).DELETE(Response);
        finally
          Request.ProcessResponse(Response);
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

procedure TControllerFileManager.DeleteGroup(const IdGroup: string; const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create
    .SetShowScreen(False)
    .SetMainProcess(
      procedure
      var
        Request: TRequest;
      begin
        Request := TRequest.Create(GetServerURL, GetToken);
        try
          Request.SetResource('Agrupamento/{Id}').AddParam('Id', IdGroup, pkURLSEGMENT).DELETE(Response);
        finally
          Request.ProcessResponse(Response);
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

procedure TControllerFileManager.GetGroup(const IdGroup: string; const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create
    .SetShowScreen(False)
    .SetMainProcess(
      procedure
      var
        Request: TRequest;
      begin
        Request := TRequest.Create(GetServerURL, GetToken);
        try
          mmtAgrupamento.Table.Clear;
          Request.SetResource('Agrupamento/{Id}').AddParam('Id', IdGroup, pkURLSEGMENT).GET(Response);
        finally
          if Request.ProcessResponse(Response, True) then
            mmtAgrupamento.LoadFromJSON(Request.Response.JSONValue.GetValue<TJSONObject>, False);
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

procedure TControllerFileManager.GetAgrupamentoByCadastro(const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create
    .SetShowScreen(False)
    .SetMainProcess(
      procedure
      var
        Request: TRequest;
      begin
        Request := TRequest.Create(GetServerURL, GetToken);
        try
          mmtAgrupamento.Table.Clear;
          Request.SetResource('Cadastro/{Id}/Agrupamentos').AddParam('Id', mmtCadastroCOD_CAD.AsString, pkURLSEGMENT).AddParam('raiz', 'S').GET(Response);
        finally
          if Request.ProcessResponse(Response, True) then
            mmtAgrupamento.LoadFromJSON(Request.Response.JSONValue.GetValue<TJSONArray>, False);
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

procedure TControllerFileManager.GetFiles(const IdFolder: string; const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create
    .SetShowScreen(False)
    .SetMainProcess(
      procedure
      var
        Request: TRequest;
      begin
        Request := TRequest.Create(GetServerURL, GetToken);
        try
          mmtArquivos.Table.Clear;
          Request.Clear.SetResource('Pasta/{Id}/Arquivos').AddParam('Id', IdFolder, pkURLSEGMENT).GET(Response);
        finally
          if Request.ProcessResponse(Response, True) then
            mmtArquivos.LoadFromJSON(Request.Response.JSONValue.GetValue<TJSONArray>, False);
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

procedure TControllerFileManager.GetCadastro(const Codigo: string; const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create
    .SetShowScreen(False)
    .SetMainProcess(
      procedure
      var
        Request: TRequest;
      begin
        Request := TRequest.Create(GetServerURL, GetToken);
        try
          mmtCadastro.Table.Clear;
          Request.SetResource('Cadastro/{Id}').AddParam('Id', Codigo, pkURLSEGMENT).GET(Response);
        finally
          if Request.ProcessResponse(Response, True) then
            mmtCadastro.LoadFromJSON(Request.Response.JSONValue.GetValue<TJSONObject>, False);
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

procedure TControllerFileManager.GetFolders(const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create
    .SetShowScreen(False)
    .SetMainProcess(
      procedure
      var
        Request: TRequest;
      begin
        Request := TRequest.Create(GetServerURL, GetToken);
        try
          mmtPastas.Table.Clear;
          Request.SetResource('Agrupamento/{Id}/Pastas').AddParam('Id', mmtAgrupamentoCOD_AGR.AsString, pkURLSEGMENT).GET(Response);
        finally
          if Request.ProcessResponse(Response, True) then
            mmtPastas.LoadFromJSON(Request.Response.JSONValue.GetValue<TJSONArray>, False);
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

procedure TControllerFileManager.GetSubFolders(const IdGroup: string; const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create
    .SetShowScreen(False)
    .SetMainProcess(
      procedure
      var
        Request: TRequest;
      begin
        Request := TRequest.Create(GetServerURL, GetToken);
        try
          mmtPastas.Table.Clear;
          Request.SetResource('Agrupamento/{Id}/SubPastas').AddParam('Id', IdGroup, pkURLSEGMENT).GET(Response);
        finally
          if Request.ProcessResponse(Response, True) then
            mmtPastas.LoadFromJSON(Request.Response.JSONValue.GetValue<TJSONArray>, False);
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

function TControllerFileManager.GroupExists(const IdGroup: string): Boolean;
var
  Request: TRequest;
begin
  Request := TRequest.Create(GetServerURL, GetToken);
  try
    Request.SetResource('Agrupamento/{Id}').AddParam('Id', IdGroup, pkURLSEGMENT).GET(nil);
  finally
    Result := (Request.Response.StatusCode <> TResponseCode.NotFound);
    Request.Free;
  end;
end;

procedure TControllerFileManager.DownloadFile(const IdFile: string; const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create('Baixando o arquivo!')
    .SetMainProcess(
      procedure
      var
        Request: TIdHTTP;
        Anexo: TMemoryStream;
        FilePath: string;
      begin
        if not mmtArquivos.Locate('COD_ARQ', IdFile) then
          Exit;
        Request := TIdHTTP.Create(Self);
        Anexo := TMemoryStream.Create;
        try
          try
            Request.Request.CustomHeaders.Values['Authorization'] := GetToken;
            Request.Get(GetServerURL + '/Arquivo/' + mmtArquivosCOD_ARQ.AsString + '/Download', Anexo);
            FilePath := GetTempDirectory + mmtArquivosNOME_ARQ.AsString;
            Anexo.SaveToFile(FilePath);
            ShellExecute(Application.Handle, 'open', PChar(FilePath), nil, nil, SW_SHOWNORMAL);
            if not Assigned(TempFiles) then
              TempFiles := TStringList.Create;
            TempFiles.Add(FilePath);
          except
            on E: Exception do
              Response.SetError(E.Message);
          end;
        finally
          Anexo.Free;
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

procedure TControllerFileManager.EditFile(const FileData: TJSONObject; const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create
    .SetShowScreen(False)
    .SetMainProcess(
      procedure
      var
        Request: TRequest;
      begin
        Request := TRequest.Create(GetServerURL, GetToken);
        try
          Request.SetResource('Arquivo/{Id}').AddParam('Id', FileData.GetValue<string>('cod_arq'), pkURLSEGMENT).AddBody(FileData, False).PUT(Response);
        finally
          Request.ProcessResponse(Response);
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

procedure TControllerFileManager.EditFolder(const FolderData: TJSONObject; const AOwns: Boolean; const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create
    .SetShowScreen(False)
    .SetMainProcess(
      procedure
      var
        Request: TRequest;
      begin
        Request := TRequest.Create(GetServerURL, GetToken);
        try
          Request.SetResource('Pasta/{Id}').AddParam('Id', FolderData.GetValue<string>('cod_pas'), pkURLSEGMENT).AddBody(FolderData, AOwns).PUT(Response);
        finally
          Request.ProcessResponse(Response);
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

procedure TControllerFileManager.EditGroup(const GroupData: TJSONObject; const CallBack: TResponseCallBack);
var
  Response: IResponse;
begin
  Response := TResponse.Create;
  TWait.Create
    .SetShowScreen(False)
    .SetMainProcess(
      procedure
      var
        Request: TRequest;
      begin
        Request := TRequest.Create(GetServerURL, GetToken);
        try
          Request.SetResource('Agrupamento/{Id}').AddParam('Id', GroupData.GetValue<string>('cod_agr'), pkURLSEGMENT).AddBody(GroupData).PUT(Response);
        finally
          Request.ProcessResponse(Response);
          Request.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response);
      end)
    .Start;
end;

end.
