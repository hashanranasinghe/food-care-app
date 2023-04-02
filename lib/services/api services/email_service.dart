import 'dart:convert';
import 'package:food_care/utils/config.dart';
import 'package:http/http.dart' as http;

class EmailService {
  static void sendEmail(
      {required String email, required String verificationToken}) async {
    final String baseLink = Config.emailUrl+Config.verifyUser(verificationToken: verificationToken);
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
      'subject': 'Food Care Account Verification',
      'htmlContent':
          '<html><head></head><body><p>Hello,</p><a href=$baseLink>Verify your Account</a><br></body></html>'
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
