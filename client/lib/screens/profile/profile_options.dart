import 'package:flutter/material.dart';
import 'package:food_care/models/userModel.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/utils/covertor.dart';

class ProfileOptionsScreen extends StatelessWidget {
  final User user;

  const ProfileOptionsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);
    final theme = Theme.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kPrimaryColorDark,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                CircleAvatar(
                  backgroundImage: Convertor.getImage(user.imageUrl.toString()),
                  radius: size.width * 0.15,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  user.name,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            Container(
              width: size.width,
              height: size.height * 0.6,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    profileCard(Icons.face_3_outlined, "Update Profile", () {
                      openMyProfile(context, user);
                    }, size),
                    profileCard(Icons.question_answer, "FAQs", () {
                      openFaq(context);
                    }, size),
                    profileCard(Icons.question_answer, "Terms & Conditions",
                        () {
                      openTerms(context);
                    }, size),
                    profileCard(Icons.question_answer, "Privacy Policy", () {
                      openPrivacy(context);
                    }, size),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget profileCard(
          IconData icon, String title, Function onPress, Size size) =>
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.01, horizontal: size.width * 0.06),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                onPress();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.13,
                        height: size.width * 0.13,
                        child: Icon(
                          icon,
                          color: title != "Logout"
                              ? kPrimaryColorDark
                              : Colors.red,
                        ),
                        decoration: BoxDecoration(
                            color: kDefaultIconLightColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(60))),
                      ),
                      SizedBox(
                        width: size.width * 0.1,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: title != "Logout" ? Colors.black : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Divider(
              thickness: 2,
            )
          ],
        ),
      );
}
