import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import '../../services/api services/user_api_services.dart';
import '../../services/navigations.dart';
import '../../services/validate_handeler.dart';
import '../../widgets/Gtextformfiled.dart';
import '../../widgets/buttons.dart';
import '../../widgets/flutter_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: size.height * 0.35,
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.1),
                          child: Text(
                            "WELCOME BACK !!!",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        )),
                    Image.asset(
                      login,
                      height: size.height * 0.2,
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: size.height * 0.65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.05),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        )),
                  ),
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        IosTextField(
                            keybordtype: TextInputType.emailAddress,
                            label: "Email",
                            icon: Icons.email,
                            onchange: (text) {
                              email = text;
                            },
                            valid: (text) {
                              return Validater.validEmail(text!);
                            },
                            save: (text) {
                              email = text!;
                            },
                            controller: emailController),
                        IosPasswordTextFiled(
                            icon: Icons.lock_outlined,
                            onchange: (text) {
                              password = text;
                            },
                            save: (text) {
                              password = text!;
                            },
                            valid: (text) {
                              return Validater.signupPassword(text!);
                            },
                            label: "Password"),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(right: 40),
                    child: TextButton(
                      child: Text(
                        'Forget your Password?',
                        style: TextStyle(
                            fontFamily: 'InriaSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColorDark),
                      ),
                      onPressed: () {
                        openForget(context);
                      },
                    ),
                  ),
                  Genaralbutton(
                    pleft: 120,
                    pright: 120,
                    onpress: () async {
                      if (_form.currentState!.validate()) {
                        final int res = await UserAPiServices.loginUser(
                            email, password, context);
                        if (res == resOk) {
                          final user = await UserAPiServices.getCurrentUser();
                          openHome(context, user, 0);
                          ToastWidget.toast(msg: "Login successfully");
                        } else if (res == resEmail) {
                          ToastWidget.toast(msg: "Please verify your email.");
                        } else {
                          ToastWidget.toast(msg: "Email or Password is wrong.");
                        }
                      }
                    },
                    text: "Sign In",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account ?",
                          style: TextStyle(
                            color: Colors.black,
                          )),
                      TextButton(
                        child: const Text('Sign up',
                            style: TextStyle(
                                color: kPrimaryColorDark,
                                fontWeight: FontWeight.w700)),
                        onPressed: () {
                          openUserSignUp(context);
                        },
                      ),
                      SizedBox(height: size.height * 0.1),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
