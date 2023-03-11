import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';

class MsgField extends StatefulWidget {
  final bool sendByMe;
  final String msg;
  const MsgField({Key? key, required this.sendByMe, required this.msg}) : super(key: key);

  @override
  State<MsgField> createState() => _MsgFieldState();
}

class _MsgFieldState extends State<MsgField> {
  @override
  Widget build(BuildContext context) {
    if (widget.sendByMe == true) {
      return Padding(
        padding: const EdgeInsets.only(left: 150),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          color: kPrimaryColordark,
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 25),
          child: ListTile(
            title: Text(
              widget.msg,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(right: 150),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          color: kPrimaryColordark,
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 25),

          child: ListTile(
            title: Text(
              "hi",
              style: TextStyle(
                color: Colors.white
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      );
    }
  }
}
