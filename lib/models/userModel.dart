import '../utils/constraints.dart';

class User {
  String? id;
  String name;
  String email;
  String phone;
  // String imageUrl;
  String password;
  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    // required this.imageUrl,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        // imageUrl: json["imageUrl"],
        password: json["password"],

      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        // "imageUrl": imageUrl,
        "password": password,
      };
}
