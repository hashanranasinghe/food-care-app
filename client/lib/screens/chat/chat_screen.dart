import 'package:flutter/material.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversation_list_view_model.dart';

import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/view%20models/user%20view/user_list_view_model.dart';
import 'package:food_care/widgets/app_bar.dart';
import 'package:food_care/widgets/chat_list_card.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:food_care/utils/constraints.dart';
class ChatScreen extends StatefulWidget {
  final String? id;
  const ChatScreen({Key? key, this.id}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ChatListViewModel>(context, listen: false)
        .getAllConversations(widget.id);
    Provider.of<UserListViewModel>(context, listen: false).getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ChatListViewModel>(context);
    final um = Provider.of<UserListViewModel>(context);

    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if (userViewModel.user == null) {
        userViewModel.getCurrentUser();
        return const Center(child: CircularProgressIndicator());
      } else {
        return AppBarWidget(
            text: "Chats",
            widget: _updateUi(vm, um, userViewModel));
      }
    });
  }

  Widget _updateUi(
      ChatListViewModel vm, UserListViewModel um, UserViewModel userViewModel) {
          Size size = MediaQuery.of(context).size;
    switch (vm.status) {
      case Status.loading:
        return Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      case Status.success:
        return ChatListCard(
          conversations: vm.conversations,
          users: um.users,
          userViewModel: userViewModel,
        );
      case Status.empty:
        return Align(
            alignment: Alignment.center,
            child: Lottie.asset(nodataAnim, repeat: true, width: size.width),
          );
    }
  }
}
