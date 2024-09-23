import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/providers/card_provider.dart';
import 'package:trigg_app/providers/eventos_provider.dart';
import 'package:trigg_app/providers/fatura_provider.dart';
import 'package:trigg_app/providers/user_provider.dart';
import 'package:trigg_app/routes.dart';
import 'package:trigg_app/screens/aquisicao/cadastro_basico/quase_la_screen.dart';
import 'package:trigg_app/screens/aquisicao/cadastro_informacoes/form_data_nascimento_screen.dart';
import 'package:trigg_app/screens/layout/main_screen.dart';
import 'package:trigg_app/screens/welcome_scree.dart';
import 'package:trigg_app/utils/analytics.dart';
import 'package:trigg_app/utils/appsflyer.dart';
import 'package:trigg_app/utils/trigg_navigator.dart';
import 'package:trigg_app/widgets/trigg_theme.dart';

Future main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    await _initalizeFirebaseDependencies();
    await Appsflyer.init();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.bottom,
        SystemUiOverlay.top,
      ],
    );
    runApp(AppWidget());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _initDynamicLinks(context);
    Intl.defaultLocale = 'pt_BR';

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CardProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EventosProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FaturaProvider(),
        )
      ],
      child: Consumer<UserProvider>(
        builder: (context, user, _) => MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('pt'),
          ],
          title: 'Trigg',
          theme: TriggTheme.theme(),
          home: user.isAuth ? _checkAreaLogada(user) : _autoLogin(user),
          routes: TriggRoutes.appRoutes,
          onGenerateRoute: TriggRoutes.nestedRoutes,
          navigatorKey: TriggNavigator.navigatorKey,
          navigatorObservers: [Analytics.getAnalyticsObserver()],
        ),
      ),
    );
  }

  FutureBuilder _autoLogin(UserProvider user) {
    return FutureBuilder(
        future: user.tryAutoLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return WelcomeScreen();
          }
          return CircularProgressIndicator();
        });
  }

  Widget _checkAreaLogada(UserProvider user) {
    return FutureBuilder<Map<String, dynamic>>(
        future: user.areaLogada(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) return WelcomeScreen();
            final Map result = snapshot.data!['result'];

            // CARTÃO DE CRÉDITO
            if (result['tipo']['id'] == 1) {
              switch (snapshot.data!['result']['tela']['id']) {
                case 2:
                case 1: // INICIO_CADASTRO
                  return QuaseLaScreen();
                case 5: // CONTA_ATIVADA
                  return MainScreen();
              }
            }

            // CP
            return Center(
              child: Scaffold(
                body: Center(child: Text("Crédito Pessoal")),
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }

  void _initDynamicLinks(context) async {
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        final Uri? deepLink = dynamicLink?.link;
        if (deepLink != null &&
            TriggRoutes.routes.any((route) => route.path == deepLink.path)) {
          TriggNavigator.pushNamed(deepLink.path);
        }
      },
      onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      },
    );

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null &&
        TriggRoutes.routes.any((route) => route.path == deepLink.path)) {
      TriggNavigator.pushNamed(deepLink.path);
    }
  }
}

Future<void> _initalizeFirebaseDependencies() async {
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {});
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  final RemoteConfig remoteConfig = RemoteConfig.instance;
  await remoteConfig.fetchAndActivate();
}
