import 'dart:ffi';

import 'package:flutter/material.dart';

class TriggPopButton extends StatelessWidget {
  final customPop;
  final Color? iconColor;
  final double? iconSize;
  const TriggPopButton(
      {Key? key, this.customPop, this.iconColor, this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize ?? 24.0,
      onPressed: customPop ?? () => Navigator.of(context).pop(),
      icon: Icon(
        Icons.chevron_left,
        color: iconColor ?? Colors.black,
      ),
    );
  }
}
