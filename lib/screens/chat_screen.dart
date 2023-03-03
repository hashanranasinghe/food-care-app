import 'package:flutter/material.dart';
import 'package:food_care/widgets/app_bar.dart';
import 'package:food_care/widgets/chat_list_card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
        text: "Chats",
        icon: Icons.search_rounded,
        widget: SingleChildScrollView(
          child: Column(
            children: [
              ChatListCard(),
            ],
          ),
        ));
  }
}
