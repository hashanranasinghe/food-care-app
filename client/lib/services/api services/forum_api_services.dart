import 'dart:convert';

import 'package:food_care/services/store_token.dart';
import 'package:food_care/utils/constraints.dart';
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

  //get own forums
  static Future<List<Forum>> getOwnForums() async {
    String? token = await StoreToken.getToken();
    final response = await client.get(
      Uri.http(Config.apiURL, Config.getOwnForums),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList.map((json) => Forum.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get forums: ${response.statusCode}');
    }
  }

  //get a own forum
  static Future<Forum> getOwnForum({required String forumId}) async {
    String? token = await StoreToken.getToken();
    final response = await client.get(
      Uri.http(Config.apiURL, Config.getOwnForum(id: forumId)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Forum found
      final forumJson = jsonDecode(response.body);
      final forum = Forum.fromJson(forumJson);
      return forum;
    } else if (response.statusCode == 404) {
      // Forum not found
      throw Exception('Forum not found');
    } else {
      // Other error
      throw Exception('Failed to get forum');
    }
  }

  //create forum
  static Future<int> createForum({required Forum forum}) async {
    int res = resFail;
    String? token = await StoreToken.getToken();
    var request = http.MultipartRequest(
        'POST', Uri.http(Config.apiURL, Config.getApostForums));
    request.headers['Authorization'] = 'Bearer $token';

    if(forum.imageUrl !=""){
    request.files.add(await http.MultipartFile.fromPath(
        'imageUrl', forum.imageUrl.toString()));}

    print(forum.imageUrl.toString());
    request.fields['title'] = forum.title;
    request.fields['description'] = forum.description;
    request.fields['author'] = forum.author;
    request.fields['category'] = forum.category!;

    var response = await request.send();
    if (response.statusCode == 200) {
      final json = jsonDecode(await response.stream.bytesToString());
      res= resOk;
      return res;
    } else {
      //throw Exception('Failed to create forum.');
      return res;
    }
  }

  //like forum
  static Future<void> likeForum(String forumId) async {
    // Get the JWT token from secure storage
    String? token = await StoreToken.getToken();

    // Send a PUT request to the API with the token in the Authorization header
    final response = await client.put(
      Uri.http(Config.apiURL, Config.likeForum(id: forumId)),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // Check if the response was successful
    if (response.statusCode == 200) {
      final message = json.decode(response.body);
      print("ok");
    } else {
      throw Exception('Failed to like forum');
    }
  }

  //update forum
  static Future<int> updateForum({required Forum forum}) async {
    int res = resOk;
    String? token = await StoreToken.getToken();

    final request = http.MultipartRequest(
      'PUT',
      Uri.http(Config.apiURL, Config.getOwnForum(id: forum.id.toString())),
    );

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    });

    if (forum.imageUrl != "" && forum.imageUrl != null && !forum.imageUrl.toString().contains("uploads")) {
      print('Adding image to request...');
      request.files.add(await http.MultipartFile.fromPath(
        'imageUrl',
        forum.imageUrl.toString(),
      ));
    }

    request.fields.addAll({
      'title': forum.title,
      'description': forum.description,
      'author': forum.author,
      'category': forum.category!,

    });

    final response = await request.send();

    if (response.statusCode != 200) {
      res = resFail;
      return res;
      //throw Exception('Failed to update forum');
    }

    final responseString = await response.stream.bytesToString();

    return res;
  }

  //delete forum
  static Future<int> deleteForum(String forumId) async {
    int res = resFail;
    // Get the JWT token from secure storage
    String? token = await StoreToken.getToken();
    final response = await client.delete(
      Uri.http(Config.apiURL, Config.getOwnForum(id: forumId)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Forum deleted successfully
      res= resOk;
      print('Forum deleted successfully');
      return res;
    } else {
      // Forum not found or other error
      print('Failed to delete forum');
      return res;
    }
  }

  //delete image forum
  static Future<void> deleteImageForum(String forumId) async {
    // Get the JWT token from secure storage
    String? token = await StoreToken.getToken();
    final response = await client.delete(
      Uri.http(Config.apiURL, Config.deleteOwnForumImage(id: forumId)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Forum deleted successfully
      print('Forum deleted successfully');
    } else {
      // Forum not found or other error
      print('Failed to delete forum');
    }
  }

}
