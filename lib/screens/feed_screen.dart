import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/models/cartao.dart';
import 'package:trigg_app/models/evento.dart';
import 'package:trigg_app/providers/card_provider.dart';
import 'package:trigg_app/providers/eventos_provider.dart';

class FeedScreen extends StatelessWidget {
  static const routeName = '/feed';

  @override
  Widget build(BuildContext context) {
    final Cartao? card = context.watch<CardProvider>().card;
    final List<Evento>? events = card != null ? context.watch<EventosProvider>().events(card.numero) : null;

    return SingleChildScrollView(child: Column(
      children: [
        if (events != null) ...events.map((event) => Text(event.id)).toList()
        else CircularProgressIndicator()
      ],
    ));
  }
}