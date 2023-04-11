import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/chat_api_services.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversation_view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import '../models/chatModel.dart';
import '../utils/config.dart';
import '../view models/user view/user_view.dart';

class ChatListCard extends StatefulWidget {
  final List<ConversationViewModel> conversations;
  final List<UserView> users;
  final UserViewModel userViewModel;
  const ChatListCard(
      {Key? key,
      required this.conversations,
      required this.users,
      required this.userViewModel})
      : super(key: key);

  @override
  State<ChatListCard> createState() => _ChatListCardState();
}

class _ChatListCardState extends State<ChatListCard> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.conversations.length,
      itemBuilder: (context, index) {
        final conversation = widget.conversations[index];
        final memberId =
            (widget.userViewModel.user!.id != conversation.members[1])
                ? conversation.members[1]
                : conversation.members[0];
        final member = widget.users.firstWhere((user) => user.uid == memberId);
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: FutureBuilder<List<dynamic>>(
                future: ChatApiServices.getMessageList(
                    conversationId: conversation.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List messageList = snapshot.data!;
                    if (messageList.length > 0) {
                      final Chat lastMessage = messageList.last;
                      return ListTile(
                        onTap: () async {
                          openMessaging(
                              context: context,
                              receiverName: member.name,
                              conversationId: conversation.id.toString(),
                              conversationViewModel: conversation,
                              id: memberId);
                        },
                        leading: CircleAvatar(
                          backgroundColor: kPrimaryColorlight,
                          backgroundImage: member.imageUrl == ""
                              ? AssetImage(icon.toString())
                              : NetworkImage(Config.imageUrl(
                                      imageUrl: member.imageUrl.toString()))
                                  as ImageProvider<Object>,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              member.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${Convert.convertTimeFormat(dateTime: lastMessage.createdAt)}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${lastMessage.message}"),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: kPrimaryColordark,
                              child: Text(
                                "6",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                }));
      },
    );
  }
}
