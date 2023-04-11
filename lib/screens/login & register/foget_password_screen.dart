
import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/firebase_dynamiclink.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';

import 'package:food_care/widgets/Gtextformfiled.dart';
import 'package:food_care/widgets/buttons.dart';
import 'package:food_care/widgets/flutter_toast.dart';

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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              key: _form,
              child: Gtextformfiled(
                  label: "Enter the email",
                  onchange: (value) {},
                  valid: (value) {},
                  save: (value) {},
                  controller: emailController)),
          Genaralbutton(
              text: "Send",
              onpress: () async {
                String token = await UserAPiServices.forgetPassword(
                    email: emailController.text);

                ToastWidget.toast(msg: "Email is sent.");
                emailController.clear();
              }),
        ],
      ),
    );
  }
}
