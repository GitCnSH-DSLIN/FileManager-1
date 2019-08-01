program FileManagerSample;

uses
  Vcl.Forms,
  FileManager.Views.MainMenu in 'src\views\FileManager.Views.MainMenu.pas' {FrmServidorArquivos},
  FileManager.Views.FileControl in '..\src\views\FileManager.Views.FileControl.pas' {FrmFileControl},
  FileManager.Providers.Constants in '..\src\providers\FileManager.Providers.Constants.pas',
  FileManager.Providers.ObserverFile.Intf in '..\src\providers\FileManager.Providers.ObserverFile.Intf.pas',
  FileManager.Providers.Aguarde.Impl in '..\src\providers\aguarde\FileManager.Providers.Aguarde.Impl.pas',
  FileManager.Providers.Request.Authentication in '..\src\providers\request\FileManager.Providers.Request.Authentication.pas',
  FileManager.Providers.Request in '..\src\providers\request\FileManager.Providers.Request.pas',
  FileManager.Providers.Response.Default in '..\src\providers\response\FileManager.Providers.Response.Default.pas',
  FileManager.Providers.Response.Handler.Default in '..\src\providers\response\FileManager.Providers.Response.Handler.Default.pas',
  FileManager.Providers.Response.Intf in '..\src\providers\response\FileManager.Providers.Response.Intf.pas',
  FileManager.Providers.Aguarde.Form in '..\src\providers\aguarde\FileManager.Providers.Aguarde.Form.pas' {FrmAguarde},
  FileManager.Providers.Types.TipoArquivo in '..\src\providers\types\FileManager.Providers.Types.TipoArquivo.pas',
  FileManager.Providers.Modulos.Imagens in '..\src\providers\modulos\FileManager.Providers.Modulos.Imagens.pas' {DMImagens: TDataModule},
  FileManager.Providers.FileCatcher in '..\src\providers\FileManager.Providers.FileCatcher.pas',
  FileManager.Views.DragDropArea in '..\src\views\FileManager.Views.DragDropArea.pas' {FrmDragDropArea},
  FileManager.Providers.Frames.Base in '..\src\providers\frames\FileManager.Providers.Frames.Base.pas' {FrameBase: TFrame},
  FileManager.Providers.FileServer in '..\src\providers\FileManager.Providers.FileServer.pas',
  FileManager.Providers.Frames.Arquivo in '..\src\providers\frames\FileManager.Providers.Frames.Arquivo.pas' {FrameArquivo: TFrame},
  FileManager.Providers.Frames.FileUpload in '..\src\providers\frames\FileManager.Providers.Frames.FileUpload.pas' {FrameFileUpload: TFrame},
  FileManager.Providers.Frames.Pasta in '..\src\providers\frames\FileManager.Providers.Frames.Pasta.pas' {FramePasta: TFrame},
  FileManager.Providers.Dialogs.Input in '..\src\providers\dialogs\FileManager.Providers.Dialogs.Input.pas',
  FileManager.Providers.Dialogs.Input.Form in '..\src\providers\dialogs\FileManager.Providers.Dialogs.Input.Form.pas' {FrmInput},
  FileManager.Controllers.FileControl in '..\src\controllers\FileManager.Controllers.FileControl.pas' {ControllerFileControl: TDataModule},
  FileManager.Providers.Controllers.FileManager in '..\src\providers\controllers\FileManager.Providers.Controllers.FileManager.pas' {ControllerFileManager: TDataModule},
  FileManager.Providers.PathControl in '..\src\providers\FileManager.Providers.PathControl.pas',
  FileManager in '..\src\FileManager.pas',
  FileManager.Providers.Controllers.Base in '..\src\providers\controllers\FileManager.Providers.Controllers.Base.pas' {DMBase: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmServidorArquivos, FrmServidorArquivos);
  Application.Run;
end.
