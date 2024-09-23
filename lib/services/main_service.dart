import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trigg_app/exceptions/api_exception.dart';
import 'package:trigg_app/exceptions/twostep_exception.dart';
import 'package:trigg_app/models/user.dart';
import 'package:trigg_app/screens/twostep_screen.dart';
import 'package:trigg_app/services/mock_client.dart';
import 'package:trigg_app/utils/cache.dart';
import 'package:trigg_app/utils/trigg_navigator.dart';

abstract class MainService {
  String apiUrl = dotenv.get("API_URL");
  final _headers = {
    'Authorization': dotenv.get("API_AUTH"),
    'Content-Type': 'application/json'
  };

  get headers {
    if (User.instance is User && User.instance!.accessToken is String) {
      _headers['Authorization'] = "Bearer ${User.instance!.accessToken!}";
    }

    return _headers;
  }

  setUrl(String newUrl) {
    this.apiUrl = newUrl;
  }

  Future<dynamic> post(String path, {dynamic data}) {
    var method = dotenv.maybeGet('MOCK') == null ? http.post : mockClient.post;
    final url = Uri.parse("$apiUrl$path");

    debugPrint("Request POST: $url");
    debugPrint("Headers: $headers");
    debugPrint("Body: $data");
    return method(url, body: jsonEncode(data), headers: headers)
        .then((value) async => await _validateResponse(value));
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParams,
    bool noCache = false,
  }) async {
    var method = dotenv.maybeGet('MOCK') == null ? http.get : mockClient.get;

    Uri url = Uri.parse("$apiUrl$path");
    url = url.replace(queryParameters: queryParams);
    print(url.queryParameters);
    var file = await CustomCacheManager.instance
        .getSingleFile(url.toString(), headers: headers);
    if (await file.exists() && !noCache) {
      var res = await file.readAsString();
      return await _validateResponse(http.Response(res, 200));
    }
    return method(url, headers: headers)
        .then((value) async => await _validateResponse(value));
  }

  Future<dynamic> put(String path, {dynamic data}) {
    var method = dotenv.maybeGet('MOCK') == null ? http.put : mockClient.put;

    final url = Uri.parse("$apiUrl$path");
    return method(url, body: jsonEncode(data), headers: headers)
        .then((value) async => await _validateResponse(value));
  }

  Future<dynamic> delete(String path) {
    var method =
        dotenv.maybeGet('MOCK') == null ? http.delete : mockClient.delete;

    final url = Uri.parse("$apiUrl$path");
    return method(url, headers: headers)
        .then((value) async => await _validateResponse(value));
  }

  Future<dynamic> _validateResponse(http.Response response) async {
    Map<String, dynamic> body = jsonDecode(response.body);
    debugPrint("Reponse: $body");
    if (body['status'] == 200) return body;

    if (body['status'] == 302) {
      var oldRequest = response.request as http.Request;
      var newRequest = http.Request(oldRequest.method, oldRequest.url)
        ..encoding = oldRequest.encoding
        ..bodyBytes = oldRequest.bodyBytes
        ..headers.addAll(oldRequest.headers);
      final TwostepException twoStep = TwostepException.fromJson(body['result'])
        ..request = newRequest;

      await TriggNavigator.pushNamed(
        TwostepScreen.routeName,
        arguments: twoStep,
      ).then((value) async {
        body = jsonDecode(value!);
      });
    }

    if (body['status'] != 200) {
      throw ApiException(responseBody: body);
    }
    return body;
  }
}
