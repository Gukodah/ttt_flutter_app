import 'package:flutter/material.dart';
import 'package:trigg_app/widgets/trigg_app_bar.dart';

class PaymentScreen extends StatelessWidget {
  static const routeName = "/payment";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TriggAppBar(title: "Pagamento"),
      body: Center(child: Text("Pagamento")),
    );
  }
}
