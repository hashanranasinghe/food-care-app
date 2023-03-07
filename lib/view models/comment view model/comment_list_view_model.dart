import 'package:flutter/cupertino.dart';
import 'package:food_care/services/api%20services/forums_comment_api_services.dart';

import '../forum view/forum_list-view_model.dart';
import 'comment_view_model.dart';

class CommentListViewModel extends ChangeNotifier {
  List<CommentViewModel> comments = <CommentViewModel>[];
  Status status = Status.empty;

  Future<void> getAllComments(forumId) async {
    status = Status.loading;
    final results = await ForumCommentApi.getAllCommentsInForum(forumId);
    comments =
        results.map((comment) => CommentViewModel(comment: comment)).toList();
    status = comments.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }
}
