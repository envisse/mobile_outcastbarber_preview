import 'package:intl/intl.dart';

//for simplified code in dateformat
class DateFormatUtils {
  static String date(DateTime dateTime){
    return DateFormat('d MMMM ').format(dateTime);
  }
}