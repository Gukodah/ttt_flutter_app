import 'dart:ui';

import 'package:flutter/material.dart';

extension ExtendedColor on Color {
  static const Color blackTrigg = Color(0xFF29292B);
  static const Color mediumGrayTrigg = Color(0xFF9397A3);

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
