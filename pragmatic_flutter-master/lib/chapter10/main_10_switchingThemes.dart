import 'package:flutter/material.dart';
import 'themes.dart';

void main() {
  runApp(const BooksApp());
}

enum AppThemes { light, dark }

class BooksApp extends StatefulWidget {
  const BooksApp({super.key});

  @override
  State<BooksApp> createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {
  AppThemes currentTheme = AppThemes.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: currentTheme == AppThemes.light ? defaultTheme : darkTheme,
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.home),
          title: const Text("Books Listing"),
          actions: [
            IconButton(
              icon: const Icon(Icons.all_inclusive),
              onPressed: () {
                setState(() {
                  currentTheme = currentTheme == AppThemes.light
                      ? AppThemes.dark
                      : AppThemes.light;
                });
              },
            ),
          ],
        ),
        body: const BooksListing(),
      ),
    );
  }
}

/* =======================
   DUMMY DATA
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
    },
  ];
}

/* =======================
   UI LIST
   ======================= */

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
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8),
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
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
