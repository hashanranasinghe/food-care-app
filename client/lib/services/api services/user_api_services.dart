import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_care/models/foodPostModel.dart';
import 'package:food_care/services/store_token.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../../models/userModel.dart';
import '../../utils/config.dart';

class UserAPiServices {
  static var client = http.Client();
  static var uuid = const Uuid();
  // Function to get the login user from the API
  static Future<int> loginUser(
      String email, String password, BuildContext context) async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    int res = resFail;
    final response = await client.post(
      Uri.http(Config.apiURL, Config.loginUserAPI),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'deviceToken': deviceToken.toString(),
      }),
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON response

      final jsonResponse = jsonDecode(response.body);
      final userJson = jsonResponse['user'] as Map<String, dynamic>;
      final user = User.fromJson(userJson);
      if (user.isVerify == false) {
        res = resEmail;
        return res;
      }
      final token = jsonResponse['accessToken'];
      await StoreToken.storeToken(token);
      final readToken = await StoreToken.getToken();
      print(readToken);
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
    request.fields['address'] = user.address.toString();
    request.fields['isVerify'] = user.isVerify.toString();
    request.fields['verificationToken'] = user.verificationToken.toString();
    request.fields['deviceToken'] = user.deviceToken.join(',');
    request.fields['foodRequest'] = user.foodRequest.toString();
    request.fields['password'] = user.password!;
    request.fields['role'] = user.role;

    // Add the user's image to the request

    if (user.imageUrl.toString() != "") {
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

  static Future<String> forgetPassword({required String email}) async {
    print(email);
    final response = await client.post(
      Uri.http(Config.apiURL, Config.forgetPasswordApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON response

      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      return "Error";
    }
  }

  static Future<int> resetPassword(
      {required String password,
      required String id,
      required String token}) async {
    int res = resFail;
    final userData = jsonEncode({
      'password': password,
    });
    final url =
        Uri.http(Config.apiURL, Config.resetPassword(id: id, token: token));
    final headers = {'Content-Type': 'application/json'};
    final response = await http.put(url, headers: headers, body: userData);
    // Check the response status code
    if (response.statusCode == 200) {
      // Update successful
      print('User updated successfully.');
      res = resOk;
      return res;
    } else if (response.statusCode == 401) {
      // Update failed
      res = 401;
      return res;
    } else if (response.statusCode == 404) {
      res = 404;
      return res;
    }
    return res;
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
      print("${user.name} hi ${user.id}  ${user.foodRequest!.length}");
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
  static Future<void> updateUser(
      {required String name,
      required String id,
      required String email,
      required String imgUrl,
      required String phone,
      required String address}) async {
    String? token = await StoreToken.getToken();
    // Encode the user data as JSON
    final userData = jsonEncode({
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    });

    // Create a new HTTP request
    final url = Uri.http(Config.apiURL, Config.updateUser(id: id.toString()));
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

  //food request
  static Future<void> foodRequest(
      {required String foodId,
      required String userId,
      required String path,
      required String complete,
      required String state}) async {
    // Get the JWT token from secure storage
    String? token = await StoreToken.getToken();
    final foodData = jsonEncode({
      "foodId": foodId,
      "userId": userId,
      "permission": state,
      "complete": complete
    });

    // Send a PUT request to the API with the token in the Authorization header
    final response = await client.put(Uri.http(Config.apiURL, path),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: foodData);

    // Check if the response was successful
    if (response.statusCode == 200) {
      final message = json.decode(response.body);
      print("ok");
    } else {
      throw Exception(response.statusCode);
    }
  }

//getrequestsfoodposts
  static Future<List<Food>> getRequestsFood(
      {required String path,
      required String complete,
      required String permission}) async {
    // Get the JWT token from secure storage
    String? token = await StoreToken.getToken();
    final foodData =
        jsonEncode({"permission": permission, "complete": complete});

    // Send a PUT request to the API with the token in the Authorization header
    final response = await client.put(Uri.http(Config.apiURL, path),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: foodData);

    // Check if the response was successful
    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList.map((json) => Food.fromJson(json)).toList();
    } else {
      throw Exception(response.statusCode);
    }
  }

  //upload & remove food
  static Future<void> food({
    required String foodId,
    required String path,
  }) async {
    try {
      String? token = await StoreToken.getToken();
      final foodData = jsonEncode({
        "foodId": foodId,
      });

      final response = await client.put(
        Uri.http(Config.apiURL, path),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: foodData,
      );

      if (response.statusCode == 200) {
        final message = json.decode(response.body);
        print("Food post uploaded: $message");
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized: ${response.statusCode}");
      } else if (response.statusCode == 400) {
        final errorMessage = json.decode(response.body);
        throw Exception("Client error: $errorMessage");
      } else if (response.statusCode == 500) {
        throw Exception("Server error: ${response.statusCode}");
      } else {
        throw Exception("Unexpected error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  } //upload & remove food

  static Future<void> forum({
    required String forumId,
    required String path,
  }) async {
    try {
      String? token = await StoreToken.getToken();
      final forumData = jsonEncode({
        "forumdId": forumId,
      });

      final response = await client.put(
        Uri.http(Config.apiURL, path),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: forumData,
      );

      if (response.statusCode == 200) {
        final message = json.decode(response.body);
        print("Food post uploaded: $message");
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized: ${response.statusCode}");
      } else if (response.statusCode == 400) {
        final errorMessage = json.decode(response.body);
        throw Exception("Client error: $errorMessage");
      } else if (response.statusCode == 500) {
        throw Exception("Server error: ${response.statusCode}");
      } else {
        throw Exception("Unexpected error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
