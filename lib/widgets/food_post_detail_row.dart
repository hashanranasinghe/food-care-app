import 'package:flutter/material.dart';

class FoodPostDetailRow extends StatelessWidget {
  final String text;
  final IconData? btnIcon;
  final IconData topicIcon;
  final String topic;
  final Color color;

  const FoodPostDetailRow(
      {Key? key,
      required this.text,
      this.btnIcon,
      required this.topicIcon,
      required this.topic,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                topicIcon,
                size: 15,
              ),
              SizedBox(
                width: screenSize.width * 0.01,
              ),
              Text(
                "$topic:",
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
          InkWell(
            onTap: () {},
            child: Container(
                margin: EdgeInsets.only(right: screenSize.width * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.01,
                    vertical: screenSize.height * 0.005),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black87),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
