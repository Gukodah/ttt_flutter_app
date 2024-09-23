
import 'package:trigg_app/models/origem.dart';
import 'package:trigg_app/models/simple_type.dart';

class LancamentoFatura {
    LancamentoFatura({
        this.id,
        required this.origem,
        required this.valor,
        required this.data,
        required this.descricaoParcela,
        this.periodo,
        required this.plano,
        this.status,
        required this.moeda,
        required this.valorConvertido,
    });

    final dynamic id;
    final Origem origem;
    final double valor;
    final DateTime data;
    final String descricaoParcela;
    final dynamic periodo;
    final String plano;
    final dynamic status;
    final SimpleType moeda;
    final double valorConvertido;

    factory LancamentoFatura.fromJson(Map<String, dynamic> json) => LancamentoFatura(
        id: json["id"],
        origem: Origem.fromJson(json["origem"]),
        valor: json["valor"].toDouble(),
        data: DateTime.parse(json["data"]),
        descricaoParcela: json["descricaoParcela"],
        periodo: json["periodo"],
        plano: json["plano"],
        status: json["status"],
        moeda: SimpleType.fromJson(json["moeda"]),
        valorConvertido: json["valorConvertido"].toDouble(),
    );
}