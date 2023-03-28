import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_care/services/store_token.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:http/http.dart' as http;

import '../../models/userModel.dart';
import '../../utils/config.dart';

class UserAPiServices {
  static var client = http.Client();
  // Function to get the login user from the API
  static Future<int> loginUser(
      String email, String password, BuildContext context) async {
    int res = resFail;
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
      res = resOk;
      return res;
    } else {
      // If the call was not successful, throw an error
      //throw Exception('Failed to login');
      return res;
    }
  }

  // Function to get the register user from the API
  static Future<int> registerUser(User user) async {

    int res = resFail;
    // Create a new multipart request
    var request = http.MultipartRequest(
      'POST',
      Uri.http(Config.apiURL, Config.registerUserAPI),
    );

    // Add the user data to the request
    request.fields['name'] = user.name;
    request.fields['email'] = user.email;
    request.fields['phone'] = user.phone;
    request.fields['address'] = user.address!;
    request.fields['password'] = user.password!;

    // Add the user's image to the request
    if (user.imageUrl != null) {
      final file = await http.MultipartFile.fromPath(
          'imageUrl', user.imageUrl.toString());
      request.files.add(file);
    }

    // Send the request
    final response = await request.send();

    // Check the response status code
    if (response.statusCode == 200) {
      // Registration successful
      res = resOk;
      print('User registered successfully.');
      return res;
    } else {
      // Registration failed
      print('Registration failed with status code ${response.statusCode}.');
      return res;
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
      print("${user.name} hi ${user.id}");
      return user;
    } else {
      throw Exception('Failed to get current user');
    }
  }

  // static Future<void> updateUser({required User user}) async {
  //
  //   String? token = await StoreToken.getToken();
  //   // Create a new multipart request
  //   var request = http.MultipartRequest(
  //     'PUT',
  //     Uri.http(Config.apiURL, Config.updateUser(id: user.id.toString())),
  //   );
  //
  //   // Add the user data to the request
  //   request.fields['name'] = user.name;
  //   request.fields['email'] = user.email;
  //   request.fields['phone'] = user.phone;
  //   request.fields['address'] = user.address.toString();
  //   request.fields['password'] = user.password.toString();
  //
  //   // Add the user's image to the request
  //   if (user.imageUrl != "" &&
  //       user.imageUrl != null &&
  //       !user.imageUrl.toString().contains("profiles")) {
  //     final file = await http.MultipartFile.fromPath(
  //       'imageUrl',
  //       user.imageUrl.toString(),
  //     );
  //     request.files.add(file);
  //   }
  //
  //   // Set the JWT token in the request headers
  //   request.headers['Authorization'] = 'Bearer $token';
  //   print(request.fields);
  //   // Send the request
  //   final response = await request.send();
  //
  //   // Check the response status code
  //   if (response.statusCode == 200) {
  //     // Update successful
  //     print('User updated successfully.');
  //   } else {
  //     // Update failed
  //     print('Update failed with status code ${response.statusCode}.');
  //   }
  // }
  //Todo can't update profile picture
  static Future<void> updateUser({required User user}) async {
    String? token = await StoreToken.getToken();
    // Encode the user data as JSON
    final userData = jsonEncode({
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'address': user.address,
      'password': user.password,
    });

    // Create a new HTTP request
    final url =
        Uri.http(Config.apiURL, Config.updateUser(id: user.id.toString()));
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final response = await http.put(url, headers: headers, body: userData);

    // Check the response status code
    if (response.statusCode == 200) {
      // Update successful
      print('User updated successfully.');
    } else {
      // Update failed
      print('Update failed with status code ${response.statusCode}.');
    }
  }

  static Future<User> getUser(String id) async {
    print(id);
    final response =
        await client.get(Uri.http(Config.apiURL, Config.getUser(id)));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception('Failed to get user');
    }
  }

  static Future<List<User>> getUsers() async {
    // Get the JWT token from secure storage
    String? token = await StoreToken.getToken();

    // Send a GET request to the API with the token in the Authorization header
    final response = await client.get(
      Uri.http(Config.apiURL, Config.users),
      headers: {'Authorization': 'Bearer $token'},
    );

    // Check if the response was successful and parse the forum information
    if (response.statusCode == 200) {
      final List<dynamic> userJsonList = json.decode(response.body);
      List<User> userList =
          userJsonList.map((userJson) => User.fromJson(userJson)).toList();
      return userList;
    } else {
      throw Exception('Failed to get forums');
    }
  }
}
