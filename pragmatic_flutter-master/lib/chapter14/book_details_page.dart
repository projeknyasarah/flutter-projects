import 'package:flutter/material.dart';
import 'book.dart';

class BookDetailsPage extends StatelessWidget {
  final BookModel book;

  const BookDetailsPage({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final info = book.volumeInfo;

    return Scaffold(
      appBar: AppBar(title: Text(info.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Image.network(
              info.imageLinks.thumbnail,
              errorBuilder: (_, __, ___) => Icon(Icons.book, size: 100),
            ),
            const SizedBox(height: 16),
            Text(info.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(info.description),
          ],
        ),
      ),
    );
  }
}
