import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TimeWork with ChangeNotifier {
  final String api;
  final int accountId;
  final header;

  TimeWork(this.api, this.accountId, this.header);

  List _timeWorks = [];

  List get timeWorks {
    // print(DateTime.now().subtract(Duration(days: 1)));
    if (_timeWorks.length == 0) {
      HandleGetTimeWork().then((value) {
        return value;
      });
    }
    return [..._timeWorks];
  }

  Future<List> HandleGetTimeWork() async {
    var url = Uri.parse(api);
    var res = await http.get(url, headers: header);
    _timeWorks = json.decode(res.body)['results'];
    return json.decode(res.body)['results'];
  }

  Future<List> HandleGetTimeWorkByMonth(String month) async {
    var day_before  = DateFormat('y-M-d').format(DateTime(2022, int.parse(month) + 1, 1).subtract(Duration(days: 1)));
    var url = Uri.parse(
        api + '?day_after=2022-${month}-01&day_before=${day_before}&user=$accountId');
    var res = await http.get(url, headers: header);
    return json.decode(res.body)['results'];
  }

  //function create new time work
  Future<Map> HandleCreateTimeWork(
    XFile image,
    double lat,
    double lng,
    String type,
    String api,
    Map<String, String> headers,
  ) async {
    // secret key to checkin
    final String keyHash = 'idtinc' +
        DateTime.now().day.toString() +
        (DateTime.now().month).toString();

    final String hash = BCrypt.hashpw(keyHash, BCrypt.gensalt(logRounds: 10));

    // create method post
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(api),
    );
    request.fields["lat"] = lat.toString();
    request.fields["lng"] = lng.toString();
    request.fields["type"] = type;
    request.fields["key"] = hash;

    print(api);

    //add header
    request.headers.addAll(headers);

    //add image file
    var pic = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(pic);

    //post and wait response
    try {
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      return Future.value(json.decode(respStr));
    } catch (err) {
      throw err;
    }
  }
}
