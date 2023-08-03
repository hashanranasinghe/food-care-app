import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String text;
  const CategoryCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.03,
            vertical: screenSize.height * 0.007),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: selectColor(text)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.01,
              vertical: screenSize.height * 0.002),
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ));
  }

  Color selectColor(String text) {
    if (text == "Fruits") {
      return const Color(0xFFFFA500);
    } else if (text == "Vegetables") {
      return const Color(0xFF006400);
    } else if (text == "Cooked") {
      return const Color(0xFFBDB76B);
    } else {
      return const Color(0xFF00008B);
    }
  }
}
