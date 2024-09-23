import 'package:flutter/material.dart';

class TriggCheckboxContainer extends StatefulWidget {
  final bool checkboxValue;
  final ValueChanged<bool?> checkboxOnChanged;
  final List<Widget> textFields;

  const TriggCheckboxContainer({
    Key? key,
    required this.checkboxValue,
    required this.checkboxOnChanged,
    required this.textFields,
  }) : super(key: key);

  @override
  _TriggCheckboxContainerState createState() => _TriggCheckboxContainerState();
}

class _TriggCheckboxContainerState extends State<TriggCheckboxContainer> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    return Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0.5,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 120,
          padding: EdgeInsets.only(top: 16, bottom: 16, left: 2, right: 8),
          child: Row(
            children: [
              Checkbox(
                value: widget.checkboxValue,
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                onChanged: widget.checkboxOnChanged,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...widget.textFields,
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
