import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:trigg_app/exceptions/api_exception.dart';
import 'package:trigg_app/providers/user_provider.dart';
import 'package:trigg_app/widgets/trigg_app_bar.dart';
import 'package:trigg_app/widgets/trigg_password_field.dart';

class LoginGetPasswordScreen extends StatefulWidget {
  static const routeName = "/login/password";

  const LoginGetPasswordScreen({Key? key}) : super(key: key);

  @override
  _LoginGetPasswordScreenState createState() => _LoginGetPasswordScreenState();
}

class _LoginGetPasswordScreenState extends State<LoginGetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
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
                      'Tudo certo!',
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
                      'Qual sua senha de acesso ao App?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TriggPasswordFieldWidget(
                    controller: this._passwordController,
                    labelText: 'Senha',
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/recover-password');
                    },
                    child: Container(
                      width: 180,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFD5D5D5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Esqueci minha senha',
                            style: TextStyle(
                              color: Color(0xFF85878E),
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 13,
                            color: Color(0xFF85878E),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _nextButton(userProvider, _deviceSize, context),
          ],
        ),
      ),
    );
  }

  _nextButton(
    UserProvider userProvider,
    Size _deviceSize,
    BuildContext context,
  ) {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: () => _onTapNext(userProvider),
        child: Container(
          alignment: Alignment.center,
          width: _deviceSize.width,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: this._isLoading
                ? SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
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

  _onTapNext(UserProvider userProvider) async {
    if (this._passwordController.text.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preencha a senha'),
        ),
      );
      return;
    }
    setState(() {
      this._isLoading = true;
    });
    try {
      await userProvider.login(password: this._passwordController.text);
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Error on login request');
      debugPrint('Verify .env file and the VPN service');
      _showLoginError();
    }
    setState(() {
      this._isLoading = false;
    });
  }

  _showLoginError() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Ops... Algo deu errado',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child:
                        Text('Verifique se preencheu os dados corretamente.'),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Verifique sua conexão com a internet'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Fechar'),
              ),
            ],
          );
        });
  }
}
