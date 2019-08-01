unit FileManager.Providers.Constants;

interface

const
  URL_SERVIDOR_ARQUIVOS = 'http://localhost:8080/fiorilli/api/files';
  REQUEST_ERROR_MESSAGE = 'Não foi possível processar a requisição!';

type
  TResponseCode = record
    const Sucess = 200;
    const BadRequest = 400;
    const NotFound = 404;
    const Duplicate = 409;
    const Unauthorized = 401;
    const Forbidden = 403;
    const NotAcceptable = 406;
    const UnavailableForLegalReasons = 451;
    const UnsupportedMedia = 415;
  end;

implementation

end.
