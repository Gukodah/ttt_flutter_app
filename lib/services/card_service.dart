import 'package:trigg_app/services/main_service.dart';

class CardService extends MainService {
  Future<dynamic> getCard({bool principal = true}) async {
    return get("/cartaocredito/",
        queryParams: {"principal": principal.toString()});
  }
}
