import 'dart:convert';

import 'package:food_care/services/store_token.dart';
import 'package:http/http.dart' as http;

import '../models/userModel.dart';
import '../utils/config.dart';

class UserAPiServices {
  // static var client = http.Client();
  // static Future<User> loginUser(String email, String password) async {
  //   final response = await client.post(
  //     Uri.http(Config.apiURL, Config.loginUserAPI),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'email': email,
  //       'password': password,
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body) as Map<String, dynamic>;
  //     final userJson = json['user'] as Map<String, dynamic>;
  //     final user = User.fromJson(userJson);
  //     print(user);
  //     return user;
  //   } else {
  //     throw Exception('Failed to login');
  //   }
  // }
  static var client = http.Client();

  static Future<Map<String, dynamic>> loginUser(
      String email, String password) async {
    final response = await client.post(
      Uri.http(Config.apiURL, Config.loginUserAPI),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON response
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['accessToken'];
      await StoreToken.storeToken(token);
      final readToekn = await StoreToken.getToken();
      print(readToekn);
      return jsonResponse;
    } else {
      // If the call was not successful, throw an error
      throw Exception('Failed to login');
    }
  }

  static Future<User> register(User user) async {
    Map<String, String> requestHeader = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var url = Uri.http(Config.apiURL, Config.registerUserAPI);
    var response = await client.post(
      url,
      headers: requestHeader,
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final userJson = json['user'] as Map<String, dynamic>;
      final user = User.fromJson(userJson);
      print(user.createdAt);
      return user;
    } else {
      throw Exception('Failed to register user');
    }
  }
}
