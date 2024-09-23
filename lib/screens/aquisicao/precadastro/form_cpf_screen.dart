import 'package:flutter/material.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/form_name_screen.dart';
import 'package:trigg_app/validators/cpf_validator.dart';
import 'package:trigg_app/widgets/trigg_simple_form.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/models/prospect.dart';
import 'package:trigg_app/providers/prospect_provider.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class FormCpfScreen extends StatelessWidget {
  const FormCpfScreen({Key? key}) : super(key: key);
  static const routeName = "/form/cpf";

  @override
  Widget build(BuildContext context) {
    ProspectProvider prospectProvider = context.watch<ProspectProvider>();
    Prospect prospect = prospectProvider.prospect!;
    final _controller = MaskedTextController(
      mask: "000.000.000-00",
      text: prospect.cpf,
    );

    Map<String, String> _formData = {'cpf': ''};

    _onSubmit() {
      prospect.cpf = _formData['cpf'];
      prospectProvider.save();
      Navigator.of(context).pushNamed(FormNameScreen.routeName);
    }

    return TriggSimpleForm(
      subtitle: "Fala pra gente o seu CPF",
      onSubmit: _onSubmit,
      formFields: [
        SizedBox(height: 32),
        TextFormField(
          onSaved: (value) => _formData['cpf'] = value!,
          decoration: InputDecoration(
            labelText: "Qual o seu CPF?",
          ),
          validator: CpfValidator.validate,
          controller: _controller,
        )
      ],
    );
  }
}
