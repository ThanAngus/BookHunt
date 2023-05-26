import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF5E56E7);
  static const Color lightGrey = Color(0xFFF0F0F6);
  static const Color grey = Color(0xFFA0A0A0);
  static const Color darkGrey = Color(0xFF333333);
  static const Color white = Color(0xFFF8F7FF);

  static const MaterialColor primarySwatch = MaterialColor(
    0xFF5E56E7,
    <int, Color>{
      50: Color(0xFFF0EEF8),
      100: Color(0xFFD0CFF1),
      200: Color(0xFFABA9E8),
      300: Color(0xFF8684DF),
      400: Color(0xFF6966D9),
      500: Color(0xFF5E56E7),
      600: Color(0xFF534ED6),
      700: Color(0xFF4746C4),
      800: Color(0xFF3C3FAD),
      900: Color(0xFF303594),
    },
  );
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
