import 'package:flutter/material.dart';

/// Chapter 11 Themes (Flutter terbaru compatible)

final ThemeData defaultTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
    secondary: Colors.lightBlueAccent,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
);

final ThemeData pinkTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.pink,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.pink,
    brightness: Brightness.light,
    secondary: Colors.pinkAccent,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.pink,
    foregroundColor: Colors.white,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.orange,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.orange,
    brightness: Brightness.dark,
    secondary: Colors.yellowAccent,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.orange,
    foregroundColor: Colors.black,
  ),
);
