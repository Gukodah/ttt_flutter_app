import 'package:flutter/material.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/form_authorization_screen.dart';
import 'package:trigg_app/validators/email_validator.dart';
import 'package:trigg_app/widgets/trigg_simple_form.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/models/prospect.dart';
import 'package:trigg_app/providers/prospect_provider.dart';

class FormEmailScreen extends StatelessWidget {
  const FormEmailScreen({Key? key}) : super(key: key);
  static const routeName = "/form/email";

  @override
  Widget build(BuildContext context) {
    Map<String, String> _formData = {'email': ''};
    ProspectProvider prospectProvider = context.watch<ProspectProvider>();
    Prospect prospect = prospectProvider.prospect!;

    _onSubmit() {
      prospect.email = _formData['email'];
      prospectProvider.save();
      Navigator.of(context).pushNamed(FormAuthorizationScreen.routeName);
    }

    return TriggSimpleForm(
      subtitle: "Conta aqui qual é seu e-mail pessoal",
      onSubmit: _onSubmit,
      formFields: [
        SizedBox(height: 32),
        TextFormField(
          onSaved: (value) => _formData['email'] = value!,
          decoration: InputDecoration(
            labelText: "E-mail",
          ),
          validator: EmailValidator.validate,
          initialValue: prospect.email,
        )
      ],
    );
  }
}
