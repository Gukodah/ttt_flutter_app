import 'package:flutter/material.dart';
import 'package:trigg_app/widgets/trigg_subtitle.dart';

class TriggSimpleForm extends StatelessWidget {
  final String subtitle;
  final List<Widget> formFields;
  final VoidCallback onSubmit;
  final AutovalidateMode? autovalidateMode;
  final GlobalKey<FormState>? gkey;

  const TriggSimpleForm({
    required this.subtitle,
    required this.formFields,
    required this.onSubmit,
    this.autovalidateMode,
    Key? key,
    this.gkey
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = gkey ?? GlobalKey();

    _submit() {
      if (!_formKey.currentState!.validate()) return;
      _formKey.currentState!.save();
      this.onSubmit();
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 123.0, left: 25.0, right: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TriggSubtitle(
              "Vamos precisar de alguns dados",
              color: Theme.of(context).primaryColor,
              size: 16,
            ),
            SizedBox(
              height: 8,
            ),
            TriggSubtitle(
              subtitle,
              color: Colors.black,
              size: 24,
            ),
            Form(
              key: _formKey,
              autovalidateMode: autovalidateMode != null
                  ? AutovalidateMode.onUserInteraction
                  : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...formFields,
                  SizedBox(height: 32),
                  ElevatedButton(onPressed: _submit, child: Text("AVANÇAR"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
