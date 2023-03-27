import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryTimeWorkHeader extends StatelessWidget {
  final int countWork;
  final Function getTimeWorkByMonth;

  HistoryTimeWorkHeader(this.countWork, this.getTimeWorkByMonth);

  final _listMonth =
      List<String>.generate(12, (index) => (index + 1).toString());

  var _monthSelect = DateFormat.M().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tháng ${DateFormat.M().format(DateTime.now())}',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline1!.fontSize,
                          fontWeight:
                              Theme.of(context).textTheme.headline1!.fontWeight,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            countWork.toString(),
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .fontSize,
                              fontWeight: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .fontWeight,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            '/25',
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .fontSize,
                              fontWeight: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .fontWeight,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ngày ${DateFormat.d().format(DateTime.now())}, ${DateFormat.y().format(DateTime.now())}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Ngày công',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFFE3E5E8)),
                    child: Row(children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(color: Color(0xFF303439), borderRadius: BorderRadius.circular(8)),
                          child: DropdownButtonFormField(
                            value: _monthSelect,
                            items: _listMonth.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text('Tháng ${item}'),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              getTimeWorkByMonth(value);
                            },
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.headline2!.fontSize,
                              fontWeight: Theme.of(context).textTheme.headline2!.fontWeight,
                            ),
                            dropdownColor: Color(0xFF303439),
                            borderRadius: BorderRadius.circular(8),
                            focusColor: Colors.white,
                            iconEnabledColor: Colors.white,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFD9DCE0),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Năm ${DateFormat.y().format(DateTime.now())}',
                          style: TextStyle(
                            
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            );
  }
}