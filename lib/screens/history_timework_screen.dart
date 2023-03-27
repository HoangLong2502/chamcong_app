import 'package:chamcong_app/providers/time_work.dart';
import 'package:chamcong_app/screens/history_timework_detail_screen.dart';
import 'package:chamcong_app/widgets/history_timework/card_item.dart';
import 'package:chamcong_app/widgets/history_timework/circle_progress.dart';
import 'package:chamcong_app/widgets/history_timework/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryTimeworkScreen extends StatefulWidget {
  static const routeName = '/history_timework';

  @override
  State<HistoryTimeworkScreen> createState() => _HistoryTimeworkScreenState();
}

class _HistoryTimeworkScreenState extends State<HistoryTimeworkScreen>
    with TickerProviderStateMixin {
  bool _isInit = true;

  List dataTimeWorksLate = [];
  List dataTimeWorksSoon = [];

  List listCardItem = [
    {
      'title': 'Đi muộn',
      'count': 0,
      'time': 0,
      'routeName': HistoryTimeWorkDetailScreen.routeName
    },
    {
      'title': 'Về sớm',
      'count': 0,
      'time': 0,
      'routeName': HistoryTimeWorkDetailScreen.routeName
    },
  ];

  bool _isLoading = false;

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<TimeWork>(context, listen: false).HandleGetTimeWork();
  }

  @override
  void didChangeDependencies() {
    if (_isInit = true) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<TimeWork>(context).HandleGetTimeWork().then((value) {
        updateDataByMonth(value);
        setState(() {
          _isLoading = false;
        });
      });

      _timeWork = AnimationController(
        lowerBound: 0.0,
        upperBound: 0.01,
        vsync: this,
        duration: const Duration(seconds: 1),
      )..addListener(() {
          setState(() {});
        });
      ;
      _timeWork.forward(from: 0.0);

      _timeOff = AnimationController(
        lowerBound: 0.0,
        upperBound: 0.5,
        vsync: this,
        duration: const Duration(seconds: 1),
      )..addListener(() {
          setState(() {});
        });
      ;
      _timeOff.forward(from: 0.0);
    }

    setState(() {
      _isInit = false;
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timeWork.dispose();
    _timeOff.dispose();
    super.dispose();
  }

  var dataTimeWorks = [];

  late AnimationController _timeWork;

  late AnimationController _timeOff;

  void getTimeWorkByMonth(String month) {
    Provider.of<TimeWork>(context, listen: false)
        .HandleGetTimeWorkByMonth(month)
        .then((value) {
      updateDataByMonth(value);
    });
  }

  void updateDataByMonth(value) {
    setState(() {
      dataTimeWorks = value;
      dataTimeWorksLate = [];
      dataTimeWorksSoon = [];
      listCardItem = [
        {
          'title': 'Đi muộn',
          'count': 0,
          'time': 0,
          'routeName': HistoryTimeWorkDetailScreen.routeName
        },
        {
          'title': 'Về sớm',
          'count': 0,
          'time': 0,
          'routeName': HistoryTimeWorkDetailScreen.routeName
        },
      ];

      dataTimeWorks.forEach((element) {
        if (element['time_late'] != 0) {
          dataTimeWorksLate.add(element);
          listCardItem[0]['count'] = listCardItem[0]['count'] + 1;
          listCardItem[0]['time'] = listCardItem[0]['time'] +
              int.parse(element['time_late'].toString());
        }
        if (element['time_soon'] != 0) {
          dataTimeWorksSoon.add(element);
          listCardItem[1]['count'] = listCardItem[1]['count'] + 1;
          listCardItem[1]['time'] = listCardItem[1]['time'] +
              int.parse(element['time_soon'].toString());
        }
      });

      _timeWork = AnimationController(
        lowerBound: 0.0,
        upperBound: dataTimeWorks.length / 24,
        vsync: this,
        duration: const Duration(seconds: 1),
      )..addListener(() {
          setState(() {});
        });
      ;
      _timeWork.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử chấm công'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ))
          : RefreshIndicator(
              onRefresh: () => _refreshData(context),
              child: Container(
                padding: EdgeInsets.all(16),
                color: Theme.of(context).backgroundColor,
                child: Column(
                  children: [
                    // header
                    HistoryTimeWorkHeader(
                        dataTimeWorks.length, getTimeWorkByMonth),
                    SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleProgrss(
                            'Ngày công',
                            dataTimeWorks.length,
                            'Đã chấm',
                            dataTimeWorks.length,
                            'Công tháng',
                            24,
                            _timeWork),
                        SizedBox(width: 8),
                        CircleProgrss(
                          'Quỹ phép',
                          6,
                          'Phép năm',
                          6,
                          'Nghỉ thực tế',
                          12,
                          _timeOff,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Column(
                      children: listCardItem.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: HistoryTimeWorkCardItem(
                              item['title'],
                              item['count'],
                              item['time'],
                              item['routeName'],
                              item['title'] == 'Đi muộn'
                                  ? dataTimeWorksLate
                                  : dataTimeWorksSoon),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
