import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/firebase_dynamiclink.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';
import 'package:food_care/utils/constraints.dart';

import 'package:food_care/widgets/Gtextformfiled.dart';
import 'package:food_care/widgets/buttons.dart';
import 'package:food_care/widgets/flutter_toast.dart';
import 'package:lottie/lottie.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  void initState() {
    // TODO: implement initState
    FirebaseDynamicLinkService.initDynamicLink(context);
    super.initState();
  }

  TextEditingController emailController = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Forgot Password"),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Lottie.asset(forgotAnim, repeat: true, width: size.width * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Text(
                "Please enter your email address to receive a verification email.",
                textAlign: TextAlign.center,
                style: TextStyle(color: kSecondaryTextColorDark),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Form(
                key: _form,
                child: Gtextformfiled(
                    label: "Enter the email",
                    onchange: (value) {},
                    valid: (value) {},
                    save: (value) {},
                    controller: emailController)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Genaralbutton(
                  text: "Send",
                  onpress: () async {
                    await UserAPiServices.forgetPassword(
                        email: emailController.text);

                    ToastWidget.toast(msg: "Email is sent.");
                    emailController.clear();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
