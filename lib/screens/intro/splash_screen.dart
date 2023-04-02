// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'dart:async';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:food_care/services/navigations.dart';
import '../../services/api services/user_api_services.dart';
import '../../services/store_token.dart';

class SplashScreen extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;
  const SplashScreen({Key? key, this.initialLink}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);

    return new Timer(duration, route);
  }

  route() async {
    var token = await StoreToken.getToken();
    if (token != null) {
      final user = await UserAPiServices.getCurrentUser();
      openHome(context, user);
    } else if (widget.initialLink != null) {
      openReset(context,
          widget.initialLink!.link.queryParameters['token'].toString());
    } else {
      openUserSignIn(context);
    }
  }

  initScreen(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: size.width * 0.1,
                  left: size.width * 0.1,
                  right: size.width * 0.1),
              child: Image.asset("assets/images/icon.png")),
          CircularProgressIndicator(color: Colors.black12),
          SizedBox(
            height: size.height * 0.22,
          ),
          Text(
            "Copyright 2022 © Food Care",
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ],
      ),
    ));
  }
}
