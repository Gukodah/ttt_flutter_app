import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/exceptions/api_exception.dart';
import 'package:trigg_app/extension_methods/extended_color.dart';
import 'package:trigg_app/providers/prospect_provider.dart';
import 'package:trigg_app/providers/user_provider.dart';
import 'package:trigg_app/utils/trigg_navigator.dart';
import 'package:trigg_app/widgets/trigg_checkbox_container.dart';
import 'package:trigg_app/widgets/trigg_subtitle.dart';

class FormAuthorizationScreen extends StatefulWidget {
  const FormAuthorizationScreen({Key? key}) : super(key: key);
  static const routeName = "/form/authorization";

  @override
  _FormAuthorizationScreenState createState() =>
      _FormAuthorizationScreenState();
}

class _FormAuthorizationScreenState extends State<FormAuthorizationScreen> {
  bool _acceptPolitics = false;
  bool _shareLocation = true;

  @override
  Widget build(BuildContext context) {
    ProspectProvider prospectProvider = context.watch<ProspectProvider>();
    UserProvider userProvider = context.watch<UserProvider>();

    _onSubmit() async {
      try {
        await prospectProvider.preCadastro();
        await userProvider.login(
          cpf: prospectProvider.prospect!.cpf!,
          password: prospectProvider.prospect!.senha!,
        );
        TriggNavigator.pushReplacementNamed("/");
      } on ApiException catch (error) {
        print(error.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message),
        ));
      } catch (_) {
        SnackBar(
          content: Text('Não foi possível efetuar o login'),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/icon_star.png',
            width: 100.0,
            height: 100.0,
          ),
          TriggSubtitle(
            "Precisamos da sua autorização para continuar",
            color: ExtendedColor.blackTrigg,
            size: 24,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          TriggCheckboxContainer(
              checkboxValue: _acceptPolitics,
              checkboxOnChanged: _onChangePolitics,
              textFields: [
                Text('Nossas políticas',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 13),
                    text: 'Li e concordo com a ',
                    children: [
                      TextSpan(
                        text:
                            'Política de Privacidade, Política de Crédito, Termos de Uso e Condições de Concessão de Crédito.',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ]),
          SizedBox(
            height: 16,
          ),
          TriggCheckboxContainer(
              checkboxValue: _shareLocation,
              checkboxOnChanged: _onChangeLocation,
              textFields: [
                Text('Localização',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                  'Vamos utilizar a sua localização para te manter por dentro de ofertas e parceiras perto de você.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 13),
                ),
              ]),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: _acceptPolitics && _shareLocation ? _onSubmit : null,
            child: Text("AVANÇAR"),
          ),
        ],
      ),
    );
  }

  void _onChangePolitics(bool? newValue) {
    setState(() {
      if (newValue != null) {
        _acceptPolitics = newValue;
      }
    });
  }

  void _onChangeLocation(bool? newValue) {
    setState(() {
      if (newValue != null) {
        _shareLocation = newValue;
      }
    });
  }
}
