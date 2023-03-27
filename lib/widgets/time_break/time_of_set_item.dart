import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeOfSetItem extends StatelessWidget {
  TimeOfDay _timeNow = TimeOfDay.now();

  final Map<String, dynamic> timeoffset;
  final Widget iconbutton;
  final Function changeDate;
  final Function changeTimeStart;

  TimeOfSetItem(this.timeoffset, this.iconbutton, this.changeDate, this.changeTimeStart);

  @override
  Widget build(BuildContext context) {
    void _showTimePicker(typeTime) async {
      showTimePicker(
        context: context,
        initialTime: _timeNow,
      ).then((value) {
        if (value != null) {
          changeTimeStart(timeoffset, typeTime, value);
        } else {
          return;
        }
      });
    }

    return Container(
      width: double.infinity,
      padding: timeoffset['delete'] ? EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 8) : EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ngày ', style: Theme.of(context).textTheme.headline5),
              timeoffset['delete'] ? iconbutton : Text(''),
            ],
          ),
          timeoffset['delete'] ? SizedBox(height: 0) : SizedBox(height: 16),
          Container(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: timeoffset['day'],
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                ).then((value) {
                  if (value != null) {
                    changeDate(timeoffset, value);
                  }
                });
              },
              child: Text(
                DateFormat.yMEd().format(timeoffset['day']),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thời gian bắt đầu',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _showTimePicker('time_start');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            timeoffset['time_start'].format(context),
                            style: TextStyle(color: Color(0xFF303439)),
                          ),
                          Icon(
                            Icons.timelapse_outlined,
                            color: Color(0xFF303439),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thời gian kết thúc',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _showTimePicker('time_end');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            timeoffset['time_end'].format(context),
                            style: TextStyle(color: Color(0xFF303439)),
                          ),
                          Icon(
                            Icons.timelapse_outlined,
                            color: Color(0xFF303439),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
