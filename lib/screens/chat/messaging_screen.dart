import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversation_view_model.dart';
import 'package:food_care/view%20models/chat%20view/message/message_list_view_model.dart';
import 'package:food_care/view%20models/chat%20view/message/send_message_view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/widgets/message_box.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../models/chatModel.dart';
import '../../utils/config.dart';
import '../../view models/chat view/message/message_view_model.dart';

class MessagingScreen extends StatefulWidget {
  final String receiverName;
  final String conversationId;
  final String id;
  final ConversationViewModel conversationViewModel;
  const MessagingScreen(
      {Key? key,
      required this.receiverName,
      required this.conversationId,
      required this.conversationViewModel,
      required this.id})
      : super(key: key);

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final TextEditingController _msgController = TextEditingController();
  final _form = GlobalKey<FormState>();
  late SendMessageViewModel _sendMessageViewModel;
  late MessageListViewModel _messageListViewModel;
  late IO.Socket socket;
  late List<dynamic> usersOfSocket = [];

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
    _socketConnect();
  }

  _socketConnect() {
    socket = IO.io(Config.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.emit(
        "addUser",
        (widget.id == widget.conversationViewModel.members[0])
            ? widget.conversationViewModel.members[1]
            : widget.conversationViewModel.members[0]);
    socket.on('getUsers', (data) {
      if (mounted) {
        setState(() {
          usersOfSocket = data;
        });
        print(usersOfSocket);
      }
    }); // Add the listener again
    socket.connect();
    socket.on('connect', (_) => print('connected to server'));
    socket.on('disconnect', (_) => print('disconnected from server'));

    socket.on("getMessage", (data) async {
      final Chat chat = Chat.fromJson(data);
      final newMessage = MessageViewModel(chat: chat);
      if (mounted) {
        _messageListViewModel.messages.add(newMessage);
        _messageListViewModel.notifyListeners();
      }

    });
  }

  void sendToSocket() {
    socket.emit('sendMessage', {
      'sender_id': (widget.id == widget.conversationViewModel.members[0])
          ? widget.conversationViewModel.members[1]
          : widget.conversationViewModel.members[0],
      'conversationId': widget.conversationId,
      'receiverId': widget.id,
      'message': _msgController.text,
      'updatedAt': DateTime.now().toString(),
      'createdAt': DateTime.now().toString()
    });
    // Add the new message to the messages list
    final newMessage = MessageViewModel(
      chat: Chat(
        senderId: (widget.id == widget.conversationViewModel.members[0])
            ? widget.conversationViewModel.members[1]
            : widget.conversationViewModel.members[0],
        conversationId: widget.conversationId,
        message: _msgController.text,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
    );
    _messageListViewModel.messages.add(newMessage);
    _messageListViewModel.notifyListeners();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MessageListViewModel>(context);
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
                          textCapitalization: TextCapitalization.sentences,
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
                    onPressed: () async {
                      if (usersOfSocket.length == 2) {
                        sendToSocket();
                        _send(userViewModel.user!.id.toString());
                      } else {
                        _send(userViewModel.user!.id.toString());
                      }
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
      case MsgStatus.msgLoading:
        return Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      case MsgStatus.msgSuccess:
        return MsgField(
          messages: vm.messages,
        );
      case MsgStatus.msgEmpty:
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
      String receiverId = (id==widget.conversationViewModel.members[0]?widget.conversationViewModel.members[1]:widget.conversationViewModel.members[0]);
      await _sendMessageViewModel.sendMessage(receiverId: receiverId);
      if (usersOfSocket.length == 1) {
        await _messageListViewModel.getMessages(widget.conversationId);
      }
      _msgController.clear();
    }
  }
}
