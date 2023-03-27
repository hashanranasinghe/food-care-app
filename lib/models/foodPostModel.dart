

class Food {
  String? id;
  String? userId;
  String? author;
  String title;
  String description;
  String quantity;
  String? other;
  String pickupTimes;
  String listDays;
  Location location;
  bool isShared;
  List<String> imageUrls;
  DateTime createdAt;
  DateTime updatedAt;

  Food({
    this.id,
    this.userId,
    this.author,
    required this.title,
    required this.description,
    required this.quantity,
    this.other,
    required this.isShared,
    required this.pickupTimes,
    required this.listDays,
    required this.location,
    required this.imageUrls,
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
        other: json["other"],
        pickupTimes: json["pickupTimes"],
        listDays: json["listDays"],
        isShared: json["isShared"],
        location: json["location"] is List
            ? Location.fromJson(json["location"][0])
            : Location.fromJson(json["location"]),
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
        "other": other,
        "pickupTimes": pickupTimes,
        "listDays": listDays,
        "isShared": isShared,
        "location": location.toJson(),
        "imageUrls": imageUrls,
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
