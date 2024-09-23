import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:trigg_app/models/fatura.dart';
import 'package:trigg_app/services/fatura_service.dart';

class FaturaProvider with ChangeNotifier {
  final service = FaturaService();
  List<String>? _periodos;

  List<String>? get periodos {
    if (_periodos == null) {
      getPeriods();
    }
    return _periodos;
  }

  void getPeriods({bool principal = true}) async {
    var response = await service.getPeriods();
    _periodos = List<String>.from(response['result']);
    notifyListeners();
  }

  Future<Fatura> getFatura(String periodo) async {
    var response = await service.getFatura(periodo);
    return Fatura.fromJson(response['result'][0]);
  }
}
