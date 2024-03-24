import 'package:flutter/cupertino.dart';
import 'package:food_care/view%20models/chat%20view/message/message_view_model.dart';
import '../../../services/api services/chat_api_services.dart';

enum MsgStatus { msgLoading, msgEmpty, msgSuccess }

class MessageListViewModel extends ChangeNotifier {
  MsgStatus status = MsgStatus.msgEmpty;

  List<MessageViewModel> messages = <MessageViewModel>[];
  Stream<List<MessageViewModel>> get stream async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield messages;
    }
  }

  Future<void> getMessages(conversationId) async {
    status = MsgStatus.msgLoading;

    final results =
    await ChatApiServices.getMessageList(conversationId: conversationId);
    messages = results.map((chat) => MessageViewModel(chat: chat)).toList();
    status = messages.isEmpty ? MsgStatus.msgEmpty : MsgStatus.msgSuccess;

    notifyListeners();
  }
}
