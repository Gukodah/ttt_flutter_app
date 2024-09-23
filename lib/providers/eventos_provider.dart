import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:trigg_app/models/evento.dart';
import 'package:trigg_app/services/eventos_service.dart';

class EventosProvider with ChangeNotifier {
  final service = EventosService();
  List<Evento>? _eventos;

  events(int cardNumber) {
    if (_eventos == null) {
      getEvents(cardNumber);
    }
    return _eventos;
  }

  void getEvents(int cardNumber) async {
    var response = await service.getEvents(cardNumber);
    _eventos = eventoListFromJson(jsonEncode(response['result']));
    notifyListeners();
  }
}
