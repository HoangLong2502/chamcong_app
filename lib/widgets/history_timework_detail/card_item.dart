import 'package:chamcong_app/base/_colors.dart';
import 'package:flutter/material.dart';
import 'package:chamcong_app/base/_typography.dart';

class HistoryCardItem extends StatelessWidget {
  final String title;
  final Map data;

  HistoryCardItem(this.title, this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TyphographyBase.h3(context, data['day'], null),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: [
              title.toString().toLowerCase() == 'đi muộn'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TyphographyBase.p4(context, 'Giờ vào', colors.c_text_g),
                        TyphographyBase.t4(
                            context, data['checkin'], null)
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TyphographyBase.p4(context, 'Giờ ra', colors.c_text_g),
                        TyphographyBase.t4(
                            context, data['checkout'], null)
                      ],
                    ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TyphographyBase.p4(context, 'Địa điểm', colors.c_text_g),
                  TyphographyBase.t4(context, '48 Tố Hữu', null)
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
