import 'package:flutter/material.dart';

class CircleProgrss extends StatelessWidget {
  final String title;
  final int count;
  final String label1;
  final int value1;
  final String label2;
  final int value2;
  final AnimationController controller;

  CircleProgrss(
    this.title,
    this.count,
    this.label1,
    this.value1,
    this.label2,
    this.value2,
    this.controller
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF1AB65C),
                borderRadius: BorderRadius.circular(50),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline3!.fontSize,
                  fontWeight: Theme.of(context).textTheme.headline3!.fontWeight,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 60,
              height: 60,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: controller.value,
                        backgroundColor: Colors.grey[300]!,
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Center(
                      child: Text(
                        count < 10 ? '0${count}' : count.toString(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(label1), Text(value1.toString())],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(label2), Text(value2.toString())],
            )
          ],
        ),
      ),
    );
  }
}
