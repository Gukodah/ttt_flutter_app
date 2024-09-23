import 'package:trigg_app/services/main_service.dart';

class FaturaService extends MainService {
  Future<dynamic> getPeriods() {
    return get("/cartaocredito/fatura/periodos");
  }

  Future<dynamic> getFatura(String periodo) {
    return get("/cartaocredito/fatura2/$periodo");
  }
}
