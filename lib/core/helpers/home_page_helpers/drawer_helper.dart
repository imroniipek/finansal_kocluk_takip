import 'package:intl/intl.dart';

class DrawerHelper{
  static DateTime converttoDatetime(String theTime)=>DateTime.parse(theTime);

  static Map<DateTime, DateTime> calculateAdd7days(String dateString) {
  DateTime start = DateFormat("dd.MM.yyyy").parse(dateString);
  DateTime end = start.add(Duration(days: 7));

  return {start: end};
  }


}
