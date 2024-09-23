import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class TriggSession {
  static Future<Map<String, String>> getSesion() async {
    Map<String, String> session = {
      'pushUID': await FirebaseMessaging.instance.getToken() ?? ''
    };

    if (Platform.isAndroid) {
      session.addAll(await _androidSession());
    } else {
      session.addAll(await _iosSession());
    }

    return session;
  }

  static Future<Map<String, String>> _androidSession() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    return {
      'fingerPrint': deviceInfo.androidId!,
      'modelo': deviceInfo.model!,
      'sistemaOperacional': "Android ${deviceInfo.version.release!}",
      'plataformaId': "1"
    };
  }

  static Future<Map<String, String>> _iosSession() async {
    final deviceInfo = await DeviceInfoPlugin().iosInfo;
    return {
      'fingerPrint': deviceInfo.identifierForVendor!,
      'modelo': deviceInfo.model!,
      'sistemaOperacional': "IOS ${deviceInfo.systemVersion!}",
      'plataformaId': "2"
    };
  }
}
