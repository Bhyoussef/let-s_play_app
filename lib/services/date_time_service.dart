import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeService {
  Future<String> showDateTimePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      final pickedTime = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child ?? Container(),
          );
        },
      );

      if (pickedTime != null) {
        var time = DateTime.now();
        var dt = DateTime(time.year, time.month, time.day, pickedTime.hour,
            pickedTime.minute, time.second, time.millisecond, time.microsecond);
        var finalTime = DateFormat('HH:mm').format(dt);
        return '$formattedDate $finalTime';
      }
    }

    return '';
  }

  String formatDate(String date, String format,  {bool isUTC = false}) {
    final DateTime dateFromString = isUTC ? DateTime.parse(date).toLocal() : DateTime.parse(date);
    final DateFormat dateFormatter = DateFormat(format);
    return dateFormatter.format(dateFromString);
  }

}
