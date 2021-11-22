import 'package:intl/intl.dart';

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var format = DateFormat('d MMMM E');
  var date = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000));
  var diff = now.difference(date);
  var time = '';
  time = format.format(date);

  return time;
}
