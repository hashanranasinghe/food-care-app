class Food {
  String userId;
  String title;
  String description;
  String quantity;
  String other;
  String pickupTimes;
  String listDays;
  Location location;
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;

  Food({
    required this.userId,
    required this.title,
    required this.description,
    required this.quantity,
    required this.other,
    required this.pickupTimes,
    required this.listDays,
    required this.location,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        quantity: json["quantity"],
        other: json["other"],
        pickupTimes: json["pickupTimes"],
        listDays: json["listDays"],
        location: json["location"] is List
            ? Location.fromJson(json["location"][0])
            : Location.fromJson(json["location"]),
        imageUrl: json["imageUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "title": title,
        "description": description,
        "quantity": quantity,
        "other": other,
        "pickupTimes": pickupTimes,
        "listDays": listDays,
        "location": location.toJson(),
        "imageUrl": imageUrl,
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

