import 'package:chamcong_app/providers/api.dart';
import 'package:chamcong_app/providers/location.dart';
import 'package:chamcong_app/providers/time_work.dart';
import 'package:chamcong_app/screens/timebreak_screen.dart';
import 'package:chamcong_app/widgets/home_page/registerOT.dart';
import 'package:chamcong_app/widgets/noti.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:chamcong_app/providers/auth.dart';
import 'package:provider/provider.dart';

class HomeAction extends StatelessWidget {
  final DateTime dateTime = DateTime.now();

  Future<XFile?> _takePicture() async {
    final ImagePicker _picker = await ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera, maxHeight: 100, maxWidth: 100, imageQuality: 1);
    return photo;
  }

  Widget buildCheckButton(BuildContext context, String typeCheck, Widget content) {
    return ElevatedButton(
      onPressed: () {
        Provider.of<Location>(context, listen: false)
            .getLocation()
            .then((value) {
          print(value);
          _takePicture().then(
            (img) {
              Provider.of<TimeWork>(
                context,
                listen: false,
              ).HandleCreateTimeWork(
                img!,
                value.latitude,
                value.longitude,
                typeCheck,
                Provider.of<API>(context, listen: false).apiDistance,
                Provider.of<API>(context, listen: false).getHeader(Provider.of<Auth>(
                  context,
                  listen: false,
                ).token),
              ).then((value) {
                showDialog(context: context, builder: (BuildContext context) {
                  if (value['status'] == 400) {
                    return Noti('Địa điểm chấm công không trùng với địa điểm đã khai báo 😱 ¯\_(ツ)_/¯', 'warning');
                  } else {
                    return Noti('Bạn đã đăng ký OT thành công 😎', 'success');
                  }
                });
              }).catchError((err) {
                print(err);
              });
            },
          );
        });
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          elevation: 0,
          backgroundColor: Colors.white,
          side: BorderSide(style: BorderStyle.none),
          shape: RoundedRectangleBorder()),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Color(0xFFD9DCE0),
              ),
              right: typeCheck == 'checkin' ? BorderSide(
                color: Color(0xFFD9DCE0),
              ) : BorderSide.none),
        ),
        child: content,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataAccount = Provider.of<Auth>(context).getAccount;
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xFFD9DCE0)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: EdgeInsets.only(right: 16),
                        width: 48,
                        height: 48,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            dataAccount['avatar_file_media'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataAccount['full_name'],
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.fontSize,
                                fontWeight: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.fontWeight,
                                color: Color(0xFF2577C9),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'NVIDT123456789',
                              style: Theme.of(context).textTheme.headline6,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                // Date
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${DateFormat.E().format(dateTime)} ,${DateFormat.yMd().format(dateTime)}',
                        style: TextStyle(
                          fontWeight:
                              Theme.of(context).textTheme.headline1?.fontWeight,
                          fontSize:
                              Theme.of(context).textTheme.headline1?.fontSize,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Hãy chấm công vì chén cơm của bạn',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight:
                              Theme.of(context).textTheme.headline3?.fontWeight,
                          fontSize:
                              Theme.of(context).textTheme.headline3?.fontSize,
                        ),
                      ),
                    ],
                  ),
                ),

                //Checkin/checkout
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: buildCheckButton(context, 'checkin', Column(
                              children: [
                                Icon(
                                  Icons.login,
                                  color: Color(0xFF1AB65C),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Check-in',
                                  style: TextStyle(
                                    color: Color(0xFF1AB65C),
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        ?.fontSize,
                                    fontWeight: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        ?.fontWeight,
                                  ),
                                ),
                              ],
                            ),),
                          ),
                          Expanded(
                            flex: 1,
                            child: buildCheckButton(context, 'checkout', Column(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Color(0xFFD92B6A),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Check-out',
                                  style: TextStyle(
                                    color: Color(0xFFD92B6A),
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        ?.fontSize,
                                    fontWeight: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        ?.fontWeight,
                                  ),
                                )
                              ],
                            ),),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 16,
                                bottom: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                  color: Color(0xFFD9DCE0),
                                )),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return c();
                                      });
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.edit_calendar_sharp,
                                      color: Color(0xFF2577C9),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Đăng ký OT',
                                      style: TextStyle(
                                        color: Color(0xFF2577C9),
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            ?.fontSize,
                                        fontWeight: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            ?.fontWeight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell (
                              onTap: () {
                                Navigator.of(context).pushNamed(TimeBreakScreen.routeName);
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 16,
                                  bottom: 16,
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.sick,
                                      color: Color(0xFF303439),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Xin nghỉ',
                                      style: TextStyle(
                                        color: Color(0xFF303439),
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            ?.fontSize,
                                        fontWeight: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            ?.fontWeight,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
