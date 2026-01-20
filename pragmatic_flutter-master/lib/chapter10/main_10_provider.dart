/// Switching Themes using Provider (FULL FIX)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'booklisting.dart';
import 'themes_notifier.dart';

/* =======================
   ENTRY POINT
   ======================= */

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemesNotifier(),
      child: BooksApp(),
    ),
  );
}

/* =======================
   APP ROOT
   ======================= */

class BooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemesNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.currentThemeData,
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.home),
          title: const Text("Books Listing"),
          actions: [
            IconButton(
              icon: const Icon(Icons.all_inclusive),
              onPressed: themeNotifier.switchTheme,
            ),
          ],
        ),
        body: BooksListing(),
      ),
    );
  }
}
