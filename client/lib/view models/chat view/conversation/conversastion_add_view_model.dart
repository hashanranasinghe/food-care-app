import 'package:flutter/cupertino.dart';
import 'package:food_care/models/conversationModel.dart';
import 'package:food_care/services/api%20services/chat_api_services.dart';

class ConversationAddViewModel extends ChangeNotifier {


  late List<dynamic> members = [];
  late DateTime createdAt;
  late DateTime updatedAt;

  Future<void> createConversation() async {
    final conversation = Conversation(
        members: members, createdAt: createdAt, updatedAt: updatedAt);
    await ChatApiServices.createConversation(conversation: conversation);
    notifyListeners();
    print(conversation.members);
  }
}
