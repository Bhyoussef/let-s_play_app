import 'package:intl/intl.dart';

import '../constants/utils_contants.dart';

extension DateTimeExtension on DateTime {
  String toDefaultDateTimeFormatted() {
    return DateFormat(UtilsConstants.defaultDatetimeFormat).format(this);
  }

  String toDayWeekdayMonthAbrDayFormatted() {
    return DateFormat('EEEE MMM d').format(this);
  }

  String toDefaultTimeHMFormatted() {
    return DateFormat(UtilsConstants.defaultTimeHMFormat).format(this);
  }
}
