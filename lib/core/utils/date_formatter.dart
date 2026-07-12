import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String monthDay(DateTime date) => DateFormat('MMM d').format(date);

  static String full(DateTime date) =>
      DateFormat('MMM d, yyyy – h:mm a').format(date);
}
