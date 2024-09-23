import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:trigg_app/models/cartao.dart';
import 'package:trigg_app/services/card_service.dart';

class CardProvider with ChangeNotifier {
  final service = CardService();
  Cartao? _card;
  List<Cartao>? _cards;

  Cartao? get card {
    if (_card == null) {
      _getCard();
    }
    return _card;
  }

  List<Cartao>? get cards {
    if (_cards == null) {
      _getCards();
    }
    return _cards;
  }

  void _getCard() async {
    var response = await service.getCard();
    _card = Cartao.fromJson(response['result']);
    notifyListeners();
  }

  void _getCards() async {
    var response = await service.getCard(principal: false);
    _cards = List<Cartao>.from(
      response['result'].map(
        (card) => Cartao.fromJson(card),
      ),
    );
    notifyListeners();
  }
}
