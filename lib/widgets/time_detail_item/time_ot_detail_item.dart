import 'package:chamcong_app/base/_colors.dart';
import 'package:chamcong_app/base/_typography.dart';
import 'package:chamcong_app/models/time_ot.dart';
import 'package:chamcong_app/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimeOtDetailItem extends StatelessWidget {
  final TimeOt dataDetail;

  TimeOtDetailItem(this.dataDetail);

  Widget buildContainer(BuildContext context, Widget child) {
    return Container(
      padding: EdgeInsets.all(16),
      child: child,
    );
  }

  Widget buildRow(BuildContext context, String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TyphographyBase.p4(context, title, colors.c_text_g),
        TyphographyBase.t4(context, content, null),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              buildContainer(
                context,
                Column(
                  children: [
                    buildRow(
                        context, 'Người đăng ký', dataDetail.user_created_name),
                    SizedBox(height: 16),
                    buildRow(
                        context,
                        'Thời gian tạo đơn',
                        DateFormat('EEE, d-M-y')
                            .format(DateTime.parse(dataDetail.created_at))),
                  ],
                ),
              ),
              Divider(height: 1),
              buildContainer(
                context,
                Column(
                  children: [
                    buildRow(context, 'Thời gian OT',
                        '${dataDetail.time_start} - ${dataDetail.day}'),
                    SizedBox(height: 16),
                    buildRow(context, 'Lý do đăng ký OT', dataDetail.title)
                  ],
                ),
              ),
              Divider(height: 1),
              buildContainer(
                context,
                Column(
                  children: [
                    buildRow(context, 'Người kiểm duyệt',
                        dataDetail.user_assign_name)
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: dataDetail.cause == 3
              ? dataDetail.user_assign ==
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
                        color: colors.c_border_1,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: TyphographyBase.t4(
                            context, 'Đang chờ phê duyệt', colors.c_text_g),
                      ),
                    )
              : dataDetail.cause == 2
                  ? Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: colors.c_red_2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: TyphographyBase.t4(
                            context, 'Đã từ chối', colors.c_red_1),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: colors.c_green_2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: TyphographyBase.t4(
                            context, 'Đã phê duyệt', colors.c_green_1),
                      ),
                    ),
        )
      ],
    );
  }
}
