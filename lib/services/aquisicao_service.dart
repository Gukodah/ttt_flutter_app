import 'package:trigg_app/models/prospect.dart';
import 'package:trigg_app/models/telefone.dart';
import 'package:trigg_app/services/main_service.dart';
import 'package:trigg_app/utils/sessao.dart';

class AqusicaoService extends MainService {
  Future<dynamic> preCadastro(Prospect prospect) async {
    return /*post(
      "/cadastro/aquisicao/?novaPoliticaSenha=true",
      data: {
        "cpf": prospect.cpf!.replaceAll(RegExp(r"[^0-9]"), ""),
        "email": prospect.email,
        "origem": 2,
        "produtoId": prospect.produto,
        "nomeCompleto": prospect.nome,
        "senha": prospect.senha,
        "sessao": await TriggSession.getSesion(),
        "telefone": Telefone.fromNumber(prospect.celular!).toJson()
      },
    );*/
        ;
  }

  Future<dynamic> saveBirthDate(String value) {
    return put('/cadastro/aquisicao/', data: {"dataNascimento": value});
  }
}
