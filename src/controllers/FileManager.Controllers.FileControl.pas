unit FileManager.Controllers.FileControl;

interface

uses
  System.SysUtils, System.Classes, FileManager.Providers.Controllers.Base, FileManager.Providers.Frames.FileUpload,
  FileManager.Providers.Response.Default, FileManager.Providers.Response.Intf, FileManager.Providers.Aguarde.Impl,
  FileManager.Providers.Request, System.JSON, FileManager.Providers.Constants, REST.Types, Providers.Types.CallBack;

type
  TControllerFileControl = class(TFileManagerController)
    procedure DataModuleCreate(Sender: TObject);
  private
    FMaxFileSize: Int64;
    function CreateArquivo(const FileData: TJSONObject; const Response: IResponse): Integer;
    procedure SetMaxFileSize(const Value: Int64);
  public
    property MaxFileSize: Int64 read FMaxFileSize write SetMaxFileSize;
    procedure UploadArquivo(const FileItem: TFrameFileUpload; const CallBack: TUploadCallBack);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TControllerFileControl.CreateArquivo(const FileData: TJSONObject; const Response: IResponse): Integer;
var
  Request: TRequest;
begin
  Result := 0;
  Request := TRequest.Create(GetServerURL, GetToken);
  try
    Request.Clear.SetResource('Arquivo').AddBody(FileData, False).Post(Response);
  finally
    if Request.ProcessResponse(Response) then
      Result := Request.Response.JSONValue.GetValue<Integer>('COD_ARQ');
    Request.Free;
  end;
end;

procedure TControllerFileControl.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FMaxFileSize := 0;
end;

procedure TControllerFileControl.SetMaxFileSize(const Value: Int64);
begin
  FMaxFileSize := Value;
end;

procedure TControllerFileControl.UploadArquivo(const FileItem: TFrameFileUpload; const CallBack: TUploadCallBack);
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
        Anexo: TMemoryStream;
        IdAnexo: string;
      begin
        if FMaxFileSize > 0 then
          if FileItem.GetFileData.GetValue<Int64>('TAMANHO_ARQ') > FMaxFileSize then
          begin
            Response.SetError('O tamanho máximo permitido é de ' + FormatFileSize(FMaxFileSize));
            Exit;
          end;
        IdAnexo := CreateArquivo(FileItem.GetFileData, Response).ToString;
        if not Response.Success then
          Exit;
        Request := TRequest.Create(GetServerURL, GetToken);
        Anexo := TMemoryStream.Create;
        try
          Anexo.LoadFromFile(FileItem.GetFilePath);
          Request.Clear.SetResource('Arquivo/{Id}/Upload').AddParam('Id', IdAnexo, pkURLSEGMENT).AddFile('Anexo', Anexo).Post(Response);
        finally
          if not Request.ProcessResponse(Response) then
            Request.Clear.SetResource('Arquivo/{Id}').AddParam('Id', IdAnexo, pkURLSEGMENT).DELETE(Response);
          Request.Free;
          Anexo.Free;
        end;
      end)
    .SetFinallyProcess(
      procedure
      begin
        CallBack(Response, FileItem);
      end)
    .Start;
end;

end.
