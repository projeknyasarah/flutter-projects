import 'package:flutter/material.dart';
import 'book.dart';
import 'book_details_page.dart';

class BookTile extends StatelessWidget {
  final BookModel bookModelObj;
  final VoidCallback? onTap;

  const BookTile({
    Key? key,
    required this.bookModelObj,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        bookModelObj.volumeInfo.imageLinks.thumbnail,
        width: 50,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.book),
      ),
      title: Text(bookModelObj.volumeInfo.title),
      subtitle: Text(bookModelObj.volumeInfo.publisher),
      onTap: onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BookDetailsPage(book: bookModelObj),
              ),
            );
          },
    );
  }
}
