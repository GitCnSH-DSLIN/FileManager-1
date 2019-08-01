unit FileManager.Providers.Dialogs.Input;

interface

uses FileManager.Providers.Dialogs.Input.Form, System.UITypes;

type
  TDialogsInput = class
  public
    class function Show(const Title: string; var Description: string; const DefaultText: string = ''): Boolean;
  end;

implementation

{ TDialogsInput }

class function TDialogsInput.Show(const Title: string; var Description: string; const DefaultText: string): Boolean;
var
  FrmInput: TFrmInput;
begin
  FrmInput := TFrmInput.Create(nil);
  try
    FrmInput.Caption := Title;
    FrmInput.edtDescricao.Text := DefaultText;
    Result := (FrmInput.ShowModal = mrOk);
    Description := FrmInput.edtDescricao.Text;
  finally
    FrmInput.Free;
  end;
end;

end.
