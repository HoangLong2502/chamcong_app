import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TimeBreaks with ChangeNotifier {
  final String token;
  final String api;
  final int accountId;
  final Map<String, String> header;

  TimeBreaks(this.token, this.api, this.accountId, this.header);

  //Time Break
  List timeBreaks = [];


  // ------ function create new time break-------
  Future<Map> handleCreateTimeBreak(dataCreateNewTimeBreak) async {
    var url = Uri.parse(api);

    dataCreateNewTimeBreak['timebreak']['time_start'] = dataCreateNewTimeBreak['timebreak']['time_start'].toString();
    dataCreateNewTimeBreak['timebreak']['time_end'] = dataCreateNewTimeBreak['timebreak']['time_end'].toString();
    var data = jsonEncode(dataCreateNewTimeBreak);
    var res = await http.post(
      url,
      body: data,
      headers: header,
    );
    return jsonDecode(utf8.decode(res.bodyBytes));
  }

  // -------- function get time break by month--------
  Future<List> handleGetTimeBreakByMonth(String month) async {
    var day_before  = DateFormat('y-M-d').format(DateTime(2022, int.parse(month) + 1, 1).subtract(Duration(days: 1)));
    var url = Uri.parse(
      'https://api.chamcong.co/v1/api/timebreak?time_start_after=2022-${month}-01&time_start_before=${day_before}&user=$accountId');
    var res = await http.get(url, headers: header);
    
    return jsonDecode(utf8.decode(res.bodyBytes))['results'];
  }

  // Categorybreak
  List _categorybreaks = [];

  get categorybreaks {
    return [..._categorybreaks];
  }

  Future<List> getCategorybreak() async {
    if (_categorybreaks.length == 0) {
      var url = Uri.parse('https://api.chamcong.co/v1/api/categorybreak/');
      var res = await http.get(url, headers: header);
      _categorybreaks = jsonDecode(utf8.decode(res.bodyBytes))['results'];
      return _categorybreaks;
    } else {
      return _categorybreaks;
    }
  }

  // causebreak
  List _causebreaks = [];

  get causebreaks {
    return [..._causebreaks];
  }

  Future<List> getCausebreak() async {
    if (_causebreaks.length == 0) {
      var url = Uri.parse('https://api.chamcong.co/v1/api/causebreak/');
      var res = await http.get(url, headers: header);
      _causebreaks = jsonDecode(utf8.decode(res.bodyBytes))['results'];
      return _causebreaks;
    } else {
      return _causebreaks;
    }
  }
}
