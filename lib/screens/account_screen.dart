import 'package:chamcong_app/base/_typography.dart';
import 'package:chamcong_app/providers/auth.dart';

import 'package:chamcong_app/screens/account_info_screen.dart';
import 'package:chamcong_app/screens/change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {

  Widget buildContainer(BuildContext context, String routeName, Widget icon, String title) {
    return InkWell(
      onTap: () {
        title == 'Đăng xuất'
        ? Provider.of<Auth>(context, listen: false).Logout()
        : Navigator.of(context).pushNamed(routeName);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: 8),
            TyphographyBase.h3(context, title, null),
            Spacer(),
            title != 'Đăng xuất' ? Icon(Icons.arrow_right_outlined) : Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TyphographyBase.h3(context, 'Tài khoản', null),
        SizedBox(height: 16),
        buildContainer(context, AccountInfoScreen.routeName, Icon(Icons.manage_accounts), 'Thông tin cá nhân'),
        SizedBox(height: 16),
        buildContainer(context, ChangePasswordScreen.routeName, Icon(Icons.password_sharp), 'Đổi mật khẩu'),
        SizedBox(height: 16),
        // buildContainer(context, '/', Icon(Icons.phone_sharp), 'Hỗ trợ'),
        // SizedBox(height: 16),
        buildContainer(context, '/', Icon(Icons.logout_sharp), 'Đăng xuất'),
      ]),
    );
  }
}
