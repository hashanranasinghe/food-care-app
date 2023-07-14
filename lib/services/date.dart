import 'package:intl/intl.dart';

class Date {
  static String getStringdatenow() {
    var dateParse = DateTime.now();
    String date = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
    return date;
  }

  static String getStringCollectiondatenow() {
    var dateParse = DateTime.now();
    String date = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
    return date;
  }

  static String getStringdatetimenow() {
    String date = DateFormat.yMd().add_jm().format(DateTime.now()).toString();
    return date;
  }

  static String getStringdatetime(DateTime dateTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);
    if (difference.inDays >= 1) {
      return "${difference.inDays} ${difference.inDays > 1 ? 'days' : 'day'}";
    } else if (difference.inHours >= 1) {
      return "${difference.inHours} ${difference.inHours > 1 ? 'hours' : 'hour'}";
    } else if (difference.inMinutes >= 1) {
      return "${difference.inMinutes} ${difference.inMinutes > 1 ? 'minutes' : 'minute'}";
    } else {
      return "${difference.inSeconds} ${difference.inSeconds > 1 ? 'seconds' : 'second'}";
    }
  }

  static DateTime convertDatetime(String date) {
    var datetime = DateFormat('d/M/yyyy').parse(date);
    print(datetime);
    return datetime;
  }

  static String getDateTimeId() {
    return DateTime.now()
        .toString()
        .replaceAll("-", "")
        .replaceAll(":", "")
        .replaceAll(" ", "")
        .replaceAll(".", "");
  }
}
