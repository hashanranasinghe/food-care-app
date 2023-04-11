// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'dart:async';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_care/services/navigations.dart';
import '../../services/api services/chat_api_services.dart';
import '../../services/api services/user_api_services.dart';
import '../../services/store_token.dart';
import '../../view models/chat view/conversation/conversation_view_model.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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

  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    } else {
      startTimer();
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  _handleMessage(RemoteMessage message) {
    var duration = Duration(seconds: 3);

    new Timer(duration, () {
      routeNew(message);
    });
  }

  routeNew(RemoteMessage message) async {
    var token = await StoreToken.getToken();
    if (token != null) {
      if (message.data["type"] == "chat") {
        final ConversationViewModel vm = await ChatApiServices.getConversation(
            senderId: message.data["userId"],
            receiverId: message.data["receiverId"]);
        openMessaging(
            context: context,
            receiverName: message.data["receiverName"],
            conversationId: message.data["conversationId"],
            conversationViewModel: vm,
            id: message.data["userId"]);
      } else {
        openSettings(context);
      }
    } else {
      openUserSignIn(context);
    }
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
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
