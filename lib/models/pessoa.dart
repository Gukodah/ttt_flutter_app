class Pessoa {
  final String nome;

  Pessoa({
    required this.nome,
  });

  factory Pessoa.fromJson(Map<String, dynamic> json) => Pessoa(
        nome: json["nome"],
      );
}
