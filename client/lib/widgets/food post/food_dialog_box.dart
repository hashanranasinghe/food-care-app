import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/widgets/divider.dart';

import '../buttons.dart';

class FoodDialogBox extends StatelessWidget {
  final Function onComplete;
  final Function onContinue;
  const FoodDialogBox(
      {super.key, required this.onComplete, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Do you want to stop sharing?',
              textAlign: TextAlign.center,
            ),
            DividerWidget()
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Genaralbutton(
                textcolor: kPrimaryColorDark,
                fontsize: 16,
                pleft: screenSize.width * 0.05,
                pright: screenSize.width * 0.05,
                onpress: () {
                  onComplete();
                },
                text: "Stop Sharing",
                color: Color(0xFFE4F1FF),
              ),
              SizedBox(
                width: screenSize.width * 0.05,
              ),
              Genaralbutton(
                fontsize: 16,
                pleft: screenSize.width * 0.05,
                pright: screenSize.width * 0.05,
                onpress: () {
                  onContinue();
                },
                text: "Continue",
                color: kPrimaryColorDark,
              )
            ],
          )
        ]);
  }
}
