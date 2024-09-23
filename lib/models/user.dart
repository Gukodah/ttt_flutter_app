import 'package:trigg_app/models/documento.dart';
import 'package:trigg_app/models/pessoa.dart';
import 'package:trigg_app/models/telefone.dart';

class User {
  final int? id;
  final String? email;
  final Pessoa? pessoa;
  final int? plataformaId;
  final List<Documento>? documentoList;
  final List<Telefone>? telefoneList;
  final int? statusSubscricao;
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  bool? deviceAutorizado;
  DateTime? expiresIn;

  static User? instance;

  User({
    required this.id,
    required this.email,
    required this.pessoa,
    required this.plataformaId,
    required this.documentoList,
    required this.telefoneList,
    required this.statusSubscricao,
  }) {
    instance = this;
  }

  User.empty({
    this.id,
    this.email,
    this.pessoa,
    this.plataformaId,
    this.documentoList,
    this.telefoneList,
    this.statusSubscricao,
  }) {
    instance = this;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: int.parse(json["id"]),
        email: json["email"],
        pessoa: Pessoa.fromJson(json["pessoa"]),
        plataformaId: json["plataformaId"],
        documentoList: List<Documento>.from(
            json["documentoList"].map((x) => Documento.fromJson(x))),
        telefoneList: List<Telefone>.from(
            json["telefoneList"].map((x) => Telefone.fromJson(x))),
        statusSubscricao: json["statusSubscricao"],
      );

  setCredentials(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    tokenType = json['tokenType'];
    deviceAutorizado = json['deviceAutorizado'];
    expiresIn = json['expiresIn'].runtimeType == DateTime
        ? json['expiresIn']
        : DateTime.now().add(Duration(seconds: json['expiresIn']));
  }

  Map<String, dynamic> getCredentials() {
    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "tokenType": tokenType,
      "deviceAutorizado": deviceAutorizado,
      "expiresIn": expiresIn?.toIso8601String()
    };
  }
}
