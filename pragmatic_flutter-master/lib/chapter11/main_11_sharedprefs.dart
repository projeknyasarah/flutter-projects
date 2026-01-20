import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'themes.dart';

/// ENTRY POINT
void main() {
  runApp(BooksApp());
}

/// ENUM WAJIB ADA (INI YANG HILANG TADI)
enum AppThemes { light, dark }

class BooksApp extends StatefulWidget {
  @override
  State<BooksApp> createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {
  AppThemes currentTheme = AppThemes.light;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  /// LOAD THEME FROM SHARED PREFS
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme_id') ?? AppThemes.light.index;

    setState(() {
      currentTheme = AppThemes.values[themeIndex];
    });
  }

  /// SAVE + SWITCH THEME
  Future<void> _switchTheme() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      currentTheme =
          currentTheme == AppThemes.light ? AppThemes.dark : AppThemes.light;
    });

    await prefs.setInt('theme_id', currentTheme.index);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: currentTheme == AppThemes.light
          ? defaultTheme
          : darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Books Listing'),
          actions: [
            IconButton(
              icon: const Icon(Icons.all_inclusive),
              onPressed: _switchTheme,
            )
          ],
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.book, size: 80),
          SizedBox(height: 20),
          Text(
            'SharedPreferences Theme Demo',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
