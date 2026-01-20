import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Chapter 12: Integrating REST API
void main() {
  runApp(const BooksApp());
}

// Making HTTP request
Future<String> makeHttpCall() async {
  const apiEndpoint =
      "https://www.googleapis.com/books/v1/volumes?q=python+coding";

  final response = await http.get(
    Uri.parse(apiEndpoint),
    headers: {'Accept': 'application/json'},
  );

  return response.body;
}

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BooksListing(),
    );
  }
}

class BooksListing extends StatefulWidget {
  const BooksListing({super.key});

  @override
  State<BooksListing> createState() => _BooksListingState();
}

class _BooksListingState extends State<BooksListing> {
  String? booksResponse;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final response = await makeHttpCall();
    setState(() {
      booksResponse = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: booksResponse != null
              ? Text(
                  "Google Books API response:\n\n$booksResponse",
                  style: const TextStyle(fontSize: 12),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
