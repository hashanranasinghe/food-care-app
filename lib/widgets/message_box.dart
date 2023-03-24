import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/chat%20view/message/message_view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:provider/provider.dart';

import '../view models/chat view/message/message_list_view_model.dart';

class MsgField extends StatefulWidget {
  final List<MessageViewModel> messages;
  const MsgField({Key? key, required this.messages}) : super(key: key);

  @override
  State<MsgField> createState() => _MsgFieldState();
}

class _MsgFieldState extends State<MsgField> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if (userViewModel.user == null) {
        userViewModel.getCurrentUser();
        return const Center(child: CircularProgressIndicator());
      } else {
        return StreamBuilder<List<MessageViewModel>>(
          stream: Provider.of<MessageListViewModel>(context).stream,
          initialData: widget.messages,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final message = widget.messages[index];
                  if (message.senderId == userViewModel.user!.id) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 150),
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          color: kPrimaryColordark,
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        message.message,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      Convert.convertTimeFormat(
                                          dateTime: message.createdAt),
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.6),
                                          fontSize: 11),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(right: 150),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        color: kPrimaryColordark,
                        margin:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      message.message,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    Convert.convertTimeFormat(
                                        dateTime: message.createdAt),
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 11),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              );
            } else {
              return const Center(child: Text('No messages found'));
            }
          },
        );
      }
    });
  }
}
