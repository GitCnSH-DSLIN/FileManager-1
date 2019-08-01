unit FileManager.Providers.Types.TipoArquivo;

interface

uses System.StrUtils, System.Classes, System.SysUtils;

type
{$SCOPEDENUMS ON}
  TTipoDocumento = (AI, AVI, CSS, CSV, DOC, EXE, HTML, ISO, JPG, JS, JSON, MP3, MP4, PDF, PNG, PPT, PSD, RTF, SVG, TXT, UNKNOW,
    XLS, XML, ZIP);
{$SCOPEDENUMS OFF}

  TTipoDocumentoHelper = record helper for TTipoDocumento
    function GetImageIndex: Integer;
  end;

function StrToTipoDocumento(const Value: string): TTipoDocumento;

implementation

function StrToTipoDocumento(const Value: string): TTipoDocumento;
begin
  case AnsiIndexStr(Value.ToUpper, ['.AI', '.AVI', '.CSS', '.CSV', '.DOC', '.DOCX', '.EXE', '.HTML', '.ISO', '.JPG', '.JPEF', '.JS',
    '.JSON', '.MP3', '.MP4', '.PDF', '.PNG', '.PPT', '.PPTX', '.PSD', '.RTF', '.SVG', '.TXT', '.XLS', '.XLSX', '.ZIP', '.RAR', '.XML']) of
    0:
      Result := TTipoDocumento.AI;

    1:
      Result := TTipoDocumento.AVI;

    2:
      Result := TTipoDocumento.CSS;

    3:
      Result := TTipoDocumento.CSV;

    4, 5:
      Result := TTipoDocumento.DOC;

    6:
      Result := TTipoDocumento.EXE;

    7:
      Result := TTipoDocumento.HTML;

    8:
      Result := TTipoDocumento.ISO;

    9, 10:
      Result := TTipoDocumento.JPG;

    11:
      Result := TTipoDocumento.JS;

    12:
      Result := TTipoDocumento.JSON;

    13:
      Result := TTipoDocumento.MP3;

    14:
      Result := TTipoDocumento.MP4;

    15:
      Result := TTipoDocumento.PDF;

    16:
      Result := TTipoDocumento.PNG;

    17, 18:
      Result := TTipoDocumento.PPT;

    19:
      Result := TTipoDocumento.PSD;

    20:
      Result := TTipoDocumento.RTF;

    21:
      Result := TTipoDocumento.SVG;

    22:
      Result := TTipoDocumento.TXT;

    23, 24:
      Result := TTipoDocumento.XLS;

    25, 26:
      Result := TTipoDocumento.ZIP;

    27:
      Result := TTipoDocumento.XML;

  else
    Result := TTipoDocumento.UNKNOW;
  end;

end;

function TTipoDocumentoHelper.GetImageIndex: Integer;
begin
  Result :=  Ord(Self);
end;

end.
