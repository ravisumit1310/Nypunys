import 'package:intl/intl.dart';

String formatDate(dynamic rawDate) {
  if (rawDate == null) return "NA";

  try {
    DateTime parsedDate;

    if (rawDate is DateTime) {
      parsedDate = rawDate;
    } else if (rawDate is String) {
      parsedDate = DateTime.parse(rawDate);
    } else {
      return "Invalid Date";
    }

    return DateFormat("dd-MMM-yyyy").format(parsedDate);
  } catch (e) {
    return "Invalid Date";
  }
}
