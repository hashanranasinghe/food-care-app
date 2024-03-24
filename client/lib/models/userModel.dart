class User {
  String? id;
  String? uid;
  String name;
  String email;
  String phone;
  String? verificationToken;
  bool isVerify;
  String? address;
  String? imageUrl;
  String? password;
  String role; // Added the 'role' field for user roles
  List<dynamic> deviceToken;
  List<dynamic>? food;
  List<dynamic>? forum;
  List<FoodRequests>? foodRequest;

  User({
    this.id,
    this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.isVerify,
    this.verificationToken,
    this.address,
    this.food,
    this.forum,
    required this.deviceToken,
    this.foodRequest,
    this.imageUrl,
    this.password,
    required this.role, // Added the 'role' field in the constructor
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        uid: json["_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        imageUrl: json["imageUrl"],
        isVerify: json['isVerify'],
        deviceToken: List<dynamic>.from(json["deviceToken"].map((x) => x)),
        food: List<dynamic>.from(json["food"].map((x) => x)),
        forum: List<dynamic>.from(json["forum"].map((x) => x)),
        foodRequest: List<FoodRequests>.from(
            json["foodRequest"]?.map((x) => FoodRequests.fromJson(x)) ?? []),
        verificationToken: json['verificationToken'],
        password: json["password"],
        role: json["role"], // Added the 'role' field
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "_uid": uid,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "isVerify": isVerify,
        "verificationToken": verificationToken,
        "imageUrl": imageUrl,
        "password": password,
        "role": role, // Added the 'role' field
        "deviceToken": List<dynamic>.from(deviceToken.map((x) => x)),
        "food": List<dynamic>.from(food!.map((x) => x)),
        "forum": List<dynamic>.from(forum!.map((x) => x)),
        "foodRequest": List<dynamic>.from(foodRequest!.map((x) => x.toJson())),
      };
}

class FoodRequests {
  String id;
  String foodId;
  String permission;
  String complete;

  FoodRequests({
    required this.id,
    required this.foodId,
    required this.permission,
    required this.complete,
  });

  factory FoodRequests.fromJson(Map<String, dynamic> json) => FoodRequests(
        id: json["_id"],
        foodId: json["foodId"],
        permission: json["permission"],
        complete: json["complete"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "foodId": foodId,
        "permission": permission,
        "complete": complete,
      };
}
