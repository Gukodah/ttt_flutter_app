import 'package:flutter/material.dart';

class TriggTitle extends StatelessWidget {
  final Color? color;
  final String text;
  final double? size;

  const TriggTitle({this.text = "Trigg", this.color, this.size, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6!.copyWith(
          color: color ?? Theme.of(context).primaryColor,
          fontSize: size ?? Theme.of(context).textTheme.headline6!.fontSize),
    );
  }
}
