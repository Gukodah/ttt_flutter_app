import 'package:flutter/material.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/aquisicao_type_screen.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/form_authorization_screen.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/form_cellphone_screen.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/form_cpf_screen.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/form_email_screen.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/form_name_screen.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/form_password_screen.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/pedir_cartao_screen.dart';

Route aquisicaoRoutes(RouteSettings settings) {
  late Widget page;
  print(settings.name);
  switch (settings.name) {
    case AquisicaoTypeScreen.routeName:
      page = AquisicaoTypeScreen();
      break;
    case PedirCartaoScreen.routeName:
      page = PedirCartaoScreen();
      break;
    case FormCpfScreen.routeName:
      page = FormCpfScreen();
      break;
    case FormNameScreen.routeName:
      page = FormNameScreen();
      break;
    case FormPasswordScreen.routeName:
      page = FormPasswordScreen();
      break;
    case FormCellphoneScreen.routeName:
      page = FormCellphoneScreen();
      break;
    case FormEmailScreen.routeName:
      page = FormEmailScreen();
      break;
    case FormAuthorizationScreen.routeName:
      page = FormAuthorizationScreen();
      break;
  }

  return MaterialPageRoute(builder: (_) => page, settings: settings);
}
