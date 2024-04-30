import 'package:intl/intl.dart';

class AppFormat {
  static String date(String stringDate) { // 2024-04-05
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('d MMM YYYY','id_ID').format(dateTime); // 5 Apr 2024
  }
}