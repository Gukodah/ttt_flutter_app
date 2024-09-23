import 'package:trigg_app/models/simple_type.dart';

class AumentoLimiteConcedido {
    AumentoLimiteConcedido({
        required this.novoValor,
        required this.status,
        required this.dataInclusao,
    });

    final int novoValor;
    final SimpleType status;
    final DateTime dataInclusao;

    factory AumentoLimiteConcedido.fromJson(Map<String, dynamic> json) => AumentoLimiteConcedido(
        novoValor: json["novoValor"],
        status: SimpleType.fromJson(json["status"]),
        dataInclusao: DateTime.parse(json["dataInclusao"]),
    );
}