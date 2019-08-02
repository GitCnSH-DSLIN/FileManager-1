unit FileManager.Views.MainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.Math, FileManager;

type
  TFrmServidorArquivos = class(TForm)
    btnAbrir: TButton;
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
    procedure btnAbrirClick(Sender: TObject);
  end;

var
  FrmServidorArquivos: TFrmServidorArquivos;

implementation

{$R *.dfm}

procedure TFrmServidorArquivos.btnAbrirClick(Sender: TObject);
var
  FileManager: TFileManager;
begin
  FileManager := TFileManager.Create(edtServerURL.Text);
  try
    FileManager.MaxFileSize := FileManager.ONE_MB_SIZE * StrToInt64Def(edtMaxFileSize.Text, 1);
    FileManager.FileServer.IdOrigin := edtIdOrigin.Text;
    FileManager.FileServer.TableName := edtTableName.Text;
    FileManager.FileServer.SystemName := edtSystemName.Text;
    FileManager.FileServer.FatherGroup := edtFatherGroup.Text;
    FileManager.FileServer.MainGroup := edtIdGroup.Text;
    FileManager.FileServer.MainFolderName := edtMainFolderName.Text;
    FileManager.Execute;
  finally
    FileManager.Free;
    edtIdOrigin.Clear;
    edtTableName.Clear;
    edtFatherGroup.Clear;
    edtMainFolderName.Clear;
    edtFatherGroup.Clear;
    edtSystemName.Clear;
  end;
end;

end.
