import 'package:flutter/cupertino.dart';
import 'package:food_care/models/chatModel.dart';
import 'package:food_care/services/api%20services/chat_api_services.dart';

class SendMessageViewModel extends ChangeNotifier {
  late String conversationId;
  late String senderId;
  late String message;
  late DateTime createdAt;
  late DateTime updatedAt;

  Future<void> sendMessage() async {
    final chat = Chat(
        conversationId: conversationId,
        senderId: senderId,
        message: message,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());

    await ChatApiServices.sendMessage(chat: chat);
    notifyListeners();
  }
}
