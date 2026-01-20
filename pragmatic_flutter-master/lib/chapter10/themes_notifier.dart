import 'package:flutter/material.dart';

class ThemesNotifier extends ChangeNotifier {
  bool _isDark = false;

  ThemeData get currentThemeData {
    return _isDark ? _darkTheme : _lightTheme;
  }

  void switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

/* =======================
   THEMES
   ======================= */

final ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
);

final ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.orange,
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
);
