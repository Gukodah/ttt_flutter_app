import 'package:flutter/material.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/form_password_screen.dart';
import 'package:trigg_app/validators/fullname_validator.dart';
import 'package:trigg_app/widgets/trigg_simple_form.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/models/prospect.dart';
import 'package:trigg_app/providers/prospect_provider.dart';

class FormNameScreen extends StatelessWidget {
  const FormNameScreen({Key? key}) : super(key: key);
  static const routeName = "/form/name";

  @override
  Widget build(BuildContext context) {
    Map<String, String> _formData = {'name': ''};
    ProspectProvider prospectProvider = context.watch<ProspectProvider>();
    Prospect prospect = prospectProvider.prospect!;

    _onSubmit() {
      prospect.nome = _formData['name'];
      prospectProvider.save();
      Navigator.of(context).pushNamed(FormPasswordScreen.routeName);
    }

    return TriggSimpleForm(
      subtitle: "Fala pra gente o seu nome completo",
      onSubmit: _onSubmit,
      formFields: [
        SizedBox(height: 32),
        TextFormField(
          onSaved: (value) => _formData['name'] = value!,
          decoration: InputDecoration(labelText: "Nome completo"),
          validator: FullNameValidator.validate,
          initialValue: prospect.nome,
        )
      ],
    );
  }
}
