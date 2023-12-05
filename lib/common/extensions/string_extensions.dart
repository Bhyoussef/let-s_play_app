import '../constants/utils_contants.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String get capitalizeEveryWord {
    if (isEmpty) return '';
    return trim().split(' ').map((word) => word.capitalize).toList().join(' ');
  }

  String get capitalize {
    if (isEmpty) return '';
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  DateTime? defaultFomatToDateTime() {
    final stringDate = this;
    try {
      DateTime? date =
          DateFormat(UtilsConstants.defaultDatetimeFormat).parse(stringDate);
      return date;
    } catch (e) {
      return null;
    }
  }
}
