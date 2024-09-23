import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trigg_app/exceptions/twostep_exception.dart';
import 'package:trigg_app/models/user.dart';
import 'package:trigg_app/services/auth_service.dart';

class UserProvider with ChangeNotifier {
  final service = AuthService();
  final storage = FlutterSecureStorage();

  User? _user;
  String? _cpf;

  bool get isAuth {
    if (_user == null || accessToken == null || accessToken!.isEmpty) {
      return false;
    }
    return _user!.expiresIn!.isAfter(DateTime.now());
  }

  String? get accessToken {
    return _user?.accessToken;
  }

  User? get user {
    return _user;
  }

  String? get getCpf {
    return _cpf;
  }

  set credentials(Map<String, dynamic> credentials) {
    if (_user == null) {
      _user = User.empty();
    }
    _user!.setCredentials(credentials);
  }

  void setCpf(String cpf) {
    this._cpf = cpf;
  }

  Future<void> login({String? cpf, required String password}) async {
    await storage.deleteAll();
    print('${cpf ?? this._cpf!} $password');
    var response = await service.login(cpf ?? this._cpf!, password);
    var user = response['result'];
    _createUserFromJson(user);
  }

  Future<Map<String, dynamic>> areaLogada() {
    return service.getAreaLogada();
  }

  Future<bool> changePassword({required String newPassword}) async {
    await this.service.changePassword(newPassword: newPassword, cpf: this.getCpf!.replaceAll(RegExp(r"[^0-9]"), ""));
    return true;
  }

  Future<String> validatTwoStep({
    required String code,
    required TwostepException twoStep,
    required String tipoId,
  }) async {
    await service.validateTwoStep(code: code, twoStep: twoStep, tipoId: tipoId);

    var body = jsonDecode(twoStep.request!.body)..['operacaoId'] = twoStep.id;
    twoStep.request!.body = jsonEncode(body);
    var response = await twoStep.request!.send();
    return response.stream.bytesToString();
  }

  _createUserFromJson(Map<String, dynamic> json) {
    _user = User.fromJson(json['cliente']);
    _user!.setCredentials(json);
    storage.write(key: 'user', value: jsonEncode(_user!.getCredentials()));
    notifyListeners();
  }

  tryAutoLogin() async {
    if (!await storage.containsKey(key: 'user')) {
      return false;
    }
    final Map<String, dynamic> credentials = jsonDecode(
      (await storage.read(key: 'user'))!,
    );
    credentials['expiresIn'] = DateTime.parse(credentials['expiresIn']);
    if (credentials['expiresIn'].isBefore(DateTime.now())) {
      return false;
    }

    this.credentials = credentials;
    var userData = await service.getClientData();
    _user = User.fromJson(userData['result']);
    this.credentials = credentials;
    notifyListeners();
    return true;
  }
}
