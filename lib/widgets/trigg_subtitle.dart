import 'package:flutter/material.dart';

class TriggSubtitle extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final TextAlign? textAlign;
  final bool verticallyCentered;

  const TriggSubtitle(
    this.text, {
    this.verticallyCentered = false,
    this.color,
    this.size,
    this.textAlign,
    Key? key,
  }) : super(key: key);

  const TriggSubtitle.verticallyCentered(
    this.text, {
    this.verticallyCentered = true,
    this.color,
    this.size,
    this.textAlign,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return verticallyCentered
        ? Center(
            child: Text(
              text,
              textAlign: textAlign,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: color ?? Colors.white, fontSize: size),
            ),
          )
        : Text(
            text,
            textAlign: textAlign,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: color ?? Colors.white, fontSize: size),
          );
  }
}
