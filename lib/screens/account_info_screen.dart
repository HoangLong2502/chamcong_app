import 'dart:io';

import 'package:chamcong_app/base/_colors.dart';
import 'package:chamcong_app/base/_typography.dart';
import 'package:chamcong_app/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AccountInfoScreen extends StatefulWidget {
  static String routeName = '/account_info_screen';

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  Map account = {};

  bool _isInit = true;

  dynamic imageFile = null;

  Future<XFile?> _takePicture() async {
    final ImagePicker _picker = await ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery, maxHeight: 300, maxWidth: 300, imageQuality: 100);
    return photo;
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        account = Provider.of<Auth>(context).getAccount;
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin cá nhân'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        imageFile == null ?
                        CircleAvatar(
                          minRadius: 50,
                          backgroundImage:
                              NetworkImage(account['avatar_file_media']),
                        ) : CircleAvatar(
                          minRadius: 50,
                          backgroundImage:
                              FileImage(imageFile),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              _takePicture().then((value) {
                                if (value != null) {
                                  setState(() {
                                    imageFile = File(value.path);
                                  });
                                }
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Color(0xFF06C270),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TyphographyBase.h3(context, account['full_name'], null),
                        SizedBox(height: 8),
                        TyphographyBase.p4(
                            context, '${account['sex']}', colors.c_text_g),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.phone_outlined, size: 21),
                            SizedBox(width: 8),
                            TyphographyBase.p4(
                                context, account['phone'], colors.c_text_g)
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 32),
                TextFormField(
                  initialValue: account['email'],
                  onChanged: (value) {
                    setState(() {
                      account['email'] = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    label: Text('Email',
                        style: Theme.of(context).textTheme.headline5),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TyphographyBase.p4(context, 'Ngày sinh', colors.c_text_g),
                      InkWell(
                        onTap: () {
                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime.now())
                          .then((value) {
                            print(value);
                            setState(() {
                              if (value != null) {
                                account['birthday'] = DateFormat('y-M-d').format(value);
                              }
                            });
                            print(account['birthday']);
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xFFD9DCE0)))
                          ),
                          child: TyphographyBase.t4(context, account['birthday'], null),
                        ),
                      )
                  ],),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TyphographyBase.p4(context, 'Ngày vào', colors.c_text_g),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xFFD9DCE0)))
                          ),
                          child: TyphographyBase.t4(context, account['date_joined'], null),
                        ),
                      )
                  ],),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TyphographyBase.p4(context, 'Phòng ban', colors.c_text_g),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xFFD9DCE0)))
                          ),
                          child: TyphographyBase.t4(context, account['room_title'], null),
                        ),
                      )
                  ],),
                ),
                SizedBox(height: 16),
                TextFormField(
                  initialValue: account['location_title'][0]['title_location'],
                  onChanged: (value) {
                    setState(() {
                      account['location_title'][0]['title_location'] = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    label: TyphographyBase.p4(context, 'Địa chỉ', colors.c_text_g)
                  ),
                ),
                // Text(account.toString()),
              ]),
            ),
            SizedBox(height: 24),
            //button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<Auth>(context, listen: false).editMyAccount(account, imageFile);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: TyphographyBase.h4(context, 'Lưu lại', 0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
