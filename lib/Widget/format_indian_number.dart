import 'package:intl/intl.dart';

String formatIndianNumber(num? number) {
  NumberFormat indianNumberFormat = NumberFormat.decimalPattern('en_IN');

  return indianNumberFormat.format(number ?? 0);
}
