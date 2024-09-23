import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trigg_app/providers/user_provider.dart';

void main() async {
  late UserProvider userProvider;
  group("User Provider Tests", () {
    setUp(() {
      dotenv.testLoad(fileInput: File('.env.mock').readAsStringSync());
      userProvider = UserProvider();
    });

    test('User should be logout at start', () {
      expect(userProvider.isAuth, false);
    });

    test('User should be not auth with expired token', () async {
      userProvider.credentials = {
        "accessToken": "example_access_token",
        "expiresIn": 0
      };
      expect(userProvider.isAuth, false);
    });

    test('User should be auth with not expired token', () async {
      userProvider.credentials = {
        "accessToken": "example_access_token",
        "expiresIn": 100
      };
      expect(userProvider.isAuth, true);
    });
  });
}
