import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trigg_app/exceptions/twostep_exception.dart';
import 'package:trigg_app/services/main_service.dart';
import 'package:trigg_app/extension_methods/extended_string.dart';
import 'package:trigg_app/utils/sessao.dart';

class AuthService extends MainService {
  Future<dynamic> login(String cpf, String password) async {
    return post('/cadastro/auth/2', data: {
      "username": cpf.replaceAll(RegExp(r"[^0-9]"), ""),
      "password": await password.encrypt(),
      "grantType": {"id": 1},
      "sessao": await TriggSession.getSesion()
    });
  }

  Future<dynamic> getClientData() {
    return get('/cadastro/cliente/');
  }

  Future<Map<String, dynamic>> getAreaLogada() async {
    this.setUrl(dotenv.get("AREA_LOGADA_URL"));
    Map<String, dynamic> response = await get('/', noCache: true);
    this.setUrl(dotenv.get("API_URL"));
    return response;
  }

  Future<dynamic> changePassword({required String newPassword, required String cpf}) {
    Map<String, dynamic> data = {
      'value': newPassword,
    };
    return put('/cadastro/cliente/$cpf/redefinir-senha2/', data: data);
  }

  Future<dynamic> validateTwoStep({
    required TwostepException twoStep,
    required String tipoId,
    required String code,
  }) async {
    return post(
      '/cadastro/twostep/${twoStep.id}/cliente/${twoStep.cpf}/validar/',
      data: {'id': tipoId, 'value': code},
    );
  }
}
