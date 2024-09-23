import 'package:flutter/material.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/form_cpf_screen.dart';
import 'package:trigg_app/widgets/trigg_subtitle.dart';
import 'package:trigg_app/widgets/trigg_rich_container.dart';

class PedirCartaoScreen extends StatelessWidget {
  static const routeName = "/pedir-cartao";

  const PedirCartaoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/pedir_cartao_background.png',
                width: double.infinity,
              ),
              SizedBox(
                height: 24,
              ),
              TriggSubtitle(
                "Cartão de crédito Trigg",
                color: Colors.black,
                size: 32,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Suas compras acumulam Cashback e você tem 100% de controle no App.",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 24,
              ),
              TriggRichContainer(
                title: "Cashback em suas compras",
                bodyText:
                    "Você escolhe: use seu Cashback como descontos na fatura ou doações.",
                bodySize: 13,
              ),
              SizedBox(
                height: 16,
              ),
              TriggRichContainer(
                title: "Assistências e Seguros",
                bodyText:
                    "No app você contrata: proteção para o seu bolso, lar, automóvel e até para os pets.",
                bodySize: 13,
              ),
              SizedBox(
                height: 16,
              ),
              TriggRichContainer(
                title: "Cartões temáticos",
                bodyText:
                    "Bora viver o seu melhor lado com o cartão que é a sua cara. <3",
                bodySize: 13,
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(FormCpfScreen.routeName),
                  child: Text("PEDIR CARTÃO")),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ));
  }
}
