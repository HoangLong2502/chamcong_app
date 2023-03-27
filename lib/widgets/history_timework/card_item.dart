import 'package:flutter/material.dart';

class HistoryTimeWorkCardItem extends StatelessWidget {
  final String title;
  final int count;
  final int time;
  final String routeName;
  final List dataTimeWorks;

  HistoryTimeWorkCardItem(this.title, this.count, this.time, this.routeName, this.dataTimeWorks);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(routeName, arguments: {
          'title' : title,
          'data' : dataTimeWorks,
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color(0xFFD9DCE0),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Icon(Icons.arrow_right_rounded),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_sharp,
                        size: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 4),
                      Text('$count lần')
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timelapse_sharp,
                        size: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 4),
                      Text('$time phút')
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
