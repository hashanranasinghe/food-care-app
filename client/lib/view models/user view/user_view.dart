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

  String? get verificationToken {
    return user.verificationToken;
  }

  bool get isVerify {
    return user.isVerify;
  }

  List<dynamic> get deviceToken {
    return user.deviceToken;
  }

  List<dynamic>? get food {
    return user.food;
  }

  List<dynamic>? get forum {
    return user.forum;
  }

  List<dynamic>? get dailyRequest {
    return user.foodRequest;
  }

  String get role {
    return user.role;
  }
}
