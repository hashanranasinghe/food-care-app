class Comment {
  String? id;
  String text;
  String? commenterId;
  String commenter;
  DateTime date;

  Comment({
    this.id,
    required this.text,
    this.commenterId,
    required this.commenter,
    required this.date,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'],
        text: json["text"],
        commenterId: json['commentId'],
        commenter: json["commenter"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'commenterId': commenterId,
        "text": text,
        "commenter": commenter,
        "date": date.toIso8601String(),
      };
}
