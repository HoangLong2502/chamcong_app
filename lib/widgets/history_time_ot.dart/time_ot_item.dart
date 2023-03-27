import 'package:chamcong_app/base/_colors.dart';
import 'package:chamcong_app/base/_typography.dart';
import 'package:chamcong_app/models/time_ot.dart';
import 'package:chamcong_app/providers/auth.dart';
import 'package:chamcong_app/screens/timeot_timebreak_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeOtItem extends StatelessWidget {
  final TimeOt data;

  TimeOtItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TyphographyBase.t3(context, data.user_created_name, null),
                    SizedBox(height: 8),
                    TyphographyBase.p4(
                        context, data.created_at, colors.c_text_g),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.c_blue_2,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(TimeOTWorkDetail.routeName, arguments: {
                      'type' : 'timeot',
                      'dataDetail' : data,
                    });
                  },
                  child: Text(
                    'Chi tiết',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: colors.c_blue_1),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TyphographyBase.p4(
                        context, 'Thời gian nghỉ', colors.c_text_g),
                    TyphographyBase.t4(
                        context, '${data.time_start} ${data.day}', null)
                  ],
                ),
                SizedBox(height: 16),
                if (data.cause == 1)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: colors.c_green_2),
                    child: Center(
                        child: TyphographyBase.t4(
                            context, 'Đã phê duyệt', colors.c_green_1)),
                  ),
                if (data.cause == 2)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: colors.c_red_2),
                    child: Center(
                        child: TyphographyBase.t4(
                            context, 'Đã từ chối', colors.c_red_1)),
                  ),
                if (data.cause == 3)
                  data.user_assign ==
                          Provider.of<Auth>(context).getAccount['id']
                      ? Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: TyphographyBase.t4(
                                    context, 'Từ chối', null),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                child: TyphographyBase.t4(
                                    context, 'Phê duyệt', colors.c_text_w),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: colors.c_border_1),
                          child: Center(
                              child: TyphographyBase.t4(context,
                                  'Đang chờ phê duyệt', colors.c_text_g)),
                        ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
