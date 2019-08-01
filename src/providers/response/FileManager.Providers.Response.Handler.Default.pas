unit FileManager.Providers.Response.Handler.Default;

interface

uses
  FileManager.Providers.Response.Intf, System.SysUtils, System.Classes, System.UITypes, Vcl.Controls, Dialogs4D.Factory;

type
  TResponseHandler = class(TInterfacedObject, IResponseHandler)
  private
    FCadastro: TWinControl;
    constructor Create(const Cadastro: TWinControl);
    function Handle(const Response: IResponse): Boolean;
    function HandleSuccess(const Response: IResponse): Boolean;
    function HandleError(const Response: IResponse): Boolean;
  public
    class function New(const Cadastro: TWinControl): IResponseHandler;
    destructor Destroy; override;
  end;

implementation

uses
  System.Generics.Collections;

constructor TResponseHandler.Create(const Cadastro: TWinControl);
begin
  inherited Create;
  FCadastro := Cadastro;
end;

class function TResponseHandler.New(const Cadastro: TWinControl): IResponseHandler;
begin
  Result := TResponseHandler.Create(Cadastro);
end;

destructor TResponseHandler.Destroy;
begin
  FCadastro := nil;
  inherited;
end;

function TResponseHandler.Handle(const Response: IResponse): Boolean;
begin
  if Response.Success then
    Result := Self.HandleSuccess(Response)
  else
    Result := Self.HandleError(Response);
end;

function TResponseHandler.HandleError(const Response: IResponse): Boolean;
begin
  Result := False;
  if not Response.GetErrorMessage.Trim.IsEmpty then
    TDialogs.Error(Response.GetErrorMessage);
end;

function TResponseHandler.HandleSuccess(const Response: IResponse): Boolean;
begin
  Result := True;
end;

end.
