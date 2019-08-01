unit FileManager;

interface

uses FileManager.Views.FileControl, Vcl.Forms, FileManager.Providers.Modulos.Imagens, FileManager.Providers.FileServer;

type
  TFileManager = class
  private
    FFileControl: TFrmFileControl;
    procedure SetMaxFileSize(const Value: Int64);
  public
    const ONE_MB_SIZE = 1048577;
    property MaxFileSize: Int64 write SetMaxFileSize;
    constructor Create;
    function FileServer: TFileServer;
    procedure Execute;
    destructor Destroy; override;
  end;

implementation

{ TFileServer }

constructor TFileManager.Create;
begin
  FFileControl := TFrmFileControl.Create(Application.MainForm);
  DMImagens := TDMImagens.Create(Application.MainForm);
end;

destructor TFileManager.Destroy;
begin
  FFileControl.Free;
  DMImagens.Free;
  inherited;
end;

procedure TFileManager.Execute;
begin
  FFileControl.ShowModal;
end;

function TFileManager.FileServer: TFileServer;
begin
  Result := FFileControl.FileServer;
end;

procedure TFileManager.SetMaxFileSize(const Value: Int64);
begin
  FFileControl.Controller.MaxFileSize := Value;
end;

end.
