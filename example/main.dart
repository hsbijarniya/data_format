import 'package:data_format/data_format.dart';

void main() {
  // "2022 December, 31 8:50:55 AM";
  DateTime(2022, 12, 31, 8, 50, 55).readable(
      'year month(name), date, hour:minute(zeroPadded):second meridiem');

  // "22/12/31 7:8:9 AM";
  DateTime(2022, 12, 31, 7, 8, 9)
      .readable('year/month/date hour:minute:second meridiem');

  // "31 Dec, 2022 06:08:09 PM";
  DateTime(2022, 12, 31, 18, 8, 9).readable(
      'date month(shortname), year hour(12h,zeroPadded):minute(zeroPadded):second(zeroPadded) meridiem');

  // "10 days 1 hour 23 minutes 43 seconds ago";
  DateTime(2022, 12, 31, 18, 8, 9).readable('ago');

  // "43 seconds ago";
  DateTime(2022, 12, 31, 18, 8, 9).readable('ago(single)');
}
