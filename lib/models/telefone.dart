import 'package:trigg_app/models/simple_type.dart';

class Telefone {
  final dynamic id;
  final SimpleType? tipo;
  final int ddd;
  final int numero;

  Telefone({
    this.id,
    this.tipo,
    required this.ddd,
    required this.numero,
  });

  factory Telefone.fromJson(Map<String, dynamic> json) => Telefone(
        id: json["id"],
        tipo: json["telefoneTipo"] == null
            ? null
            : SimpleType.fromJson(json["telefoneTipo"]),
        ddd: int.parse(json["ddd"]),
        numero: int.parse(json["numero"]),
      );

  factory Telefone.fromNumber(String number) {
    number = number.replaceAll(RegExp(r"[^0-9]"), "");
    return Telefone(
      ddd: int.parse(number.substring(0, 2)),
      numero: int.parse(number.substring(2)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "telefoneTipo": tipo != null ? tipo!.toJson() : null,
        "ddd": ddd,
        "numero": numero,
      };
}
