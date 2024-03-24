import 'package:flutter/material.dart';
import 'package:food_care/models/foodPostModel.dart';
import 'package:food_care/utils/covertor.dart';

import 'package:food_care/view%20models/food%20post%20view/food_post_view_model.dart';
import 'package:food_care/widgets/buttons.dart';
import 'package:food_care/widgets/get_user_image.dart';

import '../models/userModel.dart';
import '../utils/config.dart';
import '../utils/constraints.dart';

class RequestingCard extends StatelessWidget {
  final User user;
  final FoodPostViewModel food;
  final Function accept;
  final Function reject;
  const RequestingCard(
      {super.key,
      required this.user,
      required this.food,
      required this.accept,
      required this.reject});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.05,
          vertical: screenSize.height * 0.01),
      decoration: BoxDecoration(
          border: Border.all(color: kSecondaryTextColorDark),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.05,
          vertical: screenSize.height * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GetUserImage(id: user.uid.toString()),
                  SizedBox(
                    width: screenSize.width * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(user.phone),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Text(
            Convertor.upperCase(text: food.title),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Genaralbutton(
                  text: "Reject",
                  pleft: screenSize.width * 0.1,
                  pright: screenSize.width * 0.1,
                  onpress: () {
                    reject();
                  }),
              Genaralbutton(
                  text: "Accept",
                  pleft: screenSize.width * 0.1,
                  pright: screenSize.width * 0.1,
                  onpress: () {
                    accept();
                  }),
            ],
          )
        ],
      ),
    );
  }
}
