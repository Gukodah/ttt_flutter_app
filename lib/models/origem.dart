import 'package:trigg_app/models/simple_type.dart';

class Origem {
    Origem({
        required this.id,
        required this.nome,
        required this.categoria,
    });

    final String id;
    final String nome;
    final SimpleType categoria;

    factory Origem.fromJson(Map<String, dynamic> json) => Origem(
        id: json["id"],
        nome: json["nome"],
        categoria: SimpleType.fromJson(json["categoria"]),
    );
}