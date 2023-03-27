import 'package:chamcong_app/base/_typography.dart';
import 'package:flutter/material.dart';

class CalendarItem extends StatelessWidget {
  final int month;
  final int year;
  final List days;
  final Function changeMonth;
  final Function getTimeBreakByMonth;
  final Function getTimeWorkByMonth;
  final bool isSelectMenuTime;
  final Function handleShowMenuTime;

  CalendarItem(
      this.month,
      this.year,
      this.days,
      this.changeMonth,
      this.getTimeBreakByMonth,
      this.getTimeWorkByMonth,
      this.isSelectMenuTime,
      this.handleShowMenuTime);
  // CalendarItem(this.month, this.year);
  final _nameDays = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];

  Widget buildCheckboxTitle(BuildContext context, String title, int color) {
    return Row(
      children: [
        Icon(
          Icons.check_box_rounded,
          color: Color(color),
          size: 22,
        ),
        SizedBox(width: 8),
        TyphographyBase.p4(context, title, null),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: double.infinity,
                height: 380,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFD9DCE0)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              changeMonth('back');
                              getTimeWorkByMonth(context);
                              getTimeBreakByMonth(context);
                            },
                            icon: Icon(Icons.arrow_left)),
                        TextButton(
                          onPressed: () {
                            handleShowMenuTime();
                          },
                          child: TyphographyBase.h3(
                            context,
                            'Tháng $month , $year',
                            null,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              changeMonth('next');
                              getTimeWorkByMonth(context);
                              getTimeBreakByMonth(context);
                            },
                            icon: Icon(Icons.arrow_right))
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 40,
                      child: GridView.count(
                        crossAxisCount: 7,
                        childAspectRatio: 1.5,
                        children: _nameDays.map((e) {
                          return Center(
                            child: TyphographyBase.h3(
                              context,
                              e,
                              0xFFa0aec0,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(0),
                      width: double.infinity,
                      height: 240,
                      child: GridView.count(
                        crossAxisCount: 7,
                        childAspectRatio: 1.1,
                        children: days.map((e) {
                          return Column(
                            children: [
                              Center(
                                child: TyphographyBase.t4(
                                  context,
                                  '${e['title'].toString()}',
                                  null,
                                ),
                              ),
                              Wrap(
                                spacing: 4,
                                children: [
                                  if (e['misscheckout'])
                                    CircleAvatar(
                                      maxRadius: 3,
                                      backgroundColor: Color(0xFFD92B6A),
                                    ),
                                  if (e['full_work'] && !e['misscheckout'])
                                    CircleAvatar(
                                      maxRadius: 3,
                                      backgroundColor: Color(0xFF1AB65C),
                                    ),
                                  if (e['timebreak'])
                                    CircleAvatar(
                                      maxRadius: 3,
                                      backgroundColor: Color(0xFF2577C9),
                                    ),
                                ],
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              isSelectMenuTime
                  ? Positioned(
                      height: 225,
                      top: 50,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 250,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF2d3748),
                          ),
                          child: Column(
                            children: [
                              TyphographyBase.h4(
                                  context, year.toString(), 0xFFFFFFFF),
                              SizedBox(height: 16),
                              Container(
                                height: 150,
                                width: double.infinity,
                                child: GridView.count(
                                  crossAxisCount: 3,
                                  childAspectRatio: 2,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: List.generate(12, (index) {
                                    return Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: month == index + 1
                                            ? Color(0xFFbee3f8)
                                            : Color(0xFF2d3748),
                                      ),
                                      child: Center(
                                        child: TyphographyBase.h4(
                                          context,
                                          'Thg ${index + 1}',
                                          month == index + 1
                                              ? 0xFF2d3748
                                              : 0xFFFFFFFF,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(0),
            child: GridView(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 5),
              shrinkWrap: true,
              children: [
                buildCheckboxTitle(context, 'Chấm công thiếu', 0xFFD92B6A),
                buildCheckboxTitle(context, 'Chấm công đủ', 0xFF1AB65C),
                buildCheckboxTitle(context, 'Nghỉ phép', 0xFF2577C9),
                buildCheckboxTitle(context, 'Nghỉ không lương', 0xFFFFCC00),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
