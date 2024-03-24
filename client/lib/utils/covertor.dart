import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_care/utils/config.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../models/foodPostModel.dart';

class Convertor {
  static String upperCase({required String text}) {
    String capitalizedText =
        text.substring(0, 1).toUpperCase() + text.substring(1);
    return capitalizedText;
  }

  static String getDate({required DateTime date}) {
    date = DateTime(date.year, date.month, date.day);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    if (date.isAtSameMomentAs(today)) {
      return "Today ";
    } else if (date.isAtSameMomentAs(today.add(Duration(days: 1)))) {
      return "Tomorrow ";
    } else if (date.isAtSameMomentAs(today.subtract(Duration(days: 1)))) {
      return "Yesterday ";
    } else {
      String day = "${DateFormat('yyyy MMMM d').format(date)} ";
      return day;
    }
  }

  static double getDifferenceLocation(
      Position currentPosition, Location foodLocation) {
    double distanceInMeters = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      double.parse(foodLocation.lan),
      double.parse(foodLocation.lon),
    );

    double distanceInKilometers = distanceInMeters / 1000;
    double roundedDistance =
        double.parse(distanceInKilometers.toStringAsFixed(1));
    return roundedDistance;
  }

  static Color selectColor(String text) {
    if (text == "Fruits") {
      return const Color(0xFFFFA500);
    } else if (text == "Vegetables") {
      return const Color(0xFF006400);
    } else if (text == "Cooked") {
      return const Color(0xFFBDB76B);
    } else if (text == "Short-Eats") {
      return const Color(0xFF00008B);
    } else if (text == "REJECT") {
      return Colors.red;
    } else if (text == "ACCEPT") {
      return Colors.green;
    } else if (text == "COMPLETE") {
      return kPrimaryColorDark;
    } else if (text == "PENDING") {
      return const Color(0xFFF29339);
    } else {
      return Colors.black;
    }
  }

  static getImage(String imageUrl) {
    if (imageUrl == "null") {
      return AssetImage(userIcon.toString());
    } else {
      return NetworkImage(Config.imageUrl(imageUrl: imageUrl));
    }
  }
}
