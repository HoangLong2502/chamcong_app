import 'package:chamcong_app/base/_typography.dart';
import 'package:chamcong_app/widgets/calendar_work/calendar_item.dart';
import 'package:chamcong_app/widgets/calendar_work/time_work_item.dart';
import 'package:chamcong_app/providers/time_work.dart';
import 'package:chamcong_app/providers/time_break.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiver/time.dart';
import 'package:provider/provider.dart';

class CalendarWorkScreen extends StatefulWidget {
  @override
  State<CalendarWorkScreen> createState() => _CalendarWorkScreenState();
}

class _CalendarWorkScreenState extends State<CalendarWorkScreen> {
  int month = int.parse(DateFormat.M().format(DateTime.now()));

  int year = int.parse(DateFormat.y().format(DateTime.now()));

  List _timeWorks = [];

  List _timeBreaks = [];

  bool _isSelectMenuTime = false;

  // --------- function to show drop menu time ----------
  void _handleShowMenuTime() {
    setState(() {
      _isSelectMenuTime = !_isSelectMenuTime;
    });
  }

  // --------- function to change month in screen--------
  void _changeMonth(String type) {
    setState(() {
      _timeWorks = [];
      _timeBreaks = [];
    });
    if (type == 'next') {
      if (month == 12) {
        setState(() {
          month = 1;
          year = year + 1;
        });
      } else {
        setState(() {
          month = month + 1;
        });
      }
    } else {
      if (month == 1) {
        setState(() {
          month = 12;
          year = year - 1;
        });
      } else {
        setState(() {
          month = month - 1;
        });
      }
    }
  }

  List<Map<String, dynamic>> get days {
    var daysLength = daysInMonth(year, month);
    var listDays = List<Map<String, dynamic>>.generate(
        daysLength,
        (o) => {
              'title': (o + 1).toString(),
              'full_work': false,
              'misscheckout': false,
              'timebreak': false
            });

    _timeWorks.forEach((item) {
      var day = listDays.firstWhere((d) => int.parse(d['title']) < 10
          ? '0${d['title']}' == item['day']
          : d['title'] == item['day']);
      setState(() {
        day['full_work'] = true;
      });
      if (item['checkin'].toString() == item['checkout'].toString()) {
        setState(() {
          day['misscheckout'] = true;
        });
      }
    });

    _timeBreaks.forEach((item) {
      var dayBreak = listDays.firstWhere((ele) => int.parse(ele['title']) == int.parse(item['time_start']));
      setState(() {
        dayBreak['timebreak'] = true;
      });
    });

    var firstDay = DateFormat.E().format(DateTime(year, month, 1));

    var emty = {
      'title': '',
      'full_work': false,
      'misscheckout': false,
      'timebreak': false
    };

    switch (firstDay) {
      case 'Mon':
        break;
      case 'Tue':
        listDays.insert(0, emty);
        break;
      case 'Wed':
        var arr = List.filled(2, emty);
        listDays.insertAll(0, arr);
        break;
      case 'Thu':
        var arr = List.filled(3, emty);
        listDays.insertAll(0, arr);
        break;
      case 'Fir':
        var arr = List.filled(4, emty);
        listDays.insertAll(0, arr);
        break;
      case 'Sat':
        var arr = List.filled(5, emty);
        listDays.insertAll(0, arr);
        break;
      case 'Sun':
        var arr = List.filled(6, emty);
        listDays.insertAll(0, arr);
        break;
      default:
    }
    return listDays;
  }

  // ----------function to get timework by month-----------
  void _getTimeWorkByMonth(BuildContext context) {
    Provider.of<TimeWork>(context, listen: false)
        .HandleGetTimeWorkByMonth(month.toString())
        .then((value) {
      value.forEach(
        (item) {
          var time = (item['day'].toString().split('-'));
          item['day'] = time[2].toString();
        },
      );
      setState(() {
        _timeWorks = value;
      });
    });
  }

  // ----------function to get timebreak by month-----------
  void _getTimeBreakByMonth(BuildContext context) {
    Provider.of<TimeBreaks>(context, listen: false)
      .handleGetTimeBreakByMonth(month.toString())
      .then((value) {
        value.forEach((item) {
          item['time_start'] = DateFormat('y-M-d').format(DateFormat('y-M-d').parse(item['time_start'].toString()));
          item['time_start'] = (item['time_start'].toString().split('-'))[2];
        },);
        setState(() {
          _timeBreaks = value;
        }); 
      });
  }

  @override
  void didChangeDependencies() {
    _getTimeWorkByMonth(context);
    _getTimeBreakByMonth(context);
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TyphographyBase.h3(context, 'Lịch làm việc', null),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: CalendarItem(month, year, days, _changeMonth, _getTimeBreakByMonth, _getTimeWorkByMonth, _isSelectMenuTime, _handleShowMenuTime),
            ),
            SizedBox(height: 24),
            // Text('data'),
            Wrap(
              runSpacing: 16,
              children: _timeWorks.map((e) {
              return TimeWorkItem('${e['day']}/$month/$year', e['checkin'], e['checkout']);
            }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
