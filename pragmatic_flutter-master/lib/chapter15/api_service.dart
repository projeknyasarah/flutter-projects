import 'dart:convert';
import 'package:http/http.dart' as http;
import 'book.dart';

class ApiService {
  static const String _baseUrl =
      'https://www.googleapis.com/books/v1/volumes';

  static const String apiKey = 'AIzaSyAd6pQjaAn0BPM0HoyI1Zjs3un6X5eyej4';

  Future<List<Book>> fetchBooks() async {
    const query = "flutter";

    final url = Uri.parse(
      "$_baseUrl?q=${Uri.encodeQueryComponent(query)}&key=$apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> items = data["items"] ?? [];

      return items.map((e) => Book.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Book>> searchBooks(String query) async {
    final url = Uri.parse(
      "$_baseUrl?q=${Uri.encodeQueryComponent(query)}&key=$apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> items = data["items"] ?? [];

      return items.map((e) => Book.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
