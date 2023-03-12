

import '../../models/commentModel.dart';
import '../../models/forumModel.dart';

class ForumViewModel {
  final Forum forum;

  ForumViewModel({required this.forum});

  String? get id {
    return forum.id;
  }

  String? get userId {
    return forum.userId;
  }

  String get title {
    return forum.title;
  }

  String get description {
    return forum.description;
  }

  String? get imageUrl {
    return forum.imageUrl;
  }

  String get author {
    return forum.author;
  }

  List<dynamic> get likes {
    return forum.likes;
  }

  List<Comment> get comments {
    return forum.comments;
  }

  DateTime get createdAt {
    return forum.createdAt;
  }

  DateTime get updatedAt {
    return forum.updatedAt;
  }
}
