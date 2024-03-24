import 'package:flutter/material.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(bottom: size.height * 0.08),
        child: PageView(
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            controller: controller,
            children: [
              onBoard(on1, onBoardText1, size),
              onBoard(on2, onBoardText2, size),
              onBoard(on3, onBoardText3, size),
            ]),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);
                openUserSignIn(context);
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  backgroundColor: kPrimaryColorDark,
                  minimumSize: Size.fromHeight(size.height * 0.1)),
              child: Text(
                "Get Started",
                style: TextStyle(fontSize: 20),
              ))
          : SizedBox(
              height: size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => controller.jumpToPage(2),
                      child: Text(
                        'SKIP',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black26,
                          activeDotColor: kPrimaryColorDark),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(microseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                      onPressed: () => controller.nextPage(
                          duration: const Duration(microseconds: 500),
                          curve: Curves.easeInOut),
                      child: Text(
                        'NEXT',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ))
                ],
              ),
            ),
    );
  }

  Widget onBoard(String imgUrl, String text, Size size) => Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imgUrl,
              height: size.height * 0.3,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            )
          ],
        ),
      );
}
