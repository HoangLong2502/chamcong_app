import 'package:chamcong_app/providers/auth.dart';
import 'package:chamcong_app/providers/time_ot.dart';
import 'package:chamcong_app/providers/users.dart';
import 'package:chamcong_app/widgets/noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class RegisterOT extends StatefulWidget {
  @override
  State<RegisterOT> createState() => _RegisterOTState();
}

class _RegisterOTState extends State<RegisterOT> {
  final List<Map<String, dynamic>> _listReason = [
    {
      'checked': false,
      'reason': 'Hoàn thành công việc trong dự án',
    },
    {
      'checked': false,
      'reason': 'Hỗ trợ nhân sự phòng ban khác',
    },
    {
      'checked': false,
      'reason': 'Công việc văn phòng',
    },
    {
      'checked': false,
      'reason': 'Họp nội bộ',
    },
    {
      'checked': false,
      'reason': 'Có lịch họp với khách hàng',
    },
    {
      'checked': false,
      'reason': 'Lý do khác',
    },
  ];
  List _userAssigne = [];

  String _reasonSelect = '';

  String _userAssignSelect = '0';

  bool isChecked = false;

  TimeOfDay _timeNow = TimeOfDay.now();

  void _showTimePicker() async {
    showTimePicker(
      context: context,
      initialTime: _timeNow,
    ).then((value) {
      if (value != null) {
        setState(() {
          _timeNow = value;
        });
      } else {
        return;
      }
    });
  }

  @override
  void didChangeDependencies() {
    Provider.of<Users>(context).getAllAccount().then((value) {
      setState(() {
        _userAssigne = value;
        _userAssignSelect = value[0]['id'].toString();
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Theme.of(context).primaryColor;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lý do đăng ký OT',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                  fontWeight: Theme.of(context).textTheme.headline5?.fontWeight,
                ),
              ),
              SizedBox(
                height: 8,
              ),

              // Reason OT
              Container(
                child: Column(
                  children: _listReason.map((e) {
                    return Card(
                      elevation: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFD9DCE0)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: e['checked'],
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              checkColor: Colors.white,
                              onChanged: (bool? value) {
                                _listReason.forEach((element) {
                                  setState(() {
                                    element['checked'] = false;
                                  });
                                });
                                setState(() {
                                  e['checked'] = value!;
                                  _reasonSelect = e['reason'];
                                });
                              },
                            ),
                            Container(
                              child: Text(
                                '${e['reason']}',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 16,
              ),

              // Time OT
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thời gian OT',
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
                        _showTimePicker();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_timeNow.hour}:${_timeNow.minute}',
                            style: TextStyle(color: Color(0xFF303439)),
                          ),
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
              ),
              SizedBox(
                height: 16,
              ),

              //User Assigne
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
                      value: _userAssignSelect,
                      items: _userAssigne.map((item) {
                        return DropdownMenuItem<String>(
                          value: item['id'].toString(),
                          child: Text(item['full_name']),
                        );
                      }).toList(),
                      onChanged: ((String? value) {
                        setState(
                          () {
                            _userAssignSelect = value!;
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
              ),
              SizedBox(height: 24),

              //
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Đóng',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Noti(
                              'Đang tạo đơn OT!, vui lòng đợi ^.^',
                              'warning',
                            ),
                          );
                          Provider.of<TimeOT>(context, listen: false)
                              .handleCreateTimeOT(
                            {
                              'cause': 3,
                              'title': _reasonSelect,
                              'user_assign': _userAssignSelect,
                              'user_created':
                                  Provider.of<Auth>(context, listen: false)
                                      .getAccount['id'],
                            },
                          ).then((_) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                icon:  SvgPicture.asset('assets/svgs/notiSuccess.svg'),
                                title: Text(
                                  'Thông báo',
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                content: Text(
                                  'Bạn đã đăng ký OT thành công 😎 (◉ω◉)',
                                  style: TextStyle(
                                    fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                                    fontWeight: Theme.of(context).textTheme.headline5!.fontWeight,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                actions: [
                                  Center(
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 34, vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          )),
                                      onPressed: () {
                                        Provider.of<Auth>(context, listen: false).setErrLogin('');
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Đóng',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                        },
                        child: Text(
                          'Hoàn thành',
                          style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.headline3?.fontSize,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.fontWeight,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
