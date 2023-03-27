import 'package:intl/intl.dart';

class TimeConvert {

  String convertStringToDateTime(String timeString) {
    var time = DateFormat('EEE, d-M-y').format(DateTime.parse(timeString));

    return time;
  }
}