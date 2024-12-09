import 'package:flutter/material.dart';

const primaryColorLight = Color(0xFF212121); // Dark Grey
const secondaryColorLight = Color(0xFFBDBDBD); // Light Grey
const backgroundColorLight = Color(0xFFE0E0E0); // Very Light Grey

const primaryColorDark = Color(0xFFFFFFFF); // White
const secondaryColorDark = Color(0xFF393939); // Dark Grey
const backgroundColorDark = Color(0xFF121212); // Almost Black

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Color(0XFFFFFFFF),
    secondary: Color(0XFFF0F2F5),
    primary:  Color(0XFF121B22),
    tertiary: Colors.white,
    inversePrimary: primaryColorLight,
  ),
  textTheme: Typography.blackCupertino,
  iconTheme: const IconThemeData(color: primaryColorLight),
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColorLight,
    foregroundColor: Colors.white,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color(0XFF121B22),
    primary: primaryColorDark,
    secondary: const Color(0XFF1F2C34),
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
  ),
  textTheme: Typography.whiteCupertino,
  iconTheme: const IconThemeData(color: primaryColorDark),
  appBarTheme: const AppBarTheme(
    backgroundColor: secondaryColorDark,
    foregroundColor: Colors.white,
  ),
);
