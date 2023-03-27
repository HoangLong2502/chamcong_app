import 'package:chamcong_app/base/_typography.dart';
import 'package:chamcong_app/providers/auth.dart';
import 'package:chamcong_app/widgets/noti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  static String routeName = '/change_password_screen';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  List<Map<String, dynamic>> passwords = [
    {
      'oldpassword': '',
      'show': false,
    },
    {
      'newpassword': '',
      'show': false,
    },
    {
      'repeatpassword': '',
      'show': false,
    }
  ];

  final _form = GlobalKey<FormState>();

  Widget buildTextField(
      BuildContext context, String title, String value, bool show) {
    return TextFormField(
      initialValue: value,
      onChanged: (newValue) {
        switch (title) {
          case 'Mật khẩu cũ':
            passwords[0]['oldpassword'] = newValue;
            break;
          case 'Mật khẩu mới':
            passwords[1]['newpassword'] = newValue;
            break;
          case 'Xác nhận mật khẩu':
            passwords[2]['repeatpassword'] = newValue;
            break;
          default:
        }
      },
      //type input
      obscureText: !show,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Bạn cần hoàn thiện trường này!';
        }
        return null;
      },
      // onFieldSubmitted: (value) => _handleLogin,
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
        label: Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            show ? Icons.visibility : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              switch (title) {
                case 'Mật khẩu cũ':
                  passwords[0]['show'] = !passwords[0]['show'];
                  break;
                case 'Mật khẩu mới':
                  passwords[1]['show'] = !passwords[1]['show'];
                  break;
                case 'Xác nhận mật khẩu':
                  passwords[2]['show'] = !passwords[2]['show'];
                  break;
                default:
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void _changePassword() {
      var err = _form.currentState!.validate();
      if (!err) {
        return;
      }
      if (passwords[1]['newpassword'] != passwords[2]['repeatpassword']) {
        showDialog(
          context: context,
          builder: (context) =>
              Noti('Mật khẩu không khớp 💩 (ノಠ益ಠ)', 'warning'),
        );
      } else {
        Provider.of<Auth>(context, listen: false)
            .ChangePassword(passwords)
            .then((value) {
          if (value['message'] == 'oldPassword incorrect') {
            showDialog(
              context: context,
              builder: (context) =>
                  Noti('Mật khẩu cũ không đúng ❌  (;´༎ຶД༎ຶ`)', 'warning'),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) =>
                  Noti('Đã đổi mật khẩu thành công 🔐 ٩(♡ε♡ )۶', 'success'),
            );
          }
        }).catchError((err) {
          showDialog(
            context: context,
            builder: (context) => Noti('(;´༎ຶД༎ຶ`)', 'warning'),
          );
        });
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Đổi mật khẩu')),
      body: Container(
          padding: EdgeInsets.all(16),
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Form(
                  key: _form,
                  child: Column(children: [
                    buildTextField(context, 'Mật khẩu cũ',
                        passwords[0]['oldpassword'], passwords[0]['show']),
                    SizedBox(height: 16),
                    buildTextField(context, 'Mật khẩu mới',
                        passwords[1]['newpassword'], passwords[1]['show']),
                    SizedBox(height: 16),
                    buildTextField(context, 'Xác nhận mật khẩu',
                        passwords[2]['repeatpassword'], passwords[2]['show']),
                  ]),
                ),
              ),
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _changePassword();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: TyphographyBase.h4(
                      context, 'Thay đổi mật khẩu', 0xFFFFFFFF),
                ),
              )
            ],
          )),
    );
  }
}
