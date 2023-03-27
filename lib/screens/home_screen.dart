import 'package:chamcong_app/widgets/home_page/historyAction.dart';
import 'package:chamcong_app/widgets/home_page/homeAction.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView (
        child: Column(
          children: [
            HomeAction(),
            HistoryAction(),
          ],
        ),
      ),
    );
  }
}
