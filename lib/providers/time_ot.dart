import 'dart:convert';

import 'package:chamcong_app/models/time_ot.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TimeOT with ChangeNotifier {
  final String token;
  final String api;
  final int accountId;
  final Map<String, String> header;

  TimeOT(this.token, this.api, this.accountId, this.header);

  List<TimeOt> _dataTimeOT = [];

  List<TimeOt> get dataTimeOT {
    return [..._dataTimeOT];
  }

  Future<void> getDataTimeOt(String type) async {
    _dataTimeOT.clear();

    var url = Uri.parse(api + '?' + type + '=$accountId');
    var res = await http.get(url, headers: header);
    var data = jsonDecode(utf8.decode(res.bodyBytes));

    data['results'].forEach((item) => {
          _dataTimeOT.add(TimeOt(
            id: item['id'],
            cause_title: item['cause_title'],
            user_created_name: item['user_created_name'],
            user_assign_name: item['user_assign_name'],
            user_created_avatar: item['user_created_avatar'],
            user_assign_avatar: item['user_assign_avatar'],
            title: item['title'],
            day: item['day'],
            created_at: item['created_at'],
            updated_at: item['updated_at'],
            time_start: item['time_start'],
            time_end: item['time_end'],
            status: item['status'],
            task: item['task'],
            cause: item['cause'],
            user_created: item['user_created'],
            user_assign: item['user_assign'],
          ))
        });

    // _dataTimeOT = data['results'];
  }

  Future<void> handleCreateTimeOT(payloadData) async {
    print(payloadData);
    var url = Uri.parse(api);
    var data = json.encode(payloadData);
    try {
      var res = await http.post(url, body: data, headers: header);
      print(utf8.decode(res.bodyBytes));
    } catch (err) {
      throw err;
    }
  }
}
