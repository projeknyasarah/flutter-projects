import 'package:flutter/material.dart';
import 'themes.dart';

void main() {
  runApp(const BooksApp());
}

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultTheme,
      home: Scaffold( // ❗ TIDAK const
        appBar: AppBar(
          leading: const Icon(Icons.home),
          title: const Text("Books Listing"),
        ),
        body: const BooksListing(),
      ),
    );
  }
}

List<Map<String, dynamic>> bookData() {
  return [
    {
      'title': 'Book Title',
      'authors': ['Author1', 'Author2'],
      'image': 'assets/book_cover.png'
    },
    {
      'title': 'Book Title 2',
      'authors': ['Author1'],
      'image': 'assets/book_cover.png'
    }
  ];
}

class BooksListing extends StatelessWidget {
  const BooksListing({super.key});

  @override
  Widget build(BuildContext context) {
    final booksListing = bookData();

    return Theme(
      data: ThemeData(
        cardColor: Colors.pinkAccent,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 20),
          bodyMedium: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      child: ListView.builder(
        itemCount: booksListing.length,
        itemBuilder: (context, index) {
          return Card(
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
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Author(s): ${booksListing[index]['authors'].join(", ")}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    booksListing[index]['image'],
                    width: 60,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
