import 'package:flutter/cupertino.dart';
import 'package:food_care/services/api%20services/chat_api_services.dart';
import 'conversation_view_model.dart';

enum Status { loading, empty, success }

class ChatListViewModel extends ChangeNotifier {
  Status status = Status.empty;
  List<ConversationViewModel> conversations = <ConversationViewModel>[];

  Future<void> getAllConversations(userId) async {
    status = Status.loading;

    final results =
        await ChatApiServices.getConversationsListOfUser(userId: userId);
    conversations = results
        .map(
            (conversation) => ConversationViewModel(conversation: conversation))
        .toList();

    status = conversations.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }

}
