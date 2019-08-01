unit FileManager.Providers.Response.Intf;

interface

uses
  System.Classes, System.JSON;

type
{$SCOPEDENUMS ON}
  TResponseType = (Success, Error);
{$SCOPEDENUMS OFF}

  IResponse = interface
    ['{F33DB866-8E0B-4FB8-BE38-8BFAFFADC00A}']
    function GetRequiredFields: TStringList;
    function GetErrorMessage: string;
    function SetRequiredField(const value: string): IResponse;
    function SetError(const Value: string): IResponse; overload;
    function SetError: IResponse; overload;
    function Success: Boolean;
    function Error: Boolean;
    function Clear: IResponse;
  end;

  IResponseHandler = interface
    ['{D08D0540-F1DC-4910-B552-5C1E587A871E}']
    function Handle(const Response: IResponse): Boolean;
  end;

implementation

end.
