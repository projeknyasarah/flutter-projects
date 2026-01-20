// Building BooksApp App's User Interface.
// Global theme demonstration
import 'package:flutter/material.dart';

/// Chapter10: Flutter Themes

void main() {
  runApp(const BooksApp());
}

/* =======================
   GLOBAL THEMES (FIXED)
   ======================= */

final ThemeData defaultTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  ),
  useMaterial3: true,
);

final ThemeData pinkTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.pink,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.orange,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);

/* =======================
   APP ROOT
   ======================= */

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultTheme,
      home: const BooksHome(),
    );
  }
}

class BooksHome extends StatelessWidget {
  const BooksHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: const Text("Books Listing"),
      ),
      body: const BooksListing(),
    );
  }
}

/* =======================
   DATA & LIST
   ======================= */

List<Map<String, dynamic>> bookData() {
  return [
    {
      'title': 'Book Title',
      'authors': ['Author1', 'Author2'],
      'image': 'assets/book_cover.png',
    },
    {
      'title': 'Book Title 2',
      'authors': ['Author1'],
      'image': 'assets/book_cover.png',
    }
  ];
}

class BooksListing extends StatelessWidget {
  const BooksListing({super.key});

  @override
  Widget build(BuildContext context) {
    final booksListing = bookData();

    return ListView.builder(
      itemCount: booksListing.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booksListing[index]['title'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Author(s): ${booksListing[index]['authors'].join(", ")}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  booksListing[index]['image'],
                  fit: BoxFit.fill,
                  width: 60,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
