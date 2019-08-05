unit Providers.Types.CallBack;

interface

uses System.JSON, FileManager.Providers.Frames.Base;

type
  TBooleanCallBack = reference to procedure(const Response: Boolean);

  TOpenFolder = reference to procedure(const IdGroup, IdFolder, FolderName: string);
  TEditFolder = reference to procedure(const FolderData: TJSONObject; const CallBack: TBooleanCallBack);
  TDeleteGroup = reference to procedure(const IdGroup: string; const FrameFolder: TFrameBase);

  TDownloadFile = reference to procedure(const IdFile: string);
  TEditFile = reference to procedure(const FolderData: TJSONObject; const CallBack: TBooleanCallBack);
  TDeleteFile = reference to procedure(const IdFile: string; const FrameFile: TFrameBase);

implementation

end.
