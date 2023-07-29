import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color kPrimaryColorLight = Color.fromARGB(255, 212, 241, 254);
const Color kPrimaryColorDark = Color(0xFF286B8C);
const Color kBNavigationColorDark = Color(0xFF050736);
const Color kSecondColorLight = Color(0xFFF5F5F5);
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
const filter = "assets/images/filter.png";
