import 'package:flutter/material.dart';

abstract class TriggTheme {
  static ThemeData theme() {
    return ThemeData(
      primarySwatch: getTriggColors(),
      scaffoldBackgroundColor: Color(0xfff0f2f5),
      textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'Sofia',
              fontSize: 65,
            ),
            headline5: TextStyle(
              fontSize: 38,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              height: 1.2,
              fontFamily: "Nunito",
            ),
          ),
      inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: _buttonStyle()),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _buttonStyle(border: true),
      ),
      errorColor: Color(0xffE62350),
      appBarTheme:
          ThemeData.light().appBarTheme.copyWith(foregroundColor: Colors.white),
    );
  }
}

ButtonStyle _buttonStyle({bool border = false}) {
  return ButtonStyle(
      minimumSize: MaterialStateProperty.all(Size(double.infinity, 30)),
      padding: MaterialStateProperty.all(EdgeInsets.all(27)),
      textStyle:
          MaterialStateProperty.all(TextStyle(fontWeight: FontWeight.bold)),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      side: border
          ? MaterialStateProperty.all(BorderSide(
              color: Colors.white,
              style: BorderStyle.solid,
            ))
          : null);
}

getTriggColors() {
  final color = Color(0xFF00bab3);

  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;
  final lowStep = (1.0 - lightness) / 6;
  final highStep = lightness / 5;

  return MaterialColor(color.value, {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  });
}
