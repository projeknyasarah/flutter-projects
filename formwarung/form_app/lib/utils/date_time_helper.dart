import 'package:intl/intl.dart';

class DateTimeHelper {
  static String tanggal() {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  static String jam() {
    return DateFormat('HH:mm').format(DateTime.now());
  }
}
