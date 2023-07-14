import 'package:flutter/material.dart';

import '../services/date.dart';

class ShowTimeAgoRow extends StatelessWidget {
  final DateTime time;
  const ShowTimeAgoRow({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.av_timer_outlined,
          size: 20,
        ),
        Text("${Date.getStringdatetime(time)} ago"),
      ],
    );
  }
}
