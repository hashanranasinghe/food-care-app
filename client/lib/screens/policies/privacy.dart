import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final date = DateTime.now();

  PrivacyPolicyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy', style: TextStyle(color: Colors.black)),
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
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Welcome to Food-Care! Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our mobile app.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Information We Collect',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'We collect the following information when you use our app:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
                '   - Name: We collect your name to personalize your experience and facilitate food sharing.'),
            Text(
                '   - Email Address: Your email address is used for communication and account verification.'),
            Text(
                '   - Location: We collect your location when you create a food post to connect users with surplus food to those in need.'),
            Text(
                '   - Usage Data: We collect data on how you interact with our app to improve its functionality.'),
            SizedBox(height: 16.0),
            Text(
              '2. How We Use Your Information',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
                'We use the collected information only for the functionality of our application, including:'),
            SizedBox(height: 8.0),
            Text(
                '   - Facilitating food sharing by connecting users with surplus food to those in need.'),
            Text('   - Personalizing your experience within the app.'),
            Text('   - Communication and account verification.'),
            Text(
                '   - Improving our app\'s functionality and user experience.'),
            SizedBox(height: 16.0),
            Text(
              '3. Data Security',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
                'We take your data security seriously. We use encryption methods to secure your information and protect it from unauthorized access.'),
            SizedBox(height: 16.0),
            Text(
              '4. User Information Control',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
                'You can edit your information at any time within the app. However, you must provide valid information for the proper functioning of the app.'),
            SizedBox(height: 16.0),
            Text(
              '5. Sharing of Information',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
                'We do not share user information with third parties. Your data is used solely for the functionality of our app.'),
            SizedBox(height: 16.0),
            Text(
              '6. Reporting and Complaints',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
                'Users can report or complain about food posts. Our app administrators will take suitable actions based on these reports to maintain the quality of our community.'),
            SizedBox(height: 16.0),
            Text(
              '7. Changes to Privacy Policy',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
                'We will notify users of any changes to this Privacy Policy within the app, and the updated policy will take effect immediately upon posting.'),
            SizedBox(height: 16.0),
            Text(
              'If you have any questions or concerns regarding your privacy or this Privacy Policy, please contact us at ',
              style: TextStyle(fontSize: 16.0),
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
