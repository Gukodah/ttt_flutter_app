class Prospect {
  String? cpf;
  String? nome;
  String? senha;
  String? celular;
  String? email;
  String? dataNascimento;
  int? produto;

  Prospect({
    this.cpf,
    this.nome,
    this.senha,
    this.celular,
    this.email,
    this.dataNascimento,
    this.produto,
  });

  factory Prospect.fromJson(Map<String, dynamic> json) => Prospect(
        cpf: json['cpf'],
        nome: json['nome'],
        senha: json['senha'],
        celular: json['celular'],
        email: json['email'],
        dataNascimento: json['dataNascimento'],
        produto: json['produto'],
      );

  Map<String, dynamic> toJson() => {
        "cpf": cpf,
        "nome": nome,
        "senha": senha,
        "celular": celular,
        "email": email,
        "produto": produto,
        "dataNascimento": dataNascimento
      };
}
