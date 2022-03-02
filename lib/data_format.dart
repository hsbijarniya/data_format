library data_format;

extension Readables on DateTime {
  String readable(String format) {
    DateTime time = this;

    Map<String, Map<String, Function>> options;
    Map<String, Function> globalModifiers = {
      'padded': (val) => (val < 10 ? '0' : '') + val.toString(),
    };

    options = {
      'year': {
        'main': () => time.year,
        'yy': (val) => val % 100,
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
        'padded': (val) => val
      },
      'week': {
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
    };

    return format.replaceAllMapped(
      RegExp(r'([a-z0-9]+)(\([a-z0-9,]+\))?'),
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
