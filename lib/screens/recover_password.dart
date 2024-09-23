import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:trigg_app/providers/user_provider.dart';
import 'package:trigg_app/widgets/trigg_app_bar.dart';
import 'package:trigg_app/widgets/trigg_password_field.dart';

class RecoverPasswordScreen extends StatefulWidget {
  static final String routeName = '/recover-password';

  const RecoverPasswordScreen({Key? key}) : super(key: key);

  @override
  _RecoverPasswordScreenState createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationPasswordController =
      TextEditingController();
  bool _isLoading = false;
  bool _have7Characters = false;
  bool _haveLather = false;
  bool _haveNumber = false;
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.watch<UserProvider>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TriggAppBar(
        transparent: true,
      ),
      body: _body(userProvider),
    );
  }

  _body(UserProvider userProvider) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Esqueceu sua senha?',
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
                    'Crie uma nova para acessar o App',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 35),
                TriggPasswordFieldWidget(
                  controller: this._passwordController,
                  labelText: 'Cadastre uma nova senha',
                  onChanged: _verifyNewPassword,
                ),
                SizedBox(height: 10),
                _ruleRow(
                    disabled: 'Precisa ter 7 caracteres',
                    validator: this._have7Characters),
                SizedBox(height: 10),
                _ruleRow(
                    disabled: 'Precisa ter uma letra',
                    validator: this._haveLather),
                SizedBox(height: 10),
                _ruleRow(
                    disabled: 'Precisa ter um número',
                    validator: this._haveNumber),
                SizedBox(height: 30),
                TriggPasswordFieldWidget(
                  controller: this._confirmationPasswordController,
                  labelText: 'Confirme sua senha',
                ),
              ],
            ),
          ),
          _nextButton(userProvider, MediaQuery.of(context).size, context),
        ],
      ),
    );
  }

  _ruleRow({required String disabled, required bool validator}) {
    Color color = validator ? Theme.of(context).primaryColor : Colors.red;
    return Row(
      children: [
        Icon(Icons.verified_outlined, size: 17, color: color),
        SizedBox(width: 5),
        Text(
          disabled,
          style: TextStyle(color: color),
        )
      ],
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
          color: this._isValid ? Theme.of(context).primaryColor : Colors.grey,
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
    if (!this._isValid) return;
    if (this._passwordController.text !=
        this._confirmationPasswordController.text) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Algo deu errado',
            style: TextStyle(
              fontSize: 25,
              color: Theme.of(context).primaryColor,
            ),
          ),
          content: Text('As senhas não conferem'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Fechar'),
            )
          ],
        ),
      );
      return;
    }
    setState(() {
      this._isLoading = true;
    });
    try {
      bool canChange = await userProvider.changePassword(
        newPassword: this._passwordController.text,
      );
      print(canChange);
    } catch (e) {
      print('cancel action');
    }
    setState(() {
      this._isLoading = false;
    });
  }

  _verifyNewPassword(String newValue) {
    if (newValue.length >= 7) {
      setState(() {
        this._have7Characters = true;
      });
    } else {
      setState(() {
        this._have7Characters = false;
      });
    }
    if (newValue.contains(new RegExp("^(?=.*?[A-Za-z])"))) {
      setState(() {
        this._haveLather = true;
      });
    } else {
      setState(() {
        this._haveLather = false;
      });
    }
    if (newValue.contains(new RegExp(r'[0-9]'))) {
      setState(() {
        this._haveNumber = true;
      });
    } else {
      setState(() {
        this._haveNumber = false;
      });
    }

    setState(() {
      this._isValid =
          this._have7Characters && this._haveLather && this._haveNumber;
    });
  }
}
