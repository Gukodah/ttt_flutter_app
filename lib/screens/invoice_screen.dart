import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/models/fatura.dart';
import 'package:trigg_app/providers/card_provider.dart';
import 'package:trigg_app/providers/fatura_provider.dart';
import 'package:trigg_app/screens/payment_screen.dart';
import 'package:trigg_app/extension_methods/extended_num.dart';

class InvoiceScreen extends StatefulWidget {
  static const routeName = '/invoice';

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  String periodo = '';

  @override
  Widget build(BuildContext context) {
    final card = context.read<CardProvider>().card;
    final provider = context.watch<FaturaProvider>();
    final periodos = provider.periodos;

    if (periodo.isEmpty && card != null && card.statusFaturaAtual.id == 3) {
      periodo = card.periodo;
    }

    return Column(
      children: [
        if (periodos != null)
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: periodos.length,
              itemBuilder: (context, index) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 3,
                  ),
                  child: ListTile(
                    title: Text(periodos[index]),
                    onTap: () => setState(() => periodo = periodos[index]),
                  ),
                );
              },
            ),
          ),
        Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder<Fatura>(
              future: provider.getFatura(periodo),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.data == null) return Text('Erro');
                    Fatura fatura = snapshot.data!;
                    return Column(
                      children: [
                        Text(
                            "Vencimento: ${DateFormat.yMd().format(fatura.dataVencimento)}"),
                        Text("Valor: ${fatura.saldoFatura.toCurrencyString()}"),
                        if ((fatura.status.id == 1 &&
                                card!.statusFaturaAtual.id != 4) ||
                            fatura.status.id == 4)
                          ElevatedButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(PaymentScreen.routeName),
                              child: Text("Pagar")),
                        ...fatura.lancamentos
                            .map((lancamento) => Text(lancamento.origem.nome))
                            .toList()
                      ],
                    );
                  default:
                    return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
