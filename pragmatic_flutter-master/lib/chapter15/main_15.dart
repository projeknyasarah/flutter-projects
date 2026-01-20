import 'package:flutter/material.dart';
import 'api_service.dart';
import 'book.dart';
import 'booktile.dart';
import 'book_details_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Books Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BookListPage(),
    );
  }
}

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final ApiService api = ApiService();

  late Future<List<Book>> booksFuture;

  @override
  void initState() {
    super.initState();
    booksFuture = api.fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Books API")),
      body: FutureBuilder<List<Book>>(
        future: booksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final books = snapshot.data ?? [];

          if (books.isEmpty) {
            return const Center(child: Text("Tidak ada buku ditemukan."));
          }

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return BookTile(
                book: books[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookDetailsPage(book: books[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
