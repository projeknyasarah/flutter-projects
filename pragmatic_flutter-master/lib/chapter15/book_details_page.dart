import 'package:flutter/material.dart';
import 'book.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;

  const BookDetailsPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final info = book.volumeInfo;

    final thumbnail = info.imageLinks?.thumbnail ??
        "https://via.placeholder.com/150x200?text=No+Image";

    final authors =
        (info.authors == null || info.authors!.isEmpty)
            ? "Unknown Author"
            : info.authors!.join(", ");

    final description = info.description ?? "No description available.";

    return Scaffold(
      appBar: AppBar(title: Text(info.title ?? "Book Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              thumbnail,
              height: 160,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.book, size: 100),
            ),
            const SizedBox(height: 16),
            Text(
              info.title ?? "No Title",
              style: const TextStyle(fontSize: 20),
            ),
            Text(authors),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(description),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
