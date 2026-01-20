/// Switching Themes using InheritedWidget (FULL FIX)
import 'package:flutter/material.dart';

import 'booklisting.dart';

void main() {
  runApp(BooksApp());
}

/* =======================
   APP ROOT
   ======================= */

class BooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RootWidget(
      child: BooksAppScreen(
        child: BooksListing(), // ⬅️ TIDAK const
      ),
    );
  }
}

/* =======================
   ROOT + INHERITED
   ======================= */

class RootWidget extends StatefulWidget {
  final Widget child;

  const RootWidget({super.key, required this.child});

  static RootWidgetState of(BuildContext context) {
    final MyInheritedWidget? inherited =
        context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
    return inherited!.data;
  }

  @override
  State<RootWidget> createState() => RootWidgetState();
}

class RootWidgetState extends State<RootWidget> {
  MyThemes _currentTheme = MyThemes.light;

  MyThemes get currentTheme => _currentTheme;

  void switchTheme() {
    setState(() {
      _currentTheme =
          _currentTheme == MyThemes.light ? MyThemes.dark : MyThemes.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      data: this,
      child: widget.child,
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final RootWidgetState data;

  const MyInheritedWidget({
    super.key,
    required Widget child,
    required this.data,
  }) : super(child: child);

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) => true;
}

/* =======================
   UI LAYER
   ======================= */

class BooksAppScreen extends StatelessWidget {
  final Widget child;

  const BooksAppScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final root = RootWidget.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: root.currentTheme == MyThemes.light
          ? themeData[0]
          : themeData[1],
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.home),
          title: const Text("Books Listing"),
          actions: [
            IconButton(
              icon: const Icon(Icons.all_inclusive),
              onPressed: root.switchTheme,
            ),
          ],
        ),
        body: child,
      ),
    );
  }
}

/* =======================
   THEMES
   ======================= */

enum MyThemes { light, dark }

final List<ThemeData> themeData = [
  ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  ),
  ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.orange,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  ),
];
