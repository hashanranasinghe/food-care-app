import 'dart:convert';
import 'dart:io';

import 'package:food_care/services/store_token.dart';
import 'package:http/http.dart' as http;

import '../../models/forumModel.dart';
import '../../utils/config.dart';

class ForumApiServices {
  static var client = http.Client();
  //get all forums
  static Future<List<Forum>> getForums() async {
    // Get the JWT token from secure storage
    String? token = await StoreToken.getToken();

    // Send a GET request to the API with the token in the Authorization header
    final response = await client.get(
      Uri.http(Config.apiURL, Config.getApostForums),
      headers: {'Authorization': 'Bearer $token'},
    );

    // Check if the response was successful and parse the forum information
    if (response.statusCode == 200) {
      final List<dynamic> forumJsonList = json.decode(response.body);
      List<Forum> forumList =
          forumJsonList.map((forumJson) => Forum.fromJson(forumJson)).toList();
      return forumList;
    } else {
      throw Exception('Failed to get forums');
    }
  }

  static Future<String> createForum({required Forum forum}) async {
    String? token = await StoreToken.getToken();
    var request = http.MultipartRequest(
        'POST', Uri.http(Config.apiURL, Config.getApostForums)
    );
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('imageUrl', forum.imageUrl.toString()));
    request.fields['title'] = forum.title;
    request.fields['description'] = forum.description;
    request.fields['author'] = forum.author;

    var response = await request.send();
    if (response.statusCode == 200) {
      final json = jsonDecode(await response.stream.bytesToString());
      print(json);
      return json.toString();
    } else {
      throw Exception('Failed to create forum.');
    }
  }
}
