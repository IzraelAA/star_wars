import 'package:flutter/material.dart';

class AppColors {
  // Global
  static const Color primaryColor = Color(0xFF01F4A6);

  static const MaterialColor colorSwatch = MaterialColor(
    0xff01f4a6, // Default/Primary Color
    <int, Color>{
      50: Color(0xFF99FBDB), //1
      100: Color(0xFF8dfbd7), //2
      200: Color(0xFF80FAD2), //3
      300: Color(0xFF40F7BC), //4
      400: Color(0xFF01F4A6), //5
      500: Color(0xFF1BE0A0), //6
      600: Color(0xFF0B9C6E), //7
      700: Color(0xFF0F7151), //8
      800: Color(0xFF13503C), //9
      900: Color(0xFF172F28), //10
    },
  );

  static const MaterialColor colorNeutral = MaterialColor(
    0xFFFFFFFF, // Default/Primary Color
    <int, Color>{
      50: Color(0xFFFFFFFF), //1
      100: Color(0xFFAAAAAA), //2
      200: Color(0xFF969696), //3
      300: Color(0xFF8C8C8C), //4
      400: Color(0xFF6F6F6F), //5
      500: Color(0xFF525252), //6
      600: Color(0xFF363636), //7
      700: Color(0xFF212121), //8
      800: Color(0xFF191919), //9
      900: Color(0xFF000000), //10
    },
  );

  static const background = Color(0xff1C1A29);
  static const textPrimary = Color(0xffffffff);
  static const Color textSecondary = Color(0xffaaaaaa);
  static const Color icon = Color(0xffffffff);
  static const Color iconGrey = Color(0xffaaaaaa);
  static const Color border = Color(0xff867AD2);
  static const Color yellow = Color(0xffF2C94C);
}
