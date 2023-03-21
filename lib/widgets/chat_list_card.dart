import 'package:flutter/material.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversation_view_model.dart';
import '../view models/user view/user_view.dart';

class ChatListCard extends StatelessWidget {
  final List<ConversationViewModel> conversations;
  final List<UserView> users;
  const ChatListCard(
      {Key? key, required this.conversations, required this.users})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        final memberId = conversation.members[1];
        final member = users.firstWhere((user) => user.uid == memberId);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: ListTile(
            onTap: () {
              openMessaging(context,member.name,conversation.id.toString());
            },
            leading: CircleAvatar(
              backgroundColor: kPrimaryColorlight,
              child: Image.asset(icon),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  member.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("18.31"),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("hi............"),
                CircleAvatar(
                  radius: 12,
                  backgroundColor: kPrimaryColordark,
                  child: Text(
                    "6",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
