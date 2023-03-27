import 'package:chamcong_app/widgets/history_timework_detail/card_item.dart';
import 'package:flutter/material.dart';

class HistoryTimeWorkDetailScreen extends StatelessWidget {
  static String routeName = '/history_timework_detail';

  @override
  Widget build(BuildContext context) {
    final dataWorks = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử ${dataWorks['title'].toString().toLowerCase()}'),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(16),
          color: Theme.of(context).backgroundColor,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return HistoryCardItem(dataWorks['title'], dataWorks['data'][index]);
            },
            itemCount: dataWorks['data'].length,
          )),
    );
  }
}
