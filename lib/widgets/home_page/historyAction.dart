import 'package:chamcong_app/screens/history_timeot_timebreak.dart';
import 'package:chamcong_app/screens/history_timework_screen.dart';
import 'package:flutter/material.dart';

class HistoryAction extends StatelessWidget {
  final List _listHistory = [
    {'title': 'Lịch sử chấm công'},
    {'title': 'Thống kê công việc'},
    {'title': 'Chi tiết bảng lương'}
  ];

  Widget buildContainer(
      BuildContext context, Widget elementChild, String title, String router) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(router);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                elementChild,
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          buildContainer(
            context,
            Icon(Icons.access_alarm),
            'Lịch sử chấm công',
            HistoryTimeworkScreen.routeName
          ),
          buildContainer(
            context,
            Icon(Icons.safety_divider_rounded),
            'Lịch sử đăng ký OT',
            HistoryTimeOt.routeName
          ),
          buildContainer(
            context,
            Icon(Icons.sick_outlined),
            'Lịch sử đăng ký xin nghỉ',
            ''
          ),
          buildContainer(
            context,
            Icon(Icons.work_history_outlined),
            'Thống kê công việc',
            ''
          ),
          buildContainer(
            context,
            Icon(Icons.money_outlined),
            'Bảng lương',
            ''
          ),
        ],
      ),
    );
  }
}
