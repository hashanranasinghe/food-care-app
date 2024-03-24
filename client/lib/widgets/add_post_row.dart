import 'package:flutter/material.dart';

class AddPostRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Function onpress;
  const AddPostRow(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.onpress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: GestureDetector(
        onTap: () {
          onpress();
        },
        child: Row(
          children: [
            Icon(icon),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(subtitle)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
