import 'package:flutter/cupertino.dart';
import 'package:food_care/models/userModel.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';

class UserUpdateViewModel extends ChangeNotifier {
  late String id;
  late String name;
  late String email;
  late String phone;
  late String address;
  late String imageUrl;

  Future<void> updateUser() async {
    final user =
        User(id:id,name: name, email: email, phone: phone, imageUrl: imageUrl);
    await UserAPiServices.updateUser(user: user);

    notifyListeners();
  }
}
