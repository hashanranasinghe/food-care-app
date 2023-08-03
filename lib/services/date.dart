import 'package:intl/intl.dart';

class Date {
  static String getStringDateNow() {
    var dateParse = DateTime.now();
    String date = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
    return date;
  }

  static String getStringCollectionDateNow() {
    var dateParse = DateTime.now();
    String date = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
    return date;
  }

  static String getStringDateTimeNow() {
    String date = DateFormat.yMd().add_jm().format(DateTime.now()).toString();
    return date;
  }

  static String getStringDateTime(DateTime dateTime) {
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

  static Duration calculateTimeDifference(String startTime, String endTime) {
    final DateFormat format = DateFormat("hh:mm a");

    final DateTime parsedStartTime = format.parse(startTime);
    DateTime parsedEndTime = format.parse(endTime);

    // Handle cases where endTime is before startTime (i.e., spanning across midnight)
    if (parsedEndTime.isBefore(parsedStartTime)) {
      parsedEndTime = parsedEndTime.add(const Duration(days: 1));
    }
    print(parsedEndTime.difference(parsedStartTime));
    return parsedEndTime.difference(parsedStartTime);
  }

  static Duration parseHours(String timeString) {
    // Use regular expression to extract the numeric value from the string
    final RegExp regex = RegExp(r'(\d+)');

    // Find the first match in the string
    final Match? match = regex.firstMatch(timeString);

    // If a match is found and it is not null, extract the numeric value and convert it to an integer
    if (match != null) {
      int hours = int.parse(match.group(0)!);
      print(hours);
      return Duration(hours: hours);
    }

    // Return a default value (You can handle this based on your use case)
    return Duration.zero;
  }
}
