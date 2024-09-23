import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trigg_app/screens/aquisicao/precadastro/form_name_screen.dart';
import 'package:trigg_app/validators/data_nascimento_validator.dart';
import 'package:trigg_app/widgets/trigg_simple_form.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/models/prospect.dart';
import 'package:trigg_app/providers/prospect_provider.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class FormDataNascimentoScreen extends StatelessWidget {
  const FormDataNascimentoScreen({Key? key}) : super(key: key);
  static const routeName = "/form/dataNascimento";

  @override
  Widget build(BuildContext context) {
    ProspectProvider prospectProvider = context.watch<ProspectProvider>();
    Prospect prospect = prospectProvider.prospect!;
    final _controller = MaskedTextController(
      mask: "00/00/0000",
      text: prospect.dataNascimento,
    );

    Map<String, String> _formData = {'dataNascimento': ''};

    _onSubmit() {
      prospect.cpf = _formData['dataNascimento'];
      prospectProvider.save();
      Navigator.of(context).pushNamed(FormNameScreen.routeName);
    }

    return TriggSimpleForm(
      subtitle: "Qual a sua data de nascimento?",
      onSubmit: _onSubmit,
      formFields: [
        SizedBox(height: 32),
        TextFormField(
          onTap: () => {
            showDatePicker(
              context: context,
              initialDatePickerMode: DatePickerMode.year,
              initialDate: DateTime.now(),
              firstDate: DateTime(1910),
              lastDate: DateTime.now(),
              locale: Locale('pt'),
            ).then((date) => {
                  _controller.updateText(DateFormat('dd-MM-yyyy').format(date!))
                })
          },
          onSaved: (value) => _formData['dataNascimento'] = value!,
          decoration: InputDecoration(
            labelText: "Data de nascimento?",
          ),
          controller: _controller,
          validator: DataNascimentoValidator.validate,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        )
      ],
    );
  }
}
