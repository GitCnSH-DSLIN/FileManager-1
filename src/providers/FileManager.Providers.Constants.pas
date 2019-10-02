unit FileManager.Providers.Constants;

interface

const
  REQUEST_ERROR_MESSAGE = 'Não foi possível processar a requisição!';
  FILE_SERVER_SECRET_KEY = 'a2V5X2Jhc2U2NF9mb3JtYXRfZmlvcmlsbGlfc29mdHdhcmVfYXBwOmZpbGVfc2VydmVy';

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
