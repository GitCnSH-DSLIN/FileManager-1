unit FileManager.Views.MainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.Math, FileManager;

type
  TFrmServidorArquivos = class(TForm)
    btnExecute: TButton;
    lblTable: TLabel;
    edtTableName: TEdit;
    lblOrigem: TLabel;
    edtIdOrigin: TEdit;
    edtMaxFileSize: TEdit;
    lblTamanhoMaximo: TLabel;
    grpFilesType: TGroupBox;
    chkImages: TCheckBox;
    chkWord: TCheckBox;
    chkExcel: TCheckBox;
    chkPowerPoint: TCheckBox;
    chkZIP: TCheckBox;
    chkPDF: TCheckBox;
    lblCadastro: TLabel;
    edtIdGroup: TEdit;
    lblSistema: TLabel;
    lblPai: TLabel;
    edtFatherGroup: TEdit;
    lblMainFolderName: TLabel;
    edtMainFolderName: TEdit;
    grpPermissions: TGroupBox;
    chkUpdate: TCheckBox;
    chkDelete: TCheckBox;
    chkDownload: TCheckBox;
    chkUpload: TCheckBox;
    grpGroupPermissions: TGroupBox;
    chkGroupUpdate: TCheckBox;
    chkGroupDelete: TCheckBox;
    chkGroupDownload: TCheckBox;
    chkGroupUpload: TCheckBox;
    edtSystemName: TEdit;
    edtServerURL: TEdit;
    lblServerURL: TLabel;
    Label1: TLabel;
    btnClear: TButton;
    edtToken: TEdit;
    procedure btnExecuteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  end;

var
  FrmServidorArquivos: TFrmServidorArquivos;

implementation

{$R *.dfm}

procedure TFrmServidorArquivos.btnClearClick(Sender: TObject);
begin
  edtIdOrigin.Clear;
  edtTableName.Clear;
  edtSystemName.Clear;
  edtFatherGroup.Clear;
  edtIdGroup.Clear;
  edtMainFolderName.Clear;
end;

procedure TFrmServidorArquivos.btnExecuteClick(Sender: TObject);
var
  FileManager: TFileManager;
begin
  FileManager := TFileManager.Create;
  try
    FileManager.MaxFileSize := FileManager.ONE_MB_SIZE * StrToInt64Def(edtMaxFileSize.Text, 1);
    FileManager.ServerURL := edtServerURL.Text;
    FileManager.Token := edtToken.Text;
    FileManager.FileServer.IdOrigin := edtIdOrigin.Text;
    FileManager.FileServer.TableName := edtTableName.Text;
    FileManager.FileServer.SystemName := edtSystemName.Text;
    FileManager.FileServer.FatherGroup := edtFatherGroup.Text;
    FileManager.FileServer.MainGroup := edtIdGroup.Text;
    FileManager.FileServer.MainFolderName := edtMainFolderName.Text;
    FileManager.Execute;
  finally
    FileManager.Free;
  end;
end;

end.
