import 'package:flutter/material.dart';

class TyphographyBase {
  static Widget h1(BuildContext context, String title, dynamic color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        color: color == null ? Color(0xFF303439) : color,
      ),
    );
  }

  static Widget h2(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
      ),
    );
  }

  static Widget h3(BuildContext context, String title, dynamic color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        color: color == null ? Color(0xFF303439) : Color(color),
      ),
    );
  }

  static Widget h4(BuildContext context, String title, dynamic color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        color: color == null ? Color(0xFF303439) : Color(color),
      ),
    );
  }

  static Widget t1(BuildContext context, String title, dynamic color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        color: color == null ? Color(0xFF303439) : Color(color),
      ),
    );
  }

  static Widget t2(BuildContext context, String title, dynamic color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: color == null ? Color(0xFF303439) : Color(color),
      ),
    );
  }

  static Widget t3(BuildContext context, String title, dynamic color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        color: color == null ? Color(0xFF303439) : Color(color),
      ),
    );
  }

  static Widget t4(BuildContext context, String title, dynamic color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: color == null ? Color(0xFF303439) : color,
      ),
    );
  }

  static Widget p4(BuildContext context, String title, dynamic color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: color == null ? Color(0xFF303439) : color,
      ),
    );
  }
}
