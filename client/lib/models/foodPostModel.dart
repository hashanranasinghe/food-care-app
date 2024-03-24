class Food {
  String? id;
  String? userId;
  String? author;
  String title;
  String description;
  String quantity;

  Location location;
  AvailableTime availableTime;
  String category;
  bool isComplete;
  List<String> imageUrls;
  List<dynamic> requests;
  List<StatusFoodPost> statusFoodPost;

  DateTime createdAt;
  DateTime updatedAt;

  Food({
    this.id,
    this.userId,
    this.author,
    required this.title,
    required this.category,
    required this.description,
    required this.quantity,
    required this.isComplete,
    required this.location,
    required this.availableTime,
    required this.imageUrls,
    required this.requests,
    required this.statusFoodPost,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["_id"],
        author: json['author'],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        quantity: json["quantity"],
        isComplete: json["isComplete"],
        requests: List<dynamic>.from(json["requests"].map((x) => x)),
        statusFoodPost: List<StatusFoodPost>.from(
            json["acceptRequests"]?.map((x) => StatusFoodPost.fromJson(x)) ??
                []),
        location: json["location"] is List
            ? Location.fromJson(json["location"][0])
            : Location.fromJson(json["location"]),
        category: json["category"],
        availableTime: json["availableTime"] is List
            ? AvailableTime.fromJson(json["availableTime"][0])
            : AvailableTime.fromJson(json["availableTime"]),
        imageUrls: (json["imageUrls"] as List).cast<String>(),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "title": title,
        "author": author,
        "description": description,
        "quantity": quantity,
        "isComplete": isComplete,
        "location": location.toJson(),
        "availableTime": availableTime.toJson(),
        "category": category,
        "imageUrls": imageUrls,
        "requests": List<dynamic>.from(requests.map((x) => x)),
        "acceptRequests":
            List<StatusFoodPost>.from(statusFoodPost.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Location {
  String lan;
  String lon;

  Location({
    required this.lan,
    required this.lon,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lan: json["lan"],
        lon: json["lon"],
      );

  Map<String, dynamic> toJson() => {
        "lan": lan,
        "lon": lon,
      };
}

class AvailableTime {
  String startTime;
  String endTime;

  AvailableTime({
    required this.startTime,
    required this.endTime,
  });

  factory AvailableTime.fromJson(Map<String, dynamic> json) => AvailableTime(
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "endTime": endTime,
      };
}

class StatusFoodPost {
  String requesterId;
  String status;

  StatusFoodPost({
    required this.requesterId,
    required this.status,
  });

  factory StatusFoodPost.fromJson(Map<String, dynamic> json) => StatusFoodPost(
        requesterId: json["userId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userId": requesterId,
        "status": status,
      };
}
