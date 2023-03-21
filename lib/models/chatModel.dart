class Chat {
  String conversationId;
  String senderId;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  Chat({
    required this.conversationId,
    required this.senderId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      conversationId: json['conversationId'] as String,
      senderId: json['sender_id'] as String,
      message: json['message'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'sender_id': senderId,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
