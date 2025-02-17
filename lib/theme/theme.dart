import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    secondary: Colors.black,
    tertiary: Colors.white,
  )
);


ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.black,
    secondary: const Color.fromARGB(255, 255, 255, 255),
    tertiary: const Color.fromARGB(255, 65, 63, 63)
  )
);