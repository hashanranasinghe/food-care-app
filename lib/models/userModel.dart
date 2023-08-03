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
  List<dynamic>? foodRequest;

  User({
    this.id,
    this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.isVerify,
    this.verificationToken,
    this.address,
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
    foodRequest: List<dynamic>.from(json["foodRequest"]?.map((x) => x) ?? []),
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
    "foodRequest": List<dynamic>.from(foodRequest!.map((x) => x)),
  };
}
