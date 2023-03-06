import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/forum_api_services.dart';
import 'package:food_care/view%20models/forum%20view/forum_view_model.dart';

import '../../models/forumModel.dart';

enum Status { loading, empty, success }

class ForumListViewModel extends ChangeNotifier {
  List<ForumViewModel> forums = <ForumViewModel>[];
  Status status = Status.empty;

  Future<void> getAllForums() async {
    status = Status.loading;
    final results = await ForumApiServices.getForums();
    forums = results.map((forum) => ForumViewModel(forum: forum)).toList();
    status = forums.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }
}
