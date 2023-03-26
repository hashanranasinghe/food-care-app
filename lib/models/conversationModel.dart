class Conversation {
  String? id;
  List<dynamic> members;
  DateTime createdAt;
  DateTime updatedAt;

  Conversation(
      {this.id,
      required this.members,
      required this.createdAt,
      required this.updatedAt});

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json['_id'],
        members: List<dynamic>.from(json['members'].map((x) => x)),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'members': members,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
