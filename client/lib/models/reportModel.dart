class Report {
  String? id;
  String? userId;
  String description;
  String action;
  Post post;

  Report({
    this.id,
    this.userId,
    required this.action,
    required this.post,
    required this.description,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["_id"],
        userId: json["user_id"],
        description: json["description"],
        action: json["action"],
        post: json["post"] is List
            ? Post.fromJson(json["post"][0])
            : Post.fromJson(json["post"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "post": post.toJson(),
        "description": description,
        "action": action,
      };
}

class Post {
  String id;
  String type;

  Post({
    required this.id,
    required this.type,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}
