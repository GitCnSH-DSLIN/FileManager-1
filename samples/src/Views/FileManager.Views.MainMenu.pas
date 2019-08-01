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
    edtOrigem: TEdit;
    edtTamanhoMaximo: TEdit;
    lblTamanhoMaximo: TLabel;
    GroupBox1: TGroupBox;
    chkImagens: TCheckBox;
    chkWord: TCheckBox;
    chkExcel: TCheckBox;
    chkPowerPoint: TCheckBox;
    chkArquivosZipados: TCheckBox;
    chkPDF: TCheckBox;
    lblCadastro: TLabel;
    edtCadastro: TEdit;
    lblSistema: TLabel;
    lblPai: TLabel;
    edtFatherGroup: TEdit;
    Label1: TLabel;
    edtDescricaoPastaRaiz: TEdit;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    GroupBox3: TGroupBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    edtSistema: TEdit;
    procedure btnAbrirClick(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  FrmServidorArquivos: TFrmServidorArquivos;

implementation

{$R *.dfm}

procedure TFrmServidorArquivos.btnAbrirClick(Sender: TObject);
var
  FileManager: TFileManager;
begin
  FileManager := TFileManager.Create;
  try
    FileManager.MaxFileSize := FileManager.ONE_MB_SIZE * StrToInt64Def(edtTamanhoMaximo.Text, 1);
    FileManager.FileServer.Origem := edtOrigem.Text;
    FileManager.FileServer.Tabela := edtTableName.Text;
    FileManager.FileServer.Sistema := edtSistema.Text;
    FileManager.FileServer.FatherGroup := edtFatherGroup.Text;
    FileManager.FileServer.IdCadastro := edtCadastro.Text;
    FileManager.FileServer.MainFolderName := edtDescricaoPastaRaiz.Text;
    FileManager.Execute;
  finally
    FileManager.Free;
    edtOrigem.Clear;
    edtTableName.Clear;
    edtFatherGroup.Clear;
    edtCadastro.Clear;
    edtDescricaoPastaRaiz.Clear;
  end;
end;

end.
