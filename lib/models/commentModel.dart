class Comment {
  String text;
  String commentor;
  DateTime date;

  Comment({
    required this.text,
    required this.commentor,
    required this.date,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    text: json["text"],
    commentor: json["commentor"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "commentor": commentor,
    "date": date.toIso8601String(),
  };
}
