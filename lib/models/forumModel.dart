import 'commentModel.dart';

class Forum {
  String? id;
  String? userId;
  String title;
  String description;
  String author;
  String? imageUrl;
  String? category;
  List<dynamic> likes;
  List<Comment> comments;
  DateTime createdAt;
  DateTime updatedAt;

  Forum({
    this.id,
    this.userId,
    required this.title,
    required this.description,
    required this.author,
    required this.likes,
    this.imageUrl,
    this.category,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
        id: json["_id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        author: json["author"],
        imageUrl: json["imageUrl"],
        category: json["category"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "title": title,
        "description": description,
        "author": author,
        "imageUrl": imageUrl,
        "category": category,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
