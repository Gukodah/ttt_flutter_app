class SimpleType {
  SimpleType({required this.id, this.nome, this.descricao});

  final dynamic id;
  final String? nome;
  final String? descricao;

  factory SimpleType.fromJson(Map<String, dynamic> json) => SimpleType(
      id: json["id"],
      nome: json["nome"] ?? null,
      descricao: json["descricao"] ?? null);

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "descricao": descricao,
      };
}
