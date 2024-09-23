import 'package:flutter/material.dart';
import 'package:trigg_app/widgets/trigg_select_box.dart';
import 'package:trigg_app/widgets/trigg_simple_form.dart';

class FormEstadoCivilScreen extends StatelessWidget {
  const FormEstadoCivilScreen({Key? key}) : super(key: key);
  static String routeName = "form/estadoCivil";

  void _onSubimit() {}

  @override
  Widget build(BuildContext context) {
    return TriggSimpleForm(
      subtitle: "Qual a sua data de nascimento?",
      onSubmit: _onSubimit,
      formFields: [
        SizedBox(height: 32),
        TriggSelectBox(
          itemCollection: [
            SelectBoxItem<String>(id: "solteiro", value: "Solteiro(a)"),
            SelectBoxItem<String>(id: "casado", value: "Casado(a)"),
            SelectBoxItem<String>(id: "separado", value: "Separado(a)"),
            SelectBoxItem<String>(id: "divorciado", value: "Divorciado(a)"),
            SelectBoxItem<String>(id: "viuvo", value: "Víuvo(a)"),
          ],
        )
      ],
    );
  }
}
