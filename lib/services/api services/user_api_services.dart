import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/services/store_token.dart';
import 'package:http/http.dart' as http;

import '../../models/userModel.dart';
import '../../utils/config.dart';

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
  // Function to get the login user from the API
  static Future<Map<String, dynamic>> loginUser(
      String email, String password,BuildContext context) async {
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
      openHome(context);
      print(readToekn);
      return jsonResponse;
    } else {
      // If the call was not successful, throw an error
      throw Exception('Failed to login');
    }
  }

  // Function to get the register user from the API
  static Future<User> registerUser(User user) async {
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
      print(user);
      return user;
    } else {
      throw Exception('Failed to register user');
    }
  }

  // Function to get the current user from the API
  static Future<User> getCurrentUser() async {
    // Get the JWT token from secure storage
    String? token = await StoreToken.getToken();

    // Send a GET request to the API with the token in the Authorization header
    final response = await client.get(
      Uri.http(Config.apiURL, Config.currentUserAPI),
      headers: {'Authorization': 'Bearer $token'},
    );

    // Check if the response was successful and parse the user information
    if (response.statusCode == 200) {
      final userJson = json.decode(response.body) as Map<String, dynamic>;
      final user = User.fromJson(userJson);
      print(user.name);
      return user;
    } else {
      throw Exception('Failed to get current user');
    }
  }
}
