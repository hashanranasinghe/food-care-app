import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';

class FoodPost extends StatelessWidget {
  const FoodPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kSecondColorDark,
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: kPrimaryColordark,
                        width: 2.0,
                      ),
                    ),
                    width: 120,
                    height: 120,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/icon.png"),
                      backgroundColor: kPrimaryColorlight,
                    ),
                  ),


                  Text(
                    'Fried Chicken',
                    style: TextStyle(

                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      height: 1.5,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
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
            SizedBox(width: 5),
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
                    fontWeight: FontWeight.w700,
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
            )),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
