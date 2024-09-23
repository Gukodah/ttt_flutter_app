import 'package:flutter/material.dart';
import 'package:trigg_app/extension_methods/extended_color.dart';
import 'package:trigg_app/widgets/trigg_password_field.dart';
import 'package:trigg_app/widgets/trigg_simple_form.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/models/prospect.dart';
import 'package:trigg_app/providers/prospect_provider.dart';

import 'form_cellphone_screen.dart';

class FormPasswordScreen extends StatefulWidget {
  FormPasswordScreen({Key? key}) : super(key: key);
  static const routeName = "/form/password";

  @override
  _FormPasswordScreenState createState() => _FormPasswordScreenState();
}

class _FormPasswordScreenState extends State<FormPasswordScreen> {
  final _passwordController = TextEditingController();
  final _passwordConfirmedController = TextEditingController();
  bool canSubmit = false;

  late Color textColorT1 = Theme.of(context).errorColor,
      textColorT2 = Theme.of(context).errorColor,
      textColorT3 = Theme.of(context).errorColor;

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordConfirmedController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {
        _validatePassword(_passwordController.text);
      });
    });
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ProspectProvider prospectProvider = context.watch<ProspectProvider>();
    Prospect prospect = prospectProvider.prospect!;

    _onSubmit() {
      prospect.senha = _passwordController.text;
      prospectProvider.save();

      setState(() {
        _validatePassword(_passwordController.text);
      });
      if (canSubmit) {
        Navigator.of(context).pushNamed(FormCellphoneScreen.routeName);
      }
    }

    return TriggSimpleForm(
      gkey: _formKey,
      subtitle: "Hora de criar sua senha",
      onSubmit: _onSubmit,
      formFields: [
        SizedBox(
          height: 8,
        ),
        RichText(
          text: new TextSpan(
            style: new TextStyle(
              fontSize: 16.0,
              color: ExtendedColor.mediumGrayTrigg,
            ),
            children: <TextSpan>[
              new TextSpan(
                  text: 'Anota aí:',
                  style: new TextStyle(fontWeight: FontWeight.bold)),
              new TextSpan(
                  text: ' você vai precisar dessa senha para acessar o app.')
            ],
          ),
        ),
        SizedBox(
          height: 32,
        ),
        TriggPasswordFieldWidget(
          controller: _passwordController,
          labelText: "Senha",
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.check_circle_outline,
                size: 15,
                color: textColorT1,
              ),
            ),
            Text(
              'Precisa ter 7 caracteres',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 13,
                  color: textColorT1,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.check_circle_outline,
                size: 15,
                color: textColorT2,
              ),
            ),
            Text(
              'Precisa ter uma letra',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 13,
                  color: textColorT2,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.check_circle_outline,
                size: 15,
                color: textColorT3,
              ),
            ),
            Text(
              'Precisa ter um numero',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 13,
                  color: textColorT3,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: 32,
        ),
        TriggPasswordFieldWidget(
          controller: _passwordConfirmedController,
          labelText: "Confirme sua senha",
          validator: (value) =>
              matchValidator(_passwordController.text, value!),
        ),
      ],
    );
  }

  String? matchValidator(String password, String passwordConfirmed) {
    if (passwordConfirmed.isEmpty)
      return 'Confirmação de senha não pode ser vazia';
    if (passwordConfirmed != password) return 'Senhas diferentes';
    return null;
  }

  void _validatePassword(String? password) {
    bool t1 = false, t2 = false, t3 = false;
    if (password != null) {
      if (password.length >= 7) {
        textColorT1 = Theme.of(context).primaryColor;
        t1 = true;
      } else {
        textColorT1 = Theme.of(context).errorColor;
        t1 = false;
      }
      if (password.contains(new RegExp("^(?=.*?[A-Za-z])"))) {
        textColorT2 = Theme.of(context).primaryColor;
        t2 = true;
      } else {
        textColorT2 = Theme.of(context).errorColor;
        t2 = false;
      }
      if (password.contains(new RegExp(r'[0-9]'))) {
        textColorT3 = Theme.of(context).primaryColor;
        t3 = true;
      } else {
        textColorT3 = Theme.of(context).errorColor;
        t3 = false;
      }
    }

    if (t1 && t2 && t3) {
      canSubmit = true;
    } else {
      canSubmit = false;
    }
  }
}
