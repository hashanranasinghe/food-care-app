import 'package:flutter/cupertino.dart';
import 'package:food_care/view%20models/chat%20view/message/message_view_model.dart';
import '../../../services/api services/chat_api_services.dart';

enum Status { loading, empty, success }

class MessageListViewModel extends ChangeNotifier {
  Status status = Status.empty;

  List<MessageViewModel> messages = <MessageViewModel>[];
  Future<void> getMessages(conversationId) async {
    status = Status.loading;

    final results =
        await ChatApiServices.getMessageList(conversationId: conversationId);
    messages = results.map((chat) => MessageViewModel(chat: chat)).toList();
    status = messages.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }
}
