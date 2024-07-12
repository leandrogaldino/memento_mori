import 'package:intl/intl.dart';

extension FormattedDate on DateTime {
  String toFormattedString() {
    return DateFormat('dd/MM/yyyy HH:mm').format(this);
  }
}
