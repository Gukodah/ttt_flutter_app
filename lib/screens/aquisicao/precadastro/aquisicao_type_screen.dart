import 'package:flutter/material.dart';
import 'package:trigg_app/providers/prospect_provider.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/pedir_cartao_screen.dart';
import 'package:trigg_app/widgets/trigg_subtitle.dart';
import 'package:trigg_app/widgets/trigg_rich_container.dart';
import 'package:trigg_app/widgets/trigg_title.dart';
import 'package:provider/provider.dart';

class AquisicaoTypeScreen extends StatelessWidget {
  static const routeName = '/';

  const AquisicaoTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProspectProvider prospectProvider = context.watch<ProspectProvider>();

    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 1)],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      AssetImage('assets/images/register_type_background.png'),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    Expanded(
                      child: TriggTitle(color: Colors.white, size: 32),
                    ),
                    TriggSubtitle(
                      "Qual é a melhor opção de crédito para você hoje?",
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 32),
            child: Column(
              children: [
                TriggRichContainer(
                  title: "Cartão de Crédito",
                  bodyText:
                      "O cartão de crédito mais legal do mundo que devolve parte dos seus gastos!",
                  tag: "#Cashback!",
                  showIcon: true,
                  onTab: () {
                    prospectProvider.prospect!.produto = 2;
                    prospectProvider.save();
                    Navigator.of(context).pushNamed(
                      PedirCartaoScreen.routeName,
                    );
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TriggRichContainer(
                  title: "Trigg Empresta",
                  bodyText:
                      "O empréstimo pra você realizar seus sonhos, sair do sufoco, começar um negócio e muito mais!",
                  tag: "#SemPerrengue!",
                  showIcon: true,
                  // onTab: () {
                  //   prospectProvider.prospect!.produto = 1;
                  //   prospectProvider.save();
                  //   Navigator.of(context).pushNamed(
                  //     PedirCpScreen.routeName,
                  //   );
                  // },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
