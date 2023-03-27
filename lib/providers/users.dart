import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  final String token;
  final String api;
  final header;

  Users(this.token, this.api, this.header);

  List _users = [];

  List get users {
    return [..._users];
  }

  Future<List> getAllAccount() async {
    if (_users.length == 0) {
      final url = Uri.parse(api);
      var data = await http.get(url, headers: header);
      _users = json.decode(data.body)['data'];
      return json.decode(data.body)['data'];
    } else {
      return _users;
    }
  }
}