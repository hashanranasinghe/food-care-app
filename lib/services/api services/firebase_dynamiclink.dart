import 'dart:convert';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_care/services/navigations.dart';
import 'package:http/http.dart' as http;
import '../../utils/config.dart';

class FirebaseDynamicLinkService {
  static Future<String> createDynamicLink(String token, String email) async {
    Uri url;
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://www.foodcare.com/token?token=$token"),
      uriPrefix: "https://foodcare.page.link",
      androidParameters:
          const AndroidParameters(packageName: "com.example.food_care"),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    url = dynamicLink.shortUrl;
    sendEmail(email: email, link: url);
    return url.toString();
  }

  static Future<void> initDynamicLink(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri deepLink = dynamicLinkData.link;
      String token = deepLink.queryParameters['token'].toString();
      openReset(context, token);
    });
  }

  static void sendEmail({required String email, required Uri? link}) async {
    const String apiKey = Config.emailApi;
    const String url = 'https://api.sendinblue.com/v3/smtp/email';

    final headers = {
      'accept': 'application/json',
      'api-key': apiKey,
      'content-type': 'application/json'
    };
    final data = jsonEncode({
      'sender': {'name': 'Food Care', 'email': 'hashan.ranasinghe98@gmail.com'},
      'to': [
        {'email': email, 'name': 'hashan'}
      ],
      'subject': 'Food Care Reset Password',
      'htmlContent':
          '<html><head></head><body><p>Hello,</p><p>$link</p><br></body></html>'
    });

    final response =
        await http.post(Uri.parse(url), headers: headers, body: data);

    if (response.statusCode == 201) {
      print('Email sent successfully');
    } else {
      print('Failed to send email: ${response.body}');
    }
  }
}
