import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';

import '../widgets/message_box.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final List<String> _userMessages = [];
  final List<String> _receiverMessages = [];
  final TextEditingController _msgController = TextEditingController();

  final sendByMe = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hashan",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: kPrimaryColordark,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _userMessages.length,
              itemBuilder: (BuildContext context, int index) {
                return MsgField(sendByMe: true, msg: _userMessages[index]);
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _msgController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  setState(() {
                    _userMessages.add(_msgController.text);
                    _msgController.clear();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
