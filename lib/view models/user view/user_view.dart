

import '../../models/userModel.dart';

class UserView {
  final User user;
  UserView({required this.user});

  String? get uid {
    return user.uid;
  }

  String get name {
    return user.name;
  }

  String get email {
    return user.email;
  }

  String? get address {
    return user.address;
  }

  String get phone {
    return user.phone;
  }

  String? get imageUrl {
    return user.imageUrl;
  }
}
