import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';
import 'bookmodel.dart';
import 'booktile.dart';

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
      "https://www.googleapis.com/books/v1/volumes?q=python+coding&key=$apiKey";

  final response = await http.get(
    Uri.parse(apiEndpoint),
    headers: {'Accept': 'application/json'},
  );

  final jsonObject = json.decode(response.body);
  final list = jsonObject['items'] as List;

  return list.map((e) => BookModel.fromJson(e)).toList();
}

class BooksListing extends StatefulWidget {
  @override
  _BooksListingState createState() => _BooksListingState();
}

class _BooksListingState extends State<BooksListing> {
  List<BookModel>? booksListing;

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
      appBar: AppBar(title: Text("Books Listing")),
      body: ListView.builder(
        itemCount: booksListing?.length ?? 0,
        itemBuilder: (context, index) {
          return BookTile(bookModelObj: booksListing![index]);
        },
      ),
    );
  }
}
