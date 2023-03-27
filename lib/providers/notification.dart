import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/noti.dart';

class Notifications with ChangeNotifier {
  final String api;
  final Map<String, String> header;

  Notifications(this.api, this.header);

  List<Noti> _notifications = [];

  List<Noti> get notifications {
    return [..._notifications];
  }

  Future<void> handleGetNoti() async {
    _notifications.clear();
    var url = Uri.parse(api);
    var res = await http.get(url, headers: header);
    var data = jsonDecode(utf8.decode(res.bodyBytes));

    data['results'].forEach((item) {
      _notifications.add(Noti(
        id: item['id'],
        status_title: item['status_title'],
        title: item['title'],
        created_at: item['created_at'],
        id_document: item['id_document'],
        status: item['status'],
        user: item['user'],
        user_assign: item['user_assign'],
      ));
    });
  }

  // Future<void> getNotifications
}
