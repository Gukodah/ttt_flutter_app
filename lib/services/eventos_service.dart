import 'package:trigg_app/services/main_service.dart';

class EventosService extends MainService {
  Future<dynamic> getEvents(int cardNumber) async {
    return get("/cartaocredito/$cardNumber/evento",
        queryParams: {"page": "0", "pageSize": "50"});
  }
}
