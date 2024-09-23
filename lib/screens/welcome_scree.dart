import 'package:flutter/material.dart';
import 'package:trigg_app/screens/aquisicao/aquisicao_screen.dart';
import 'package:trigg_app/screens/login/get_cpf_screen.dart';
import 'package:trigg_app/screens/login_screen.dart';
import 'package:trigg_app/widgets/trigg_subtitle.dart';
import 'package:trigg_app/widgets/trigg_title.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/welcome_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: TriggTitle(color: Colors.white)),
            Container(
              margin: EdgeInsets.only(bottom: 48),
              child: TriggSubtitle(
                "O melhor lado da sua vida financeira é simples e descomplicado!",
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 18),
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AquisicaoScreen.routeName),
                child: Text("QUERO SER TRIGG"),
              ),
            ),
            Container(
              child: OutlinedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, LoginGetCpfScreen.routeName),
                child: Text("JÁ TENHO CADASTRO"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
