import 'package:flutter/material.dart';

import 'package:food_care/models/userModel.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/utils/covertor.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_view_model.dart';

import 'package:food_care/widgets/buttons.dart';
import 'package:food_care/widgets/get_user_image.dart';

import '../../models/foodPostModel.dart';

class FoodCard extends StatelessWidget {
  final User user;
  final String comp;
  final FoodPostViewModel food;
  final Function complete;
  const FoodCard(
      {super.key,
      required this.user,
      required this.food,
      required this.complete, required this.comp});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: user.foodRequest!.length,
      itemBuilder: ((context, index) {
        final foodRequest = user.foodRequest![index];
        return foodRequest.permission=="ACCEPT" && foodRequest.complete ==comp? Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.02,
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
                  Container(
                    decoration: BoxDecoration(
                        color: Convertor.selectColor(foodRequest.permission),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.02,
                        vertical: screenSize.height * 0.01),
                    child: Text(
                      foodRequest.permission,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Text(
                Convertor.upperCase(text: food.title),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (foodRequest.complete == "COMPLETE") ...[
                    Container(
                      decoration: BoxDecoration(
                          color: Convertor.selectColor(foodRequest.complete),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.02,
                          vertical: screenSize.height * 0.01),
                      child: Text(
                        foodRequest.complete,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ] else ...[
                    Genaralbutton(
                        text: "Complete",
                        pleft: screenSize.width * 0.1,
                        pright: screenSize.width * 0.1,
                        onpress: () {
                          complete();
                        }),
                  ]
                ],
              )
            ],
          ),
        ):Container();
      }),
    );
  }
}
