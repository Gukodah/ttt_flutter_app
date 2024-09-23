import 'package:http/http.dart';

class TwostepException implements Exception {
  final String id;
  final String cpf;
  final String detail;
  final List<dynamic> opcoes;
  
  Request? request;

  TwostepException({
    required this.id,
    required this.cpf,
    required this.detail,
    required this.opcoes,
  });

  factory TwostepException.fromJson(Map<String, dynamic> json) {
    return TwostepException(
      id: json['id'],
      cpf: json['cpf'],
      detail: json['detail'],
      opcoes: json['opcoes'],
    );
  }
}
