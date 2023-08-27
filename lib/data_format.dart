library data_format;

import 'dart:math';

extension Readables on DateTime {
  String readable(String format) {
    DateTime time = this;

    Map<String, Map<String, Function>> options;
    Map<String, Function> globalModifiers = {
      'zeroPadded': (val) => (val < 10 ? '0' : '') + val.toString(),
      'lastTwo': (val) => val % 100,
    };

    options = {
      'year': {
        'main': () => time.year,
      },
      'month': {
        'main': () => time.month,
        'name': (val) => [
              'January',
              'February',
              'March',
              'April',
              'May',
              'June',
              'July',
              'August',
              'September',
              'October',
              'November',
              'December',
            ][val - 1],
        'shortname': (val) => [
              'Jan',
              'Feb',
              'Mar',
              'Apr',
              'Ma',
              'Jun',
              'Jul',
              'Aug',
              'Sep',
              'Oct',
              'Nov',
              'Dec',
            ][val - 1],
      },
      'day': {
        'main': () => time.weekday,
        'name': (val) => [
              'Monday',
              'Tuesday',
              'Wednesday',
              'Thursday',
              'Friday',
              'Saturday',
              'Sunday'
            ][val - 1],
        'shortname': (val) =>
            ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][val - 1],
      },
      'date': {
        'main': () => time.day,
      },
      'hour': {
        'main': () => time.hour,
        '12h': (val) => val % 12,
      },
      'minute': {
        'main': () => time.minute,
      },
      'second': {
        'main': () => time.second,
      },
      'meridiem': {
        'main': () => time.hour < 12 ? 'AM' : 'PM',
      },
      'ago': {
        'main': () {
          var diff = DateTime.now().difference(time);

          var totalMinutes = diff.inMinutes;
          int minutes = totalMinutes % (60),
              hours = (totalMinutes % (24 * 60) / 60).floor(),
              days = (totalMinutes % (30 * 24 * 60) / (24 * 60)).floor(),
              months =
                  (totalMinutes % (365.25 * 24 * 60).toInt() / (30 * 24 * 60))
                      .floor(),
              years = (totalMinutes / (365.25 * 24 * 60)).floor();

          return '${years > 0 ? '$years years ' : ''}${months > 0 ? '$months months ' : ''}${days > 0 ? '$days days ' : ''}${hours > 0 ? '$hours hours ' : ''}${minutes > 0 ? '$minutes minutes ' : ''}ago';
        },
        'single': (val) {
          var diff = DateTime.now().difference(time);

          var totalMinutes = diff.inMinutes;
          int minutes = totalMinutes % (60),
              hours = (totalMinutes % (24 * 60) / 60).floor(),
              days = (totalMinutes % (30 * 24 * 60) / (24 * 60)).floor(),
              months =
                  (totalMinutes % (365.25 * 24 * 60).toInt() / (30 * 24 * 60))
                      .floor(),
              years = (totalMinutes / (365.25 * 24 * 60)).floor();

          if (years > 0) {
            return '${years > 0 ? '$years year' : ''}${years >= 10 ? 's ' : ' '}ago';
          }
          if (months > 0) {
            return '${months > 0 ? '$months month' : ''}${months >= 10 ? 's ' : ' '}ago';
          }
          if (days > 0) {
            return '${days > 0 ? '$days day' : ''}${days >= 10 ? 's ' : ' '}ago';
          }
          if (hours > 0) {
            return '${hours > 0 ? '$hours hour' : ''}${hours >= 10 ? 's ' : ' '}ago';
          }
          if (minutes > 0) {
            return '${minutes > 0 ? '$minutes minutes ' : ''}ago';
          }

          return 'just now';
        }
      },
    };

    return format.replaceAllMapped(
      RegExp(r'([a-zA-Z0-9]+)(\([a-zA-Z0-9,]+\))?'),
      (Match m) {
        if (!options.containsKey(m.group(1))) return m.group(1) ?? '';

        dynamic formatted = options[m.group(1)]!['main']!();
        dynamic modifiers = m.group(2);

        if (modifiers != null) {
          modifiers = modifiers.substring(1, modifiers.length - 1).split(',');

          for (int i = 0; i < modifiers.length; i++) {
            if (!options[m.group(1)]!.containsKey(modifiers[i])) {
              if (globalModifiers.containsKey(modifiers[i])) {
                formatted = globalModifiers[modifiers[i]]!(formatted);
              } else {
                continue;
              }
            } else {
              formatted = options[m.group(1)]![modifiers[i]]!(formatted);
            }
          }
        }

        // print(['m.group(1)', m.group(1)]);
        // print(['formatted', formatted]);
        // print(['modifiers', modifiers]);

        return formatted.toString();
      },
    );
  }
}

extension ReadableSize on num {
  toReadableBytes([int precision = 2]) {
    var bases = ['', 'K', 'M', 'G', 'T', 'P', 'E'];

    if (this == 0) return '0 B';

    var base = (log(this) / log(1024)).floor();
    var size = (this / pow(1024, base)).toStringAsFixed(precision);

    return '$size ${bases[base]}B';
  }
}

extension ReadableDuration on int {
  String get hhmmss {
    int hh = (this / 3600).floor(),
        mm = ((this % 3600) / 60).floor(),
        ss = this % 60;

    return '${hh < 9 ? '0' : ''}$hh : ${mm < 9 ? '0' : ''}$mm : ${ss < 9 ? '0' : ''}$ss';
  }
}
