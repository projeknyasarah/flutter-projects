import 'package:flutter/material.dart';
import 'book.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;

  const BookTile({
    super.key,
    required this.book,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final info = book.volumeInfo;

    final thumbnail = info.imageLinks?.thumbnail ??
        "https://via.placeholder.com/50x75?text=No+Image";

    final authors =
        (info.authors == null || info.authors!.isEmpty)
            ? "Unknown Author"
            : info.authors!.join(", ");

    return ListTile(
      leading: Image.network(
        thumbnail,
        width: 50,
        errorBuilder: (_, __, ___) => const Icon(Icons.book),
      ),
      title: Text(info.title ?? "No Title"),
      subtitle: Text(authors),
      onTap: onTap,
    );
  }
}
