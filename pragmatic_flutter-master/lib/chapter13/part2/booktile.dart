import 'package:flutter/material.dart';
import 'bookmodel.dart';

class BookTile extends StatelessWidget {
  final BookModel bookModelObj;

  const BookTile({
    Key? key,
    required this.bookModelObj,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(bookModelObj.volumeInfo.title),
        subtitle: Text(
          bookModelObj.volumeInfo.authors?.join(", ") ?? "No Author",
        ),
        leading: bookModelObj.volumeInfo.imageLinks?.thumbnail != null
            ? Image.network(bookModelObj.volumeInfo.imageLinks!.thumbnail!)
            : null,
      ),
    );
  }
}
