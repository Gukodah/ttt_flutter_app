import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/providers/prospect_provider.dart';
import 'package:trigg_app/screens/aquisicao/aquisicao_routes.dart';
import 'package:trigg_app/screens/aquisicao/cadastro_informacoes/form_data_nascimento_screen.dart';
import 'package:trigg_app/screens/aquisicao/cadastro_informacoes/form_estado_civil_screen.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/form_cellphone_screen.dart';
import 'package:trigg_app/utils/analytics.dart';
import 'package:trigg_app/widgets/trigg_app_bar.dart';

class AquisicaoScreen extends StatefulWidget {
  static const routeName = "/aquisicao";
  final String pageRoute;

  const AquisicaoScreen({required this.pageRoute, Key? key}) : super(key: key);

  @override
  _AquisicaoScreenState createState() => _AquisicaoScreenState();
}

class _AquisicaoScreenState extends State<AquisicaoScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  void _pop() {
    _navigatorKey.currentState!.canPop()
        ? _navigatorKey.currentState!.pop()
        : Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProspectProvider(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: TriggAppBar(
          transparent: true,
          customPop: _pop,
        ),
        body: FormEstadoCivilScreen(),
      ),
    );
  }
}
