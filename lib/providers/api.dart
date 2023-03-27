import 'package:flutter/material.dart';

class API with ChangeNotifier {

  final String apiLogin = 'https://api.chamcong.co/login/';
  final String apiTimework = 'https://api.chamcong.co/v1/api/timework/';
  final String apiDistance = 'https://api.chamcong.co/v1/api/checktime/';
  final String apiAllAccount = 'https://api.chamcong.co/getchoiceaccount';

  Map<String, String> getHeader(token) {
    return {
      "Content-type": "application/json; charset=utf-8",
      "Accept": "application/json; charset=utf-8",
      "Authorization" : "Token " + token,
    };
  }
}