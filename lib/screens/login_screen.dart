import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/exceptions/api_exception.dart';
import 'package:trigg_app/providers/user_provider.dart';
import 'package:trigg_app/validators/cpf_validator.dart';
import 'package:trigg_app/validators/password_validator.dart';
import 'package:trigg_app/widgets/trigg_app_bar.dart';
import 'package:trigg_app/widgets/trigg_title.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TriggAppBar(
        transparent: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: _deviceSize.height,
          width: _deviceSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TriggTitle(
                text: "Login",
              ),
              LoginForm()
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _formData = {'cpf': '', 'password': ''};
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "CPF"),
              keyboardType: TextInputType.number,
              maxLength: 11,
              validator: CpfValidator.validate,
              onSaved: (value) => _formData['cpf'] = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Senha"),
              obscureText: true,
              validator: PasswordValidator.validate,
              onSaved: (value) => _formData['password'] = value!,
            ),
            SizedBox(
              height: 20,
            ),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(onPressed: _submit, child: Text("Entrar"))
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    setState(() => _isLoading = true);
    try {
      await context
          .read<UserProvider>()
          .login(cpf: _formData['cpf']!, password: _formData['password']!);
      Navigator.pop(context);
    } on ApiException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message,
          ),
        ),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível efetuar o login'),
        ),
      );
    }

    setState(() => _isLoading = false);
  }
}
