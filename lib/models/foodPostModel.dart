class Food {
  String? id;
  String? userId;
  String? author;
  String title;
  String description;
  String quantity;
  String listDays;
  Location location;
  AvailableTime availableTime;
  String category;
  bool isShared;
  List<String> imageUrls;
  List<dynamic> requests;
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
    required this.isShared,
    required this.listDays,
    required this.location,
    required this.availableTime,
    required this.imageUrls,
    required this.requests,
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
        listDays: json["listDays"],
        isShared: json["isShared"],
        requests: List<dynamic>.from(json["requests"].map((x) => x)),
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
        "listDays": listDays,
        "isShared": isShared,
        "location": location.toJson(),
        "availableTime": availableTime.toJson(),
        "category": category,
        "imageUrls": imageUrls,
        "requests": List<dynamic>.from(requests.map((x) => x)),
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
