import 'package:chamcong_app/base/_typography.dart';
import 'package:chamcong_app/providers/notification.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:chamcong_app/models/noti.dart';

class NotiScreen extends StatefulWidget {
  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  List<Noti> _notiNew = [];
  List<Noti> _notiOld = [];
  @override
  void didChangeDependencies() {
    var dataNoti = Provider.of<Notifications>(context).notifications;
    dataNoti.forEach((item) {
      if (item.status == 2) {
        setState(() {
          _notiOld.add(item);
        });
      } else if (item.status == 1) {
        _notiNew.add(item);
      }
    });
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Widget buildItem(BuildContext context, Noti noti) {
    final screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Thông báo mới về đơn ',
              style: TextStyle(
                color: Colors.black,
                fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                fontWeight: Theme.of(context).textTheme.headline5?.fontWeight,
              ),
              children: [
                TextSpan(
                  text: '${noti.title}',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text('${DateFormat.Hm().format(DateFormat('yyyy-MM-dd hh:mm:ss').parse('2012-02-27 13:27:00,123456789z'))}'),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return SingleChildScrollView (
      child: Container(
        width: screen.width,
        // height: screen.height,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TyphographyBase.h2(context, 'Thông báo'),
            SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TyphographyBase.h3(context, 'Mới', null),
                    SizedBox(width: 8),
                    CircleAvatar(
                      maxRadius: 10,
                      backgroundColor: Color(0xFFF8EBED),
                      child: TyphographyBase.h4(context,'${_notiNew.length}', 0xFFEF4923),
                    )
                  ],
                ),
                Column(
                  children: _notiNew.map((noti) {
                    return buildItem(context, noti);
                  }).toList(),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    TyphographyBase.h3(context, 'Trước đó', null),
                    SizedBox(width: 8),
                    CircleAvatar(
                      maxRadius: 10,
                      backgroundColor: Color(0xFFF8EBED),
                      child: TyphographyBase.h4(context,'${_notiOld.length}', 0xFFEF4923),
                    )
                  ],
                ),
                Column(
                  children: _notiOld.map((noti) {
                    return buildItem(context, noti);
                  }).toList(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
