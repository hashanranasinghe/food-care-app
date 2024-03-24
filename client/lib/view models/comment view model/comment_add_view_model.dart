import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/forums_comment_api_services.dart';

import '../../models/commentModel.dart';

class CommentAddViewModel extends ChangeNotifier {
  late String text;

  late String commenter;
  late DateTime date;

  Future<void> saveComment(forumId) async {
    final comment = Comment(
        text: text,
        commenter: commenter,
        date: DateTime.now());
    await ForumCommentApi.addComment(forumId: forumId, comment: comment);
  }
}
