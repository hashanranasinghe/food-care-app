import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Divider(
        thickness: 2,
        color: Color(0xFFE3E3E3FF),
      ),
    );
  }
}
