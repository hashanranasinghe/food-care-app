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
  List<dynamic> deviceToken;
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
    this.imageUrl,
    this.password,
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
        verificationToken: json['verificationToken'],
        password: json["password"],
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
        "deviceToken": List<dynamic>.from(deviceToken.map((x) => x))
      };
}
