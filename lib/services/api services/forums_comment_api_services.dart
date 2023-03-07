import 'dart:convert';
import 'package:food_care/models/commentModel.dart';
import 'package:http/http.dart' as http;

import '../../utils/config.dart';
import '../store_token.dart';
class ForumCommentApi{
  static var client = http.Client();

  static Future<List<Comment>> getAllCommentsInForum(String forumId) async {
    String? token = await StoreToken.getToken();
    final response = await client.get(
      Uri.http(Config.apiURL, Config.commentForum(forumId)),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final List<dynamic> commentJsonList = responseBody['comments'];
      List<Comment> commentList = commentJsonList
          .map((commentJson) => Comment.fromJson(commentJson))
          .toList();
      return commentList;
    } else {
      throw Exception('Failed to get comments');
    }
  }

  static Future<void> addComment({required String forumId, required Comment comment}) async {
    String? token = await StoreToken.getToken();


    try {
      final response = await client.post(
        Uri.http(Config.apiURL, Config.commentForum(forumId)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'text': comment.text,
          'commenter': comment.commenter,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final comment = responseData['comment'];

        print('Comment added successfully: $comment');
      } else {
        final errorMessage = json.decode(response.body)['message'];
        print('Failed to add comment: $errorMessage');
      }
    } catch (error) {
      print('Error adding comment: $error');
    }
  }

}