import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color kPrimaryColorlight = Color.fromARGB(255, 212, 241, 254);
const Color kPrimaryColordark = Color(0xFF286B8C);
const Color kBNavigationColordark = Color(0xFF050736);
const Color kSecondColorlight = Color(0xFFF5F5F5);
const Color kSecondColorDark = Color(0xFFECECEC);

class Convert {
  static String convertTimeFormat({required DateTime dateTime}) {
    return DateFormat('hh:mm a').format(dateTime);
  }
}

const int resOk = 1;
const int resFail = 0;
const int resEmail = 2;
const icon = "assets/images/icon.png";
