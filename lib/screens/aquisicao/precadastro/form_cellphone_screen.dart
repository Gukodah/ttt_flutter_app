import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/form_email_screen.dart';
import 'package:trigg_app/widgets/trigg_simple_form.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/models/prospect.dart';
import 'package:trigg_app/providers/prospect_provider.dart';

class FormCellphoneScreen extends StatelessWidget {
  const FormCellphoneScreen({Key? key}) : super(key: key);
  static const routeName = "/form/cellphone";

  @override
  Widget build(BuildContext context) {
    Map<String, String> _formData = {'cellphone': ''};
    ProspectProvider prospectProvider = context.watch<ProspectProvider>();
    Prospect prospect = prospectProvider.prospect!;
    final _controller =
        MaskedTextController(mask: "(00) 00000-0000", text: prospect.celular);

    _onSubmit() {
      prospect.celular = _formData['cellphone'];
      prospectProvider.save();
      Navigator.of(context).pushNamed(FormEmailScreen.routeName);
    }

    return TriggSimpleForm(
      subtitle: "Qual o seu número de celular com DDD?",
      onSubmit: _onSubmit,
      formFields: [
        SizedBox(height: 32),
        TextFormField(
          onSaved: (value) => _formData['cellphone'] = value!,
          decoration: InputDecoration(
            labelText: "Celular",
          ),
          validator: (value) {
            if (value!.isEmpty) return "Celular é obrigatório";
            if (value.replaceAll(RegExp(r"[^0-9]"), "").length != 11) {
              return "Digite seu telefone completo";
            }
          },
          controller: _controller,
        )
      ],
    );
  }
}
