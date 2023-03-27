import 'package:flutter/material.dart';
import 'package:chamcong_app/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Noti extends StatelessWidget {
  final String title;
  final String icon;

  Noti(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon == 'warning'
          ? SvgPicture.asset('assets/svgs/notiWarning.svg')
          : SvgPicture.asset('assets/svgs/notiSuccess.svg'),
      title: Text(
        'Thông báo',
        style: Theme.of(context).textTheme.headline1,
      ),
      content: Text(
        title,
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
            },
            child: Text(
              'Đóng',
            ),
          ),
        )
      ],
    );
  }
}
