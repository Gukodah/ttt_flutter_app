import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trigg_app/models/prospect.dart';
import 'package:trigg_app/services/aquisicao_service.dart';

class ProspectProvider with ChangeNotifier {
  ProspectProvider() {
    load();
  }
  AqusicaoService service = AqusicaoService();
  Prospect? prospect = Prospect();
  final storage = FlutterSecureStorage();

  void save() {
    storage.write(key: 'prospect', value: jsonEncode(prospect));
  }

  Future<Prospect?> load() async {
    if (!(await storage.containsKey(key: "prospect"))) {
      return Prospect();
    }
    var json = jsonDecode((await storage.read(key: "prospect"))!);
    prospect = Prospect.fromJson(json);
    notifyListeners();
    return prospect;
  }

  preCadastro() async {
    await service.preCadastro(prospect!);
  }
}
