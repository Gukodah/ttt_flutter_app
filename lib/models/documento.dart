import 'package:trigg_app/models/simple_type.dart';

class Documento {
  final dynamic id;
  final SimpleType documentoTipo;
  final String numero;
  final dynamic orgaoExpedidor;
  final dynamic dataEmissao;
  final dynamic ultimoInserido;
  final dynamic createdAt;
  final dynamic updatedAt;

  Documento({
    this.id,
    required this.documentoTipo,
    required this.numero,
    this.orgaoExpedidor,
    this.dataEmissao,
    this.ultimoInserido,
    this.createdAt,
    this.updatedAt,
  });

  factory Documento.fromJson(Map<String, dynamic> json) => Documento(
        id: json["id"],
        documentoTipo: SimpleType.fromJson(json["documentoTipo"]),
        numero: json["numero"],
        orgaoExpedidor: json["orgaoExpedidor"],
        dataEmissao: json["dataEmissao"],
        ultimoInserido: json["ultimoInserido"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );
}
