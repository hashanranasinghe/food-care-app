class User {
  String? id;
  String name;
  String email;
  String phone;
  String? address;
  String? imageUrl;
  String? password;
  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    this.imageUrl,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        imageUrl: json["imageUrl"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "imageUrl": imageUrl,
        "password": password,
      };
}
