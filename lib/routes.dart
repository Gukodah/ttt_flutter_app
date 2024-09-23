import 'package:flutter/material.dart';
import 'package:trigg_app/screens/aquisicao/cadastro_informacoes/form_data_nascimento_screen.dart';
import 'package:trigg_app/screens/aquisicao/cadastro_informacoes/form_estado_civil_screen.dart';
import 'package:trigg_app/screens/aquisicao/cadastro_informacoes/form_id_front_photo_preview_screen.dart';
import 'package:trigg_app/screens/card_screen.dart';
import 'package:trigg_app/screens/feed_screen.dart';
import 'package:trigg_app/screens/invoice_screen.dart';
import 'package:trigg_app/screens/aquisicao/aquisicao_screen.dart';
import 'package:trigg_app/screens/login/get_cpf_screen.dart';
import 'package:trigg_app/screens/login/get_password_screen.dart';
import 'package:trigg_app/screens/login_screen.dart';
import 'package:trigg_app/screens/payment_screen.dart';
import 'package:trigg_app/screens/recover_password.dart';
import 'package:trigg_app/screens/store_screen.dart';
import 'package:trigg_app/screens/twostep_screen.dart';

class RouteModel {
  final String path;
  final Widget screen;
  final String title;
  final Icon? icon;

  RouteModel(this.path, this.screen, this.title, {this.icon});
}

class TriggRoutes {
  static final List<RouteModel> _routes = [
    RouteModel(LoginScreen.routeName, LoginScreen(), "Login"),
    RouteModel(LoginGetCpfScreen.routeName, LoginGetCpfScreen(), "Login-cpf"),
    RouteModel(LoginGetPasswordScreen.routeName, LoginGetPasswordScreen(),
        "Login-password"),
    RouteModel(TwostepScreen.routeName, TwostepScreen(), "Twostep"),
    RouteModel(FormIdFrontPhotoPreviewScreen.routeName,
        FormIdFrontPhotoPreviewScreen(), 'Id-front-photo'),
    RouteModel(RecoverPasswordScreen.routeName, RecoverPasswordScreen(),
        'Recover-password'),
    RouteModel(FormDataNascimentoScreen.routeName, FormDataNascimentoScreen(),
        'dataNascimento'),
    RouteModel(FormEstadoCivilScreen.routeName, FormEstadoCivilScreen(),
        'Estado-civil'),
    RouteModel(FeedScreen.routeName, FeedScreen(), "Início",
        icon: Icon(Icons.home)),
    RouteModel(InvoiceScreen.routeName, InvoiceScreen(), "Fatura",
        icon: Icon(Icons.fact_check_outlined)),
    RouteModel(StoreScreen.routeName, StoreScreen(), "Store",
        icon: Icon(Icons.add)),
    RouteModel(CardScreen.routeName, CardScreen(), "Cartão",
        icon: Icon(Icons.credit_card)),
    RouteModel(FeedScreen.routeName, FeedScreen(), "Benefícios",
        icon: Icon(Icons.star_border)),

    // Context Routes
    RouteModel(PaymentScreen.routeName, PaymentScreen(), "Pagamento"),
  ];

  static Map<String, WidgetBuilder> get appRoutes {
    Map<String, WidgetBuilder> routes = {};
    _routes.forEach((element) {
      routes[element.path] = (_) => element.screen;
    });

    return routes;
  }

  static List<RouteModel> get routes {
    return _routes;
  }

  static Route nestedRoutes(RouteSettings settings) {
    late Widget page;

    if (settings.name!.startsWith(AquisicaoScreen.routeName)) {
      page = AquisicaoScreen(
          pageRoute:
              settings.name!.substring(AquisicaoScreen.routeName.length));
    }

    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}
