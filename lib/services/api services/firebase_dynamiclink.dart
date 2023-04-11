import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_care/services/navigations.dart';

class FirebaseDynamicLinkService {
  static Future<void> initDynamicLink(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri deepLink = dynamicLinkData.link;
      String token = deepLink.queryParameters['token'].toString();
      openReset(context, token);
    });
  }
}
