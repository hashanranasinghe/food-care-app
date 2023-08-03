
import 'package:intl/intl.dart';

class Convertor {
  static String upperCase({required String text}) {
    String capitalizedText =
        text.substring(0, 1).toUpperCase() + text.substring(1);
    return capitalizedText;
  }

  static String getDate({required DateTime date}) {
    date = DateTime(date.year, date.month, date.day);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    if (date.isAtSameMomentAs(today)) {
      return "Today ";
    } else if (date.isAtSameMomentAs(today.add(Duration(days: 1)))) {
      return "Tomorrow ";
    } else if (date.isAtSameMomentAs(today.subtract(Duration(days: 1)))) {
      return "Yesterday ";
    } else {
      String day = "${DateFormat('yyyy MMMM d').format(date)} ";
      return day;
    }
  }

}
