import 'package:chamcong_app/widgets/time_detail_item/time_break_detail_item.dart';
import 'package:chamcong_app/widgets/time_detail_item/time_ot_detail_item.dart';
import 'package:flutter/material.dart';

class TimeOTWorkDetail extends StatefulWidget {
  static String routeName = 'time_ot_work_detail';
  @override
  State<TimeOTWorkDetail> createState() => _TimeOTWorkDetailState();
}

class _TimeOTWorkDetailState extends State<TimeOTWorkDetail> {
  dynamic dataProp;
  dynamic dataDetail;
  @override
  void didChangeDependencies() {
    setState(() {
      dataProp = ModalRoute.of(context)?.settings.arguments as Map;
      dataDetail = dataProp['dataDetail'];
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(dataProp['type'] == 'timeot'
            ? 'Chi tiết đơn xin OT'
            : 'Chi tiết đơn xin nghỉ'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Theme.of(context).backgroundColor,
        height: size.height,
        width: size.width,
        child: dataProp['type'] == 'timeot'
            ? TimeOtDetailItem(dataDetail)
            : TimeBreakDetailItem(),
      ),
    );
  }
}
