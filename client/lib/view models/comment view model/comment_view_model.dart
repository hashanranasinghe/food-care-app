import '../../models/commentModel.dart';

class CommentViewModel {
  final Comment comment;

  CommentViewModel({required this.comment});

  String? get id {
    return comment.id;
  }

  String get text {
    return comment.text;
  }

  String get commenter {
    return comment.commenter;
  }

  String? get commenterId {
    return comment.commenterId;
  }

  DateTime get date {
    return comment.date;
  }
}
