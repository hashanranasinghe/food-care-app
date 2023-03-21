class User {
  String? id;
  String? uid;
  String name;
  String email;
  String phone;
  String? address;
  String? imageUrl;
  String? password;
  User({
    this.id,
    this.uid,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
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
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "_uid": uid,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "imageUrl": imageUrl,
        "password": password,
      };
}
