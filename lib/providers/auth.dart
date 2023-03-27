import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  // Token
  var token;

  // List Api
  final String apiLogin = 'https://api.chamcong.co/login/';
  final String apiTimework = 'https://api.chamcong.co/v1/api/timework/';
  final String apiDistance = 'https://api.chamcong.co/v1/api/checktime/';
  final String apiAllAccount = 'https://api.chamcong.co/getchoiceaccount';
  final String apiTimebreak = 'https://api.chamcong.co/createtimebreak';
  final String apiTimeOT = 'https://api.chamcong.co/v1/api/ot/';
  final String apiNoti = 'https://api.chamcong.co/v1/api/notice/';

  // Header
  Map<String, String> getHeader() {
    return {
      "Content-type": "application/json; charset=utf-8",
      "Accept": "application/json; charset=utf-8",
      "Authorization" : "Token " + token,
    };
  }

  Map<String, dynamic> _account = {};
  var _isAuth = false;
  var errLogin = '';

  dynamic get isAuth {
    if (_isAuth) {
      return true;
    }
    return false;
  }

  void setErrLogin (value) {
    errLogin = '';
  }

  get getAccount {
    return {..._account};
  }

  Future<void> login(String userName, String password, String api) async {
    final url = Uri.parse(api);
    Map<String, String> userHeader = {
      "Content-type": "application/json; charset=utf-8",
      "Accept": "application/json; charset=utf-8"
    };
    try {
      final res = await http.post(
        url,
        body: json.encode(
          {
            'username': userName,
            'password': password,
          },
        ),
        headers: userHeader,
      );
      final data = json.decode(res.body);
      if (data['detail'] == 'No such user' || data['message'] == 'Sai mat khau') {
        errLogin = 'Bạn đã điền sai tài khoản hoặc mật khẩu';
      } 
      else {
        var dataDecode = jsonDecode(utf8.decode(res.bodyBytes));
        token = dataDecode['token'];
        _account = dataDecode['data'];
        _isAuth = true;
      }
      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }

  // -------- Update Account ----------- //
  Future<void> editMyAccount(Map dataUpdate, dynamic imgUpdate) async {
    if (imgUpdate != null) {
      var request = http.MultipartRequest('POST', Uri.parse('https://api.chamcong.co/v1/api/mediaaccount/'));

      request.fields.addAll({
        'title_media' : Random().nextInt(100000000).toString(),
      });

      request.files.add(await http.MultipartFile.fromPath('file_media', imgUpdate.path));

      request.headers.addAll(getHeader());

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        var res = await response.stream.bytesToString();
        var data = json.decode(res);

        var dataUpdateAccount = json.encode({
          'avatar' : data['id'],
          'email' : dataUpdate['email'],
          'date_joined' : dataUpdate['date_joined'],
          'birthday' : dataUpdate['birthday'],
        });

        var url = Uri.parse('https://api.chamcong.co/v1/api/account/${_account['id']}/');

        var resUpdate = await http.patch(url, body: dataUpdateAccount, headers: getHeader());

        _account = jsonDecode(utf8.decode(resUpdate.bodyBytes));

        notifyListeners();
      }
    }
  }
  // -------- Change Password ----------- //
  Future<dynamic> ChangePassword(List passwords) async {
    var data = json.encode({
      'oldpassword' : passwords[0]['oldpassword'],
      'newpassword' : passwords[1]['newpassword']
    });
    var url = Uri.parse('https://api.chamcong.co/changepassword/${_account['id']}');
    var res = await http.post(url, body: data, headers: getHeader());

    print(json.decode(res.body));
    return json.decode(res.body);
  }

  // -------- Logout ----------- //
  void Logout() {
    _isAuth = false;
    notifyListeners();
    // _account = {};
    token = '';
    
  }


}
