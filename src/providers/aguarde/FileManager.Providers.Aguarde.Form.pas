unit FileManager.Providers.Aguarde.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.GIFImg, Vcl.WinXCtrls;

type
  TFrmAguarde = class(TForm)
    lblContent: TLabel;
    ActivityIndicator: TActivityIndicator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrmAguarde.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
