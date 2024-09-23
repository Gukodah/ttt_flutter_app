import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/models/user.dart';
import 'package:trigg_app/providers/user_provider.dart';
import 'package:trigg_app/widgets/trigg_subtitle.dart';

class QuaseLaScreen extends StatelessWidget {
  const QuaseLaScreen({Key? key}) : super(key: key);
  static const routeName = "/quase-la";

  @override
  Widget build(BuildContext context) {
    final User user = context.watch<UserProvider>().user!;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TriggSubtitle(
              'Quase lá!',
              color: Colors.black,
            ),
            Text(
              "falta pouco pra você concluir seu pedido de análise do cartão de crédito.",
            ),
            Text("Usuário: " + user.pessoa!.nome)
          ],
        ),
      ),
    );
  }
}
