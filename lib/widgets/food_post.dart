import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';

class FoodPost extends StatelessWidget {
  const FoodPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Stack(children: [
        Card(
          color: kSecondColorDark,
          elevation: 4,
          margin: EdgeInsets.only(top: 48, left: 15, right: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Text(
                          'Fried Chicken',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            height: 1.5,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 3,
                  height: 190,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Distance',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 1.5,
                          color: Color(0xFF444C50),
                        ),
                      ),
                      Text(
                        '5 Km',
                        style: TextStyle(
                          fontSize: 24,
                          height: 1.5,
                          color: Color(0xFF444C50),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Rice, pasta, salad, water included',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 1.5,
                          color: Color(0xFF444C50),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                child: CircleAvatar(
                  radius: 70.0,
                  backgroundColor: kPrimaryColordark,
                  child: CircleAvatar(
                    radius: 68.0,
                    backgroundColor: kPrimaryColorlight,
                    backgroundImage: AssetImage('assets/images/icon.png'),
                  ),
                ),
              )),
        ),
      ]),
    );
  }
}
