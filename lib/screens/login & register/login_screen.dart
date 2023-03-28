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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.05),
                child: Text(
                  "Sign In",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              )),
          Form(
            key: _form,
            child: Column(
              children: [
                Gnoiconformfiled(
                    label: "Email",
                    icon: Icons.email_outlined,
                    textinput: TextInputType.emailAddress,
                    maxlines: 1,
                    onchange: (text) {
                      email = text;
                    },
                    valid: (text) {
                      return Validater.vaildemail(text!);
                    },
                    save: (text) {
                      email = text!;
                    },
                    controller: emailController),
                Gpasswordformfiled(
                  valid: (text) {
                    return Validater.signupPassword(text!);
                  },
                  icon: Icons.lock_outline,
                  onchange: (text) {
                    password = text;
                  },
                  save: (text) {
                    password = text!;
                  },
                ),
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
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColordark),
              ),
              onPressed: () {},
            ),
          ),
          Genaralbutton(
            pleft: 120,
            pright: 120,
            onpress: () async {
              if (_form.currentState!.validate()) {
                final int res = await UserAPiServices.loginUser(email, password,context);
                if(res==resOk){
                  final user = await UserAPiServices.getCurrentUser();
                  openHome(context, user);
                  ToastWidget.toast(msg: "Login successfully");
                }else{
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
                      color: Colors.black, fontWeight: FontWeight.bold)),
              TextButton(
                child: const Text('Sign up',
                    style: TextStyle(
                        color: kPrimaryColordark, fontWeight: FontWeight.bold)),
                onPressed: () {
                  openUserSignUp(context);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
