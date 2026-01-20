import 'package:flutter/material.dart';

void main() => runApp(const BooksApp());

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
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
    },
    {
      'title': 'Book Title 2',
      'authors': ['Author1'],
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
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: const Icon(Icons.book),
            title: Text(booksListing[index]['title']),
            subtitle: Text(
              booksListing[index]['authors'].join(", "),
            ),
          ),
        );
      },
    );
  }
}
