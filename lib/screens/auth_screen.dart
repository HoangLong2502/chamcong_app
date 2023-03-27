import 'package:chamcong_app/providers/api.dart';
import 'package:chamcong_app/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _userName;
  var _password;

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    void _handleLogin() {
      var err = _form.currentState!.validate();
      if (!err) {
        return;
      }
      Provider.of<Auth>(context, listen: false)
          .login(
        _userName.toString(),
        _password.toString(),
        Provider.of<API>(context, listen: false).apiLogin,
      )
          .then((_) {
        final String errLogin =
            Provider.of<Auth>(context, listen: false).errLogin;
        if (errLogin != '') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                icon: SvgPicture.asset('assets/svgs/notiWarning.svg'),
                title: Text(
                  'Thông báo',
                  style: Theme.of(context).textTheme.headline1,
                ),
                content: Text(
                  errLogin,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                    fontWeight:
                        Theme.of(context).textTheme.headline5!.fontWeight,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                actions: [
                  Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 34, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                      onPressed: () {
                        Provider.of<Auth>(context, listen: false)
                            .setErrLogin('');
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Đóng',
                      ),
                    ),
                  )
                ],
              );
            },
          );
        }
      });
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logoEcobi.png'),
            SizedBox(height: 78),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Đăng nhập',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      initialValue: _userName,
                      onChanged: (newValue) {
                        _userName = newValue;
                      },
                      //type input
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bạn cần hoàn thiện trường này!';
                        }
                        return null;
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
                        label: Text(
                          'Email',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      initialValue: _password,
                      onChanged: (newValue) {
                        _password = newValue;
                      },
                      //type input
                      obscureText: !_passwordVisible,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bạn cần hoàn thiện trường này!';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) => _handleLogin,
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
                            'Mật khẩu',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                  _passwordVisible = !_passwordVisible;
                              });
                            },
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 78),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _handleLogin,
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline2!.fontSize,
                    fontWeight:
                        Theme.of(context).textTheme.headline2!.fontWeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
