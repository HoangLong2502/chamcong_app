import 'package:chamcong_app/base/_colors.dart';
import 'package:chamcong_app/base/_typography.dart';
import 'package:flutter/material.dart';

class TimeWorkItem extends StatelessWidget {
  final String date;
  final String checkin;
  final String checkout;

  TimeWorkItem(this.date, this.checkin, this.checkout);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TyphographyBase.t2(context, date, null),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    height: 50,
                    child: GridView(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 4
                        // childAspectRatio: 1
                      ),
                      children: [
                        TyphographyBase.p4(context, 'Giờ vào:', colors.c_text_g),
                        Text(checkin),
                        TyphographyBase.p4(context, 'Giờ ra:', colors.c_text_g),
                        Text(checkout == checkin ? 'Chưa checkout' : checkout),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_right))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
