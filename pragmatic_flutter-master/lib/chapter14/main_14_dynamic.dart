import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';
import 'book.dart';
import 'booktile.dart';
import 'book_details_page.dart';

void main() => runApp(BooksApp());

class BooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BooksListing(),
    );
  }
}

Future<List<BookModel>> makeHttpCall() async {
  final apiKey = "AIzaSyAd6pQjaAn0BPM0HoyI1Zjs3un6X5eyej4";
  final apiEndpoint =
      "https://www.googleapis.com/books/v1/volumes?key=AIzaSyAd6pQjaAn0BPM0HoyI1Zjs3un6X5eyej4q=flutter";

  final response = await http.get(Uri.parse(apiEndpoint));
  final jsonObject = json.decode(response.body);
  final list = jsonObject['items'] as List;

  return list.map((e) => BookModel.fromJson(e)).toList();
}

class BooksListing extends StatefulWidget {
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

  fetchBooks() async {
    final response = await makeHttpCall();
    setState(() {
      booksListing = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Books")),
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
