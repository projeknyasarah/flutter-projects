import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';
import 'booktile.dart';

/// Chapter13: Data Modeling (Part 1)
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

// Function to make REST API call
Future<dynamic> makeHttpCall() async {
  final apiEndpoint =
      "https://www.googleapis.com/books/v1/volumes?key=AIzaSyAd6pQjaAn0BPM0HoyI1Zjs3un6X5eyej4&q=python+coding";

  final http.Response response = await http.get(
    Uri.parse(apiEndpoint),
    headers: {'Accept': 'application/json'},
  );

  return json.decode(response.body);
}

class BooksListing extends StatefulWidget {
  @override
  State<BooksListing> createState() => _BooksListingState();
}

class _BooksListingState extends State<BooksListing> {
  List<dynamic>? booksListing;

  fetchBooks() async {
    final response = await makeHttpCall();
    setState(() {
      booksListing = response['items'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books Listing"),
      ),
      body: booksListing == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: booksListing!.length,
              itemBuilder: (context, index) {
                return BookTile(book: booksListing![index]);
              },
            ),
    );
  }
}
