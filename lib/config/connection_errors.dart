class ConnectionError{

  static bool ProcesarRespuesta(int code){
    switch(code){
      case 200:
        return true;
      break;
      case 500:
        throw Exception("Lo sentimos de momento los servicios no estan contestando, favor de intentar mas tarde");
      break;
      case 502:
        throw Exception("Lo sentimos de momento los servicios no estan contestando, favor de intentar mas tarde");
      break;
      case 404:
        throw Exception("Lo sentimos de momento los servicios no estan contestando, favor de intentar mas tarde");
      break;
      case 401:
        throw Exception("Lo sentimos de momento los servicios no estan contestando, favor de intentar mas tarde");
      break;
    }
    return false;
  }
}