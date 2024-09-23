import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TriggPasswordFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String>? validator;
  late final Function? onChanged;

  TriggPasswordFieldWidget({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  _TriggPasswordFieldWidgetState createState() =>
      _TriggPasswordFieldWidgetState();
}

class _TriggPasswordFieldWidgetState extends State<TriggPasswordFieldWidget> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (String value) {
        if (this.widget.onChanged != null) {
          this.widget.onChanged!(value);
        }
      },
      controller: widget.controller,
      obscureText: isHidden,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        suffixIcon: IconButton(
          icon: isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
          onPressed: togglePasswordVisibility,
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      autofillHints: [AutofillHints.password],
      onEditingComplete: () => TextInput.finishAutofillContext(),
      validator: widget.validator,
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
