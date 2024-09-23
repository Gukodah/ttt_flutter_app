import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:trigg_app/exceptions/api_exception.dart';

var mockClient = MockClient((request) async {
  print(request.url.path);
  print("CALL MOCK");
  switch (request.url.path) {
    case "/cadastro/auth/2":
      Map<String, dynamic> body = jsonDecode(request.body);
      if (body['senha'] == 'invalid') {
        throw ApiException(responseBody: {
          'errors': [
            {"message": "Senha inválida", "friendlyMessageError": true}
          ]
        });
      }
      return Response(
        await rootBundle.loadString('assets/mock/login.json'),
        200,
      );
    default:
      return Response(
        "A Url que você está tentando acessar não está mockada",
        404,
      );
  }
});
