import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/providers/user_provider.dart';
import 'package:trigg_app/screens/login/get_password_screen.dart';
import 'package:trigg_app/validators/cpf_validator.dart';
import 'package:trigg_app/widgets/trigg_app_bar.dart';

class LoginGetCpfScreen extends StatefulWidget {
  static const routeName = "/login/cpf";

  const LoginGetCpfScreen({Key? key}) : super(key: key);

  @override
  _LoginGetCpfScreenState createState() => _LoginGetCpfScreenState();
}

class _LoginGetCpfScreenState extends State<LoginGetCpfScreen> {
  final MaskedTextController _cpfController = MaskedTextController(
    mask: "000.000.000-00",
  );

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TriggAppBar(
        transparent: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Vamos Precisar de alguns dados',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Fala pra gente seu CPF',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: this._cpfController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Qual seu CPF?",
                    ),
                    validator: CpfValidator.validate,
                  ),
                ],
              ),
            ),
            _nextButton(context, userProvider)
          ],
        ),
      ),
    );
  }

  _nextButton(BuildContext context, UserProvider userProvider) {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: () => _onTapNext(userProvider),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Text(
              "AVANÇAR",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTapNext(UserProvider userProvider) {
    String? validationMessage = CpfValidator.validate(this._cpfController.text);
    if (validationMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validationMessage),
        ),
      );
      return;
    }
    userProvider.setCpf(this._cpfController.text);
    Navigator.pushNamed(context, LoginGetPasswordScreen.routeName);
  }
}
