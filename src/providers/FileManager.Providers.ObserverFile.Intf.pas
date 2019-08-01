unit FileManager.Providers.ObserverFile.Intf;

interface

uses Vcl.Forms;

type
  IObserverFile = interface
    ['{A2963272-DFAC-41C2-BF77-E0271AA8053D}']
    procedure RemoveFileItem(const FileFrame: TFrame);
  end;

implementation

end.
