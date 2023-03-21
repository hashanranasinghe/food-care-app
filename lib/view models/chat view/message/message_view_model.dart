import 'package:flutter/cupertino.dart';
import 'package:food_care/models/chatModel.dart';

class MessageViewModel extends ChangeNotifier {
  final Chat chat;

  MessageViewModel({required this.chat});

  String get conversationId {
    return chat.conversationId;
  }

  String get senderId {
    return chat.senderId;
  }

  String get message {
    return chat.message;
  }

  DateTime get createdAt {
    return chat.createdAt;
  }

  DateTime get updatedAt {
    return chat.updatedAt;
  }
}
