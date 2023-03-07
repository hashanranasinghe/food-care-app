import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_care/services/api%20services/forum_api_services.dart';
import 'package:food_care/services/api%20services/forums_comment_api_services.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/userViewModel.dart';
import 'package:food_care/screens/comment_screen.dart';
import 'package:provider/provider.dart';
import '../services/date.dart';
import '../utils/config.dart';
import '../view models/forum view/forum_list-view_model.dart';
import '../view models/forum view/forum_view_model.dart';

class ForumPost extends StatefulWidget {
  final List<ForumViewModel> forums;
  final Function comment;
  final UserViewModel user;
  const ForumPost(
      {Key? key,
      required this.forums,
      required this.comment,
      required this.user})
      : super(key: key);

  @override
  State<ForumPost> createState() => _ForumPostState();
}

class _ForumPostState extends State<ForumPost> {
  late ForumListViewModel _forumListViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _forumListViewModel =
        Provider.of<ForumListViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.forums.length,
        itemBuilder: (context, index) {
          final forum = widget.forums[index];
          return Card(
            color: Colors.white,
            elevation: 10,
            margin: EdgeInsets.only(top: 20, left: 15, right: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Image.asset("assets/images/icon.png"),
                          backgroundColor: kPrimaryColorlight,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(forum.author,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              Row(
                                children: [
                                  Icon(
                                    Icons.av_timer_outlined,
                                    size: 20,
                                  ),
                                  Text(
                                      "${Date.getStringdatetime(forum.createdAt)} ago"),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: Text(
                          textAlign: TextAlign.left,
                          forum.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  forum.imageUrl == null
                      ? Container()
                      : SizedBox(
                          height: 500,
                          child: Image.network(
                              'http://${'${Config.apiURL}\\${forum.imageUrl}'}'
                                  .replaceAll('\\', '/'))),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child:
                        Text(textAlign: TextAlign.justify, forum.description),
                  ),
                  SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 50,
                          child: Container(
                            color: kPrimaryColorlight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  fullscreenDialog: true,
                                                  builder: (context) =>
                                                      CommentScreen(
                                                        forumId:
                                                            forum.id.toString(),
                                                      )));
                                          print(ForumCommentApi
                                              .getAllCommentsInForum(
                                                  forum.id.toString()));
                                          print(forum.id.toString());
                                        },
                                        child: Image.asset(
                                            "assets/images/comment.png")),
                                  ),
                                  SizedBox(width: 8),
                                  Text("${forum.comments.length} Comments"),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () async {
                                          print(forum.likes);
                                          await ForumApiServices.likeForum(
                                              forum.id.toString());
                                          await _forumListViewModel
                                              .getAllForums();
                                        },
                                        child: _like(
                                            forum.likes, widget.user.user!.id)),
                                  ),
                                  SizedBox(width: 8),
                                  Text("${forum.likes.length} Likes"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _like(List<dynamic> likes, id) {
    if (likes.contains(id)) {
      return Image.asset("assets/images/favorite.png");
    } else {
      return Image.asset("assets/images/unfavorite.png");
    }
  }
}
