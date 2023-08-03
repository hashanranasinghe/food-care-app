import 'package:flutter/material.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/widgets/buttons.dart';

class RoleSelectingScreen extends StatelessWidget {
  const RoleSelectingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Genaralbutton(
              onpress: () {
                openUserSignUp(context,"DONOR");
              },
              text: "Donor",
            ),
            SizedBox(
              height: 20,
            ),
            Genaralbutton(
              onpress: () {
                openUserSignUp(context,"RECEIPIAN");
              },
              text: "receiver",
            )
          ],
        ),
      ),
    );
  }
}
