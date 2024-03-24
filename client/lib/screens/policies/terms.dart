import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  final date = DateTime.now();

  TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Effective Date: ${DateFormat('yyyy MMMM d').format(date)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              '1. User Agreement',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              'By using Food-Care, you agree to abide by these Terms and Conditions. If you do not agree, please do not use our app.',
            ),
            SizedBox(height: 20.0),
            Text(
              '2. User Registration',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              'If you use our app, you may need to create an account. You are responsible for maintaining the security of your account credentials.',
            ),
            SizedBox(height: 20.0),
            Text(
              '3. Content Rules',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              'Only posts related to food sharing and food-related topics are allowed on Food-Care. Posts violating this rule may be removed.',
            ),
            SizedBox(height: 20.0),
            Text(
              '4. Usage Restrictions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              'Users must use Food-Care responsibly. Harmful activities, spam, and fraudulent behavior are prohibited.',
            ),
            SizedBox(height: 20.0),
            Text(
              '5. Payment and Refunds',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              'Our app does not involve payments, and therefore, this section does not apply.',
            ),
            SizedBox(height: 20.0),
            Text(
              '6. Intellectual Property',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              'The content and intellectual property of Food-Care belong to us. Users may not use or reproduce our content without permission.',
            ),
            SizedBox(height: 20.0),
            Text(
              '7. Liability and Dispute Resolution',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              'We are not responsible for the actions of users on our platform. Any disputes will be resolved through suitable means, such as reporting and moderation.',
            ),
            SizedBox(height: 20.0),
            Text(
              '8. Termination',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              'We may terminate a user\'s account or access to the app for violations of these Terms and Conditions.',
            ),
            SizedBox(height: 20.0),
            Text(
              '9. Changes to Terms and Conditions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              'We will notify users of any changes to these Terms and Conditions within the app, and the updated terms will take effect immediately upon posting.',
            ),
            SizedBox(height: 20.0),
            Text(
              'If you have any questions or concerns regarding these Terms and Conditions, please contact us at ',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            GestureDetector(
              onTap: () async {
                String email = Uri.encodeComponent("foodcare@gmail.com");

                Uri mail = Uri.parse("mailto:$email");
                if (await launchUrl(mail)) {
                  //email app opened
                } else {
                  //email app is not opened
                }
              },
              child: Text(
                'foodcare@gmail.com',
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: kPrimaryColorDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
