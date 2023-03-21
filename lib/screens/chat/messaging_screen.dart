import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/chat%20view/message/message_list_view_model.dart';
import 'package:food_care/view%20models/chat%20view/message/send_message_view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/widgets/message_box.dart';
import 'package:provider/provider.dart';

class MessagingScreen extends StatefulWidget {
  final String receiverName;
  final String conversationId;
  const MessagingScreen(
      {Key? key, required this.receiverName, required this.conversationId})
      : super(key: key);

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final TextEditingController _msgController = TextEditingController();
  final _form = GlobalKey<FormState>();
  late SendMessageViewModel _sendMessageViewModel;
  late MessageListViewModel _messageListViewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MessageListViewModel>(context, listen: false)
        .getMessages(widget.conversationId);
    _sendMessageViewModel =
        Provider.of<SendMessageViewModel>(context, listen: false);
    _messageListViewModel =
        Provider.of<MessageListViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MessageListViewModel>(context);
    print(vm.messages);
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if (userViewModel.user == null) {
        userViewModel.getCurrentUser();
        return const Center(child: CircularProgressIndicator());
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.receiverName,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            backgroundColor: kPrimaryColordark,
          ),
          body: Column(
            children: [
              Expanded(child: _updateUi(vm)),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Form(
                        key: _form,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return;
                            }
                          },
                          controller: _msgController,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      _send(userViewModel.user!.id.toString());
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }
    });
  }

  Widget _updateUi(MessageListViewModel vm) {
    switch (vm.status) {
      case Status.loading:
        return Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      case Status.success:
        return MsgField(messages: vm.messages);
      case Status.empty:
        return Align(
          alignment: Alignment.center,
          child: Text("No foru found...."),
        );
    }
  }

  _send(String id) async {
    if (_form.currentState!.validate()) {
      setState(() {
        _sendMessageViewModel.message = _msgController.text;
        _sendMessageViewModel.senderId = id;
        _sendMessageViewModel.conversationId = widget.conversationId;
      });
      await _sendMessageViewModel.sendMessage();
      _msgController.clear();
      await _messageListViewModel.getMessages(widget.conversationId);
    }
  }
}
