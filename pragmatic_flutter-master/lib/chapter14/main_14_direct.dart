import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'book.dart';
import 'booktile.dart';
import 'book_details_page.dart';

void main() => runApp(const BooksApp());

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BooksListing(),
    );
  }
}

Future<List<BookModel>> makeHttpCall() async {
  final apiEndpoint = "AIzaSyAd6pQjaAn0BPM0HoyI1Zjs3un6X5eyej4"
      'https://www.googleapis.com/books/v1/volumes?q=flutter';

  final response = await http.get(Uri.parse(apiEndpoint));
  final jsonObject = json.decode(response.body);
  final list = jsonObject['items'] as List;

  return list.map((e) => BookModel.fromJson(e)).toList();
}

class BooksListing extends StatefulWidget {
  const BooksListing({super.key});

  @override
  State<BooksListing> createState() => _BooksListingState();
}

class _BooksListingState extends State<BooksListing> {
  List<BookModel> booksListing = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final response = await makeHttpCall();
    setState(() {
      booksListing = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      body: ListView.builder(
        itemCount: booksListing.length,
        itemBuilder: (context, index) {
          final book = booksListing[index];
          return BookTile(
            bookModelObj: book,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookDetailsPage(book: book),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
