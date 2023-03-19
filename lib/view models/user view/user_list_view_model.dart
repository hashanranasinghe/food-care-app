// import 'package:flutter/cupertino.dart';
// import 'package:food_care/services/api%20services/user_api_services.dart';
// import 'package:food_care/view%20models/user%20view/user_view.dart';
//
//
//
// class UserListViewModel extends ChangeNotifier {
//   List<UserView> users = <UserView>[];
//
//
//   Future<void> getAllUsers() async {
//
//     final results = await UserAPiServices.getUsers();
//     users = results.map((user) => UserView(user: user)).toList();
//
//
//     notifyListeners();
//   }
// }
