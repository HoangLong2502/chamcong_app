// import 'package:flutter/foundation.dart';

class Noti {
  final int id;
  final String status_title;
  final String title;
  final String created_at;
  final String id_document;
  final int status;
  final int user;
  final int user_assign;

  Noti({
    required this.id,
    required this.status_title,
    required this.title,
    required this.created_at,
    required this.id_document,
    required this.status,
    required this.user,
    required this.user_assign,
  });
}