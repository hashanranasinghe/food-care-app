import 'package:flutter/material.dart';
import 'package:food_care/models/forumModel.dart';
import 'package:food_care/services/api%20services/forum_api_services.dart';
import '../../models/commentModel.dart';

class AddForumViewModel extends ChangeNotifier {
  late String id;
  late String author;
  late String title;
  late String description;
  late String imageUrl;
  late String userId;
  late List<dynamic> likes;
  late List<Comment> comments;
  late DateTime createdAt;
  late DateTime updatedAt;

  Future<void> saveForum() async {
    final forum = Forum(
        imageUrl: imageUrl,
        title: title,
        description: description,
        author: author,
        likes: likes = [],
        comments: comments = [],
        createdAt: createdAt = DateTime.now(),
        updatedAt: updatedAt = DateTime.now());
    await ForumApiServices.createForum(forum: forum);

    notifyListeners();
  }

  Future<void> updateForum() async {
    final forum = Forum(
        id: id,
        imageUrl: imageUrl,
        title: title,
        description: description,
        author: author,
        likes: likes = [],
        comments: comments = [],
        createdAt: createdAt = DateTime.now(),
        updatedAt: updatedAt = DateTime.now());
    await ForumApiServices.updateForum(forum: forum);

    notifyListeners();
  }
}
