import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/providers/card_provider.dart';

class CardScreen extends StatelessWidget {
  static const routeName = "/cards";

  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cards = context.watch<CardProvider>().cards;

    return cards != null
        ? DefaultTabController(
            length: cards.length,
            child: Scaffold(
              appBar: AppBar(
                bottom: PreferredSize(
                  preferredSize: new Size(double.infinity, 150),
                  child: TabBar(
                    isScrollable: true,
                    tabs: [
                      ...cards
                          .map(
                            (card) => Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/welcome_background.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Tab(
                                child: Text(
                                  card.produtoTipo.nome!,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                          .toList()
                    ],
                  ),
                ),
              ),
              body: TabBarView(children: [
                ...cards
                    .map((e) =>
                        Center(child: Text("Final: ${e.numero.toString()}")))
                    .toList()
              ]),
            ))
        : CircularProgressIndicator();
  }
}
