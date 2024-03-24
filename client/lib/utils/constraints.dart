import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color kPrimaryColorLight = Color.fromARGB(255, 212, 241, 254);
const Color kPrimaryColorDark = Color(0xFF00B0F0);
const Color kBNavigationColorDark = Color(0xFF050736);
const Color kSecondColorLight = Color(0xFFF5F5F5);
const Color kSecondColorDark = Color(0xFFECECEC);
const Color kNavItemsColor = Color(0xFF00B0F0);
const Color kSNavItemsColor = Color(0xFFE5E5E5);
const Color kNavBarColor = Color(0xFFEEEEEE);
const kPrimaryErrorColor = Color(0xFFFF4949);
const Color kSecondaryTextColorDark = Color(0xFF747E80);

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
const userIcon = "assets/images/user.png";
const login = "assets/images/login.png";
const on1 = "assets/images/on1.jpeg";
const on2 = "assets/images/on2.jpg";
const on3 = "assets/images/on3.png";
const nodata = "assets/images/nodata.svg";

const forgotAnim = "assets/anim/forgot.json";
const nodataAnim = "assets/anim/nodata.json";

const testText =
    "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.";
const onBoardText1 =
    "The only community for sharing surplus food in Sri Lanka We're here to connect people who have extra food with those in need while reducing food waste.";
const onBoardText2 =
    "Learn and share tips and techniques for preserving food, reducing waste, and making your groceries last longer.";
const onBoardText3 =
    'Thank you for choosing Food-Care. Together, we can make a difference!\nLet`s get started on our mission to share and reduce food waste.';
const reportText =
    "We take user safety and content quality seriously. If you encounter a post that violates our community guidelines or contains inappropriate content, please report it to us.";
