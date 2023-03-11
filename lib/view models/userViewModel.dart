import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';

import '../models/userModel.dart';

class UserViewModel extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> getCurrentUser() async {
    try {
      final user = await UserAPiServices.getCurrentUser();
      _user = user;
      notifyListeners();
    } catch (e) {

    }
  }
}
