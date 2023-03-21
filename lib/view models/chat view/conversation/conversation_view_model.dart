import 'package:food_care/models/conversationModel.dart';

class ConversationViewModel {
  final Conversation conversation;

  ConversationViewModel({required this.conversation});

  String? get id {
    return conversation.id;
  }

  List<dynamic> get members {
    return conversation.members;
  }

  DateTime get createdAt {
    return conversation.createdAt;
  }

  DateTime get updatedAt {
    return conversation.updatedAt;
  }
}
