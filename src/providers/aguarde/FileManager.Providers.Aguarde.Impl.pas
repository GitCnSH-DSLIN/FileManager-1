unit FileManager.Providers.Aguarde.Impl;

interface

uses
  System.Classes, System.SysUtils, Vcl.Forms, FileManager.Providers.Constants, FileManager.Providers.Aguarde.Form,
  VCL.BlockUI.Intf, VCL.Controls, VCL.BlockUI;

type
  TWait = class
  private
    FBlockUI: IBlockUI;
    FMensagem: string;
    FMainProcess: TProc;
    FFinnalyProcess: TProc;
    FrmAguarde: TFrmAguarde;
    FShowScreen: Boolean;
  public
    constructor Create(const Mensagem: string = '');
    function SetMensagem(const Mensagem: string): TWait;
    function SetMainProcess(const MainProcedure: TProc): TWait;
    function SetFinallyProcess(const FinnalyProcedure: TProc): TWait;
    function SetShowScreen(const Value: Boolean): TWait;
    procedure Start;
    class procedure Synchronize(const Process: TThreadMethod);
    destructor Destroy; override;
  end;

implementation

constructor TWait.Create(const Mensagem: string);
begin
  FShowScreen := True;
  Self.SetMensagem(Mensagem);
end;

destructor TWait.Destroy;
begin
  if (Assigned(FrmAguarde)) then
    FrmAguarde := nil;
  inherited;
end;

function TWait.SetFinallyProcess(const FinnalyProcedure: TProc): TWait;
begin
  FFinnalyProcess := FinnalyProcedure;
  Result := Self;
end;

function TWait.SetMainProcess(const MainProcedure: TProc): TWait;
begin
  FMainProcess := MainProcedure;
  Result := Self;
end;

function TWait.SetMensagem(const Mensagem: string): TWait;
begin
  FMensagem := Mensagem;
  Result := Self;
end;

function TWait.SetShowScreen(const Value: Boolean): TWait;
begin
  FShowScreen := Value;
  Result := Self;
end;

procedure TWait.Start;
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      try
        try
          if Assigned(FMainProcess) then
            FMainProcess;
        except on E:Exception do
          Application.ShowException(E);
        end;
      finally
        TThread.Synchronize(nil,
          procedure
          begin
            if FShowScreen then
            begin
              FrmAguarde.Close;
              FBlockUI := nil;
            end;
            if Assigned(FFinnalyProcess) then
              FFinnalyProcess;
            Self.Destroy;
          end);
      end;
    end).Start;
  if FShowScreen then
  begin
    FBlockUI := TBlockUI.Create(Application.MainForm);
    FrmAguarde := TFrmAguarde.Create(Application);
    FrmAguarde.lblContent.Caption := FMensagem;
    FrmAguarde.ShowModal;
  end;
end;

class procedure TWait.Synchronize(const Process: TThreadMethod);
begin
  TThread.Synchronize(TThread.CurrentThread, Process);
end;

end.
