import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:encrypt/encrypt.dart';

extension ExtendedString on String {
  Future<String> encrypt() async {
    final parser = new RSAKeyParser();
    final publicKey = parser.parse(
      await rootBundle.loadString('assets/rsa/key.pem'),
    );
    final encrypter = Encrypter(RSA(publicKey: publicKey as RSAPublicKey));
    return encrypter.encrypt(this).base64;
  }
}
