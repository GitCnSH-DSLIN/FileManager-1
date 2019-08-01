unit FileManager.Providers.Dialogs.Input.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, VCL.BlockUI, VCL.BlockUI.Intf, Vcl.Buttons, dxGDIPlusClasses, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TFrmInput = class(TForm)
    lblDescricao: TLabel;
    edtDescricao: TEdit;
    btnSalvar: TButton;
    btnCancelar: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FBlockUI: IBlockUI;
  end;

implementation

{$R *.dfm}

procedure TFrmInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmInput.FormCreate(Sender: TObject);
begin
  FBlockUI := TBlockUI.Create(TWinControl(Self.Owner));
end;

procedure TFrmInput.FormDestroy(Sender: TObject);
begin
  FBlockUI := nil;
end;

procedure TFrmInput.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TFrmInput.FormShow(Sender: TObject);
begin
  edtDescricao.SetFocus;
end;

end.
