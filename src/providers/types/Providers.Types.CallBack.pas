unit Providers.Types.CallBack;

interface

uses System.JSON, FileManager.Providers.Frames.Base, FileManager.Providers.Response.Intf, FileManager.Providers.Frames.FileUpload;

type
  TBooleanCallBack = reference to procedure(const Response: Boolean);
  TResponseCallBack = reference to procedure(const Response: IResponse);

  TUploadCallBack = reference to procedure(const Response: IResponse; const FileItem: TFrameFileUpload);

  TOpenFolder = reference to procedure(const IdGroup, IdFolder, FolderName: string);
  TEditFolder = reference to procedure(const FolderData: TJSONObject; const CallBack: TBooleanCallBack);
  TDeleteGroup = reference to procedure(const IdGroup: string; const FrameFolder: TFrameBase);

  TDownloadFile = reference to procedure(const IdFile: string);
  TEditFile = reference to procedure(const FolderData: TJSONObject; const CallBack: TBooleanCallBack);
  TDeleteFile = reference to procedure(const IdFile: string; const FrameFile: TFrameBase);

implementation

end.
