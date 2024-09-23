import 'package:appsflyer_sdk/appsflyer_sdk.dart';

abstract class Appsflyer {
  static final Map _appsFlyerOptions = {
    "afDevKey": 'vVRodLTH5dpxSmyvL64j9k',
    "afAppId": '1173594355',
    "isDebug": true
  };

  static final AppsflyerSdk _appsflyerSdk = AppsflyerSdk(_appsFlyerOptions);

  static Future<dynamic> init() {
    return _appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );
  }

  static Future<bool?> logEvent(String name, Map values) {
    return _appsflyerSdk.logEvent(name, values);
  }
}
