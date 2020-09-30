import 'package:intl/intl.dart';

extension DateTimeHelper on DateTime {
  static final DateFormat format = DateFormat("yyyy-MM-dd");

  String toDateString() {
    return format.format(this);
  }

  int toDaysAgo(DateTime initDate) {
    return initDate.difference(this).inDays;
  }
}
