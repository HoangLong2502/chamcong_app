import 'package:chamcong_app/models/time_ot.dart';
import 'package:chamcong_app/providers/time_ot.dart';
import 'package:chamcong_app/widgets/history_time_ot.dart/time_ot_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Type { assign, create }

class HistoryTimeOt extends StatefulWidget {
  static String routeName = 'history_time_ot';

  @override
  State<HistoryTimeOt> createState() => _HistoryTimeOtState();
}

class _HistoryTimeOtState extends State<HistoryTimeOt> {
  List<TimeOt> _listDataOt =   [];
  Type _selectedSegment = Type.assign;

  bool _isLoading = true;

  bool _isFilter = false;

  void _handleGetData(BuildContext context, String type) {
    Provider.of<TimeOT>(context, listen: false).getDataTimeOt(type).then((_) {
      setState(() {
        _listDataOt = Provider.of<TimeOT>(context, listen: false).dataTimeOT;
        _isLoading = false;
        _isFilter = false;
      });
    });
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    _handleGetData(context, 'user_assign');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Lịch sử đăng ký OT')),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
            )
          : SingleChildScrollView(
              child: Container(
                width: size.width,
                height: size.height,
                padding: EdgeInsets.all(16),
                color: Theme.of(context).backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CupertinoSlidingSegmentedControl(
                      thumbColor: Theme.of(context).primaryColor,
                      groupValue: _selectedSegment,
                      onValueChanged: (Type? value) {
                        _handleGetData(
                            context,
                            value == Type.assign
                                ? 'user_assign'
                                : 'user_created');
                        setState(() {
                          _selectedSegment = value!;
                          _isFilter = true;
                        });
                      },
                      children: <Type, Widget>{
                        Type.assign: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                          child: Text(
                            'Đơn OT cần duyệt',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: _selectedSegment == Type.assign
                                          ? Colors.white
                                          : Color.fromARGB(67, 0, 0, 0),
                                    ),
                          ),
                        ),
                        Type.create: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                          child: Text(
                            'Đơn OT chờ duyệt',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: _selectedSegment == Type.create
                                          ? Colors.white
                                          : Color.fromARGB(74, 0, 0, 0),
                                    ),
                          ),
                        ),
                      },
                    ),
                    SizedBox(height: 16),
                    _isFilter
                        ? Center(
                            child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
                          )
                        : Container(
                            width: size.width,
                            height: size.height - 200,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return TimeOtItem(_listDataOt[index]);
                              },
                              itemCount: _listDataOt.length,
                            ),
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
