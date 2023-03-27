import 'package:chamcong_app/providers/auth.dart';
import 'package:chamcong_app/providers/time_break.dart';
import 'package:chamcong_app/providers/users.dart';
import 'package:chamcong_app/widgets/noti.dart';
import 'package:chamcong_app/widgets/time_break/time_of_set_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimeBreakScreen extends StatefulWidget {
  static String routeName = '/timebreakscreen';

  @override
  State<TimeBreakScreen> createState() => _TimeBreakScreenState();
}

class _TimeBreakScreenState extends State<TimeBreakScreen> {
  Map<String, dynamic> dataCreateNewTimeBreak = {
    "timebreak": {
      "title": 'Đơn xin nghỉ ${DateTime.now().toIso8601String()}',
      "categorybreak": 1,
      "causebreak": 1,
      "time_start": DateTime.now(),
      "time_end": DateTime.now(),
      "user": null,
      "user_accept": 1,
      "accept": "{\"status\":3}"
    },
    'timeoffset': [
      {
        'delete': false,
        'day': DateTime.now(),
        'time_start': TimeOfDay(hour: 0, minute: 0),
        'time_end': TimeOfDay(hour: 0, minute: 0),
        'user' : 0,
      },
    ],
    "handlejob": {
      "title": "handle",
      "note": "Not handle",
      "user_assign": 1,
      "file": null
    }
  };

  // List user assign
  List users = [];

  List _listCategorybreak = [];
  List _listCausebreak = [];

  bool _isInit = true;

  // function delete time off set item
  void deleteTimeOffSetItem(Map<String, dynamic> item) {
    setState(() {
      dataCreateNewTimeBreak['timeoffset'].remove(item);
    });
  }

  void changeDateTimeOffSet(item, newValue) {
    setState(() {
      item['day'] = newValue;
    });
  }

  void changeTimeStart(item, typeTime, newValue) {
    setState(() {
      item[typeTime] = newValue;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<TimeBreaks>(context).getCategorybreak().then((value) {
        setState(() {
          _listCategorybreak = value;
        });
      });
      Provider.of<TimeBreaks>(context).getCausebreak().then((value) {
        setState(() {
          _listCausebreak = value;
        });
      });
      dataCreateNewTimeBreak['timebreak']['user'] =
          Provider.of<Auth>(context).getAccount['id'];
      dataCreateNewTimeBreak['timeoffset'][0]['user'] = Provider.of<Auth>(context).getAccount['id'].toString();
      Provider.of<Users>(context).getAllAccount().then((value) {
        setState(() {
          users = value;
        });
      });
    }
    setState(() {
      _isInit = false;
    });
    super.didChangeDependencies();
  }

  // build Container
  Widget buildContainer(BuildContext context, String title, Widget child) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: double.infinity,
      // height: double.negativeInfinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                '*',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          child,
        ],
      ),
    );
  }

  // build Select
  Widget buildSelect(
      BuildContext context, String label, int valueSelect, List listOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headline5,
        ),
        SizedBox(height: 4),
        Card(
          elevation: 0,
          child: DropdownButtonFormField(
            value: valueSelect,
            items: listOptions.map((item) {
              return DropdownMenuItem<int>(
                value: item['id'],
                child: Text(item['title']),
              );
            }).toList(),
            onChanged: ((int? value) {
              setState(
                () {
                  label == 'Loại đơn xin nghỉ'
                      ? dataCreateNewTimeBreak['timebreak']['categorybreak'] =
                          value!
                      : dataCreateNewTimeBreak['timebreak']['causebreak'] =
                          value!;
                },
              );
            }),
            hint: Container(
              child: Text(
                "Select Item Type",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.end,
              ),
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFD9DCE0),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFD9DCE0),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFD9DCE0),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }

  // build TimePicker
  Widget buildTimePicker(
      BuildContext context, String label, String typeTime, Widget timeShow) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
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
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime(2030, 6, 7), onConfirm: (date) {
                setState(() {
                  typeTime == 'time_start'
                      ? dataCreateNewTimeBreak['timebreak']['time_start'] = date
                      : dataCreateNewTimeBreak['timebreak']['time_end'] = date;
                });
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                timeShow,
                Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xFF303439),
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo đơn xin nghỉ'),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(right: 16, left: 16, bottom: 116, top: 16),
          child: Column(
            children: [
              buildContainer(
                context,
                'Thông tin đơn xin nghỉ',
                Column(
                  children: [
                    buildSelect(
                        context,
                        'Loại đơn xin nghỉ',
                        dataCreateNewTimeBreak['timebreak']['categorybreak'],
                        _listCategorybreak),
                    SizedBox(height: 8),
                    buildSelect(
                        context,
                        'Lý do làm đơn',
                        dataCreateNewTimeBreak['timebreak']['causebreak'],
                        _listCausebreak),
                    SizedBox(height: 8),
                    buildTimePicker(
                      context,
                      'Thời gian bắt đầu',
                      'time_start',
                      Text(
                        DateFormat.yMd().format(
                                dataCreateNewTimeBreak['timebreak']
                                    ['time_start']) +
                            ' - ' +
                            DateFormat.Hms().format(
                                dataCreateNewTimeBreak['timebreak']
                                    ['time_start']),
                        style: TextStyle(color: Color(0xFF303439)),
                      ),
                    ),
                    SizedBox(height: 8),
                    buildTimePicker(
                      context,
                      'Thời gian kết thúc',
                      'time_end',
                      Text(
                        DateFormat.yMd().format(
                                dataCreateNewTimeBreak['timebreak']
                                    ['time_end']) +
                            ' - ' +
                            DateFormat.Hms().format(
                                dataCreateNewTimeBreak['timebreak']
                                    ['time_end']),
                        style: TextStyle(color: Color(0xFF303439)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              buildContainer(
                context,
                'Bàn giao công việc',
                Column(
                  children: [],
                ),
              ),
              SizedBox(height: 16),
              buildContainer(
                context,
                'Thời gian làm bù',
                Column(
                  children: [
                    Wrap(
                      runSpacing: 16,
                      children: dataCreateNewTimeBreak['timeoffset'].map<Widget>(
                            (item) => TimeOfSetItem(
                              item,
                              IconButton(
                                onPressed: () {
                                  deleteTimeOffSetItem(item);
                                },
                                icon: Icon(Icons.delete_outlined, size: 22),
                              ),
                              changeDateTimeOffSet,
                              changeTimeStart,
                            ),
                          ).toList(),
                    ),
                    SizedBox(height: 16),

                    // add more Time off set
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          dataCreateNewTimeBreak['timeoffset'].add({
                            'delete': true,
                            'day': DateTime.now(),
                            'time_start': TimeOfDay(hour: 0, minute: 0),
                            'time_end': TimeOfDay(hour: 0, minute: 0),
                            "user": Provider.of<Auth>(context, listen: false).getAccount['id'].toString(),
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Colors.black,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline_sharp,
                            size: 22,
                          ),
                          SizedBox(width: 4),
                          Text('Thêm thời gian')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              buildContainer(
                context,
                'Kiểm duyệt',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Người kiểm duyệt',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 4),
                    Card(
                      elevation: 0,
                      child: DropdownButtonFormField(
                        menuMaxHeight: 300,
                        value: 1,
                        items: users.map((item) {
                          return DropdownMenuItem<int>(
                            value: item['id'],
                            child: Text(item['full_name']),
                          );
                        }).toList(),
                        onChanged: ((int? value) {
                          setState(
                            () {
                              dataCreateNewTimeBreak['timebreak']
                                  ["user_accept"] = value!;
                            },
                          );
                        }),
                        hint: Container(
                          child: Text(
                            "Chọn người kiểm duyệt",
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFD9DCE0),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFD9DCE0),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFD9DCE0),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        color: Colors.white,
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Row(children: [
          Expanded(
            flex: 1,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Hủy bỏ',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                print(dataCreateNewTimeBreak);
                var data = {...dataCreateNewTimeBreak};
                data['timeoffset'].forEach((item) {
                  item['day'] = DateFormat('y-M-d').format(item['day']).toString();
                  item['time_start'] = '${item['time_start'].hour}:${item['time_start'].minute}';
                  item['time_end'] = '${item['time_end'].hour}:${item['time_end'].minute}';
                });
                data['timebreak']['user_accept'] = [data['timebreak']['user_accept']];
                Provider.of<TimeBreaks>(context, listen: false).handleCreateTimeBreak(data)
                .then((value) {
                  if (value['message']) {
                    Navigator.of(context).pop();
                    showDialog(context: context, builder:(context) {
                      return Noti('Gửi đơn xin nghỉ thành công 🤒', 'success');
                    },);
                  }
                });
              },
              child: Text(
                'Hoàn thành',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline2!.fontSize,
                  fontWeight: Theme.of(context).textTheme.headline2!.fontWeight,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
