import 'package:flutter/material.dart';
import 'dart:ui';

class AppColor {
  static Color primaryColor = Color(0xFF2D2A8D);
  static Color whiteColor = Colors.white;
  static Color brandColor = Color(0xFF2E3192);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
