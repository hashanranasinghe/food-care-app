import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/chat%20view/message/message_view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:provider/provider.dart';

class MsgField extends StatefulWidget {
  final List<MessageViewModel> messages;
  const MsgField({Key? key, required this.messages}) : super(key: key);

  @override
  State<MsgField> createState() => _MsgFieldState();
}

class _MsgFieldState extends State<MsgField> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if (userViewModel.user == null) {
        userViewModel.getCurrentUser();
        return const Center(child: CircularProgressIndicator());
      } else {
        return ListView.builder(
          itemCount: widget.messages.length,
          itemBuilder: (context, index) {
            final message = widget.messages[index];
            if (message.senderId == userViewModel.user!.id) {
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
                      message.message,
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
                      message.message,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              );
            }
          },
        );
      }
    });
  }
}
