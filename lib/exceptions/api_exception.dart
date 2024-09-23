import 'dart:convert';

import 'package:http/http.dart';

class ApiException implements Exception {
  Map<String, dynamic>? _body;
  String _message = "Algo deu errado, tente novamente mais tarde!";

  ApiException({
    Response? response,
    Map<String, dynamic>? responseBody,
  }) {
    if (response == null && responseBody == null) return;
    _body = response != null ? jsonDecode(response.body) : responseBody;

    if (_body != null && _body!['errors'] is List) {
      for (var error in _body!['errors']) {
        if (error != null && error['friendlyMessageError']) {
          _message = error['message'];
          return;
        }
      }
    }
  }

  Map<String, dynamic>? get body {
    return _body;
  }

  String get message {
    return _message;
  }
}
