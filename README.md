Library that simplify all the formatting for you.

## DateTime Format

How to use
variableName(modifierA, modifierB, ...)

Example
year: four digit year i.e. 2023
year(lastTwo): with last two digit modifier i.e. 23
month: 1 to 12
month(name): Jan to Dec
month(shortname): January to December
date: 1 to 31
day: 1 to 7
day(name): Monday to Sunday
day(shortname): Mon to Sun
hour: 0 to 23
hour(12h): 0 to 11
hour(12h,zeroPadded): 00 to 11

Global modifiers are
lastTwo: get last two digits
zeroPadded: get two digit value if zero padded

```dart
// "2022 December, 31 8:50:55 AM";
DateTime(2022, 12, 31, 8, 50, 55).readable('year month(name), date, hour:minute(zeroPadded):second meridiem');

// "22/12/31 7:8:9 AM";
DateTime(2022, 12, 31, 7, 8, 9).readable('year/month/date hour:minute:second meridiem');

// "31 Dec, 2022 06:08:09 PM";
DateTime(2022, 12, 31, 18, 8, 9).readable('date month(shortname), year hour(12h,zeroPadded):minute(zeroPadded):second(zeroPadded) meridiem');

// "10 days 1 hour 23 minutes 43 seconds ago";
DateTime(2022, 12, 31, 18, 8, 9).ago();

// "43 seconds ago";
DateTime(2022, 12, 31, 18, 8, 9).ago(true);
```

## Number Format

```dart
int bytes = 12345678;

bytes.toReadableBytes(0); // 12 MB
bytes.toReadableBytes(2); // 12.34 MB
```
