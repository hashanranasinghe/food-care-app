import 'package:flutter/material.dart';
import 'package:food_care/screens/home_screen.dart';
import 'package:food_care/screens/login_screen.dart';
import 'package:food_care/screens/signup_screen.dart';
import 'package:food_care/widgets/bottom_navigationbar.dart';

void openUserSignUp(BuildContext context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const SignupScreen()));
}
void openUserSignIn(BuildContext context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const LoginScreen()));
}

void openHome(BuildContext context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const BottomNavigation()));
}