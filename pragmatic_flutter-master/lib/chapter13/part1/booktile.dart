import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  final dynamic book;

  const BookTile({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${book['volumeInfo']['title']}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  book['volumeInfo']['authors'] != null
                      ? Text(
                          'Author(s): ${book['volumeInfo']['authors'].join(", ")}',
                          style: const TextStyle(fontSize: 14),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            book['volumeInfo']['imageLinks'] != null &&
                    book['volumeInfo']['imageLinks']['thumbnail'] != null
                ? Image.network(
                    book['volumeInfo']['imageLinks']['thumbnail'],
                    fit: BoxFit.fill,
                    width: 60,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
