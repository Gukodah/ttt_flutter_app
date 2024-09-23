import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/exceptions/api_exception.dart';
import 'package:trigg_app/exceptions/twostep_exception.dart';
import 'package:trigg_app/providers/user_provider.dart';
import 'package:trigg_app/widgets/trigg_app_bar.dart';

class TwostepScreen extends StatefulWidget {
  static const routeName = "/twostep";

  @override
  _TwostepScreenState createState() => _TwostepScreenState();
}

class _TwostepScreenState extends State<TwostepScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _formData = {'code': ''};
  String _tipoId = '';
  bool _isLoading = false;

  Future<void> _submit(TwostepException twoStep) async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _isLoading = true);
    try {
      String result = await context.read<UserProvider>().validatTwoStep(
            code: _formData['code']!,
            tipoId: _tipoId,
            twoStep: twoStep,
          );
      Navigator.pop<String>(context, result);
    } catch (_) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Não foi possível validar o código")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final twostep =
        ModalRoute.of(context)!.settings.arguments as TwostepException;
    var sended =
        twostep.opcoes.firstWhere((option) => option['enviadoAutomaticamente']);
    if (_tipoId == '') {
      _tipoId = sended['id'];
    }

    return Scaffold(
      appBar: TriggAppBar(title: "Validação de segurança"),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Para garantir sua segurança, enviamos um código de confirmação via ${sended['tipo']['descricao']} para ${sended['conteudo']['destinoFormatado']}',
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Código"),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _formData['code'] = value!,
                  ),
                  ...twostep.opcoes
                      .map((option) => ListTile(
                            title: Text(
                                "Recebi o código por ${option['tipo']['descricao']}"),
                            leading: Radio<String>(
                              groupValue: _tipoId,
                              value: option['id'],
                              onChanged: (value) =>
                                  setState(() => _tipoId = value!),
                            ),
                          ))
                      .toList(),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    ElevatedButton(
                        onPressed: () => _submit(twostep),
                        child: Text("Entrar"))
                ],
              ),
            )),
      ),
    );
  }
}
