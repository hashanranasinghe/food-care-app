import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constraints.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function function;
  const SettingTile(
      {Key? key,
      required this.title,
      required this.icon,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kSecondColorDark,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        onTap: (){
          function();
        },
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
        ),
        trailing: Icon(CupertinoIcons.right_chevron),
      ),
    );
  }
}
