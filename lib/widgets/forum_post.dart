import 'package:flutter/material.dart';

import 'package:food_care/services/api%20services/forum_api_services.dart';
import 'package:food_care/services/api%20services/forums_comment_api_services.dart';

import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/screens/forum/comment_screen.dart';
import 'package:food_care/view%20models/user%20view/user_view.dart';
import 'package:food_care/widgets/show_time_ago_row.dart';
import 'package:food_care/widgets/updateNdelete.dart';
import 'package:provider/provider.dart';

import '../utils/config.dart';
import '../view models/forum view/forum_list-view_model.dart';
import '../view models/forum view/forum_view_model.dart';
import 'package:expandable_text/expandable_text.dart';

import 'flutter_toast.dart';

class ForumPost extends StatefulWidget {
  final List<ForumViewModel> forums;
  final Function comment;
  final UserViewModel user;
  final List<UserView> userList;
  final bool? own;

  const ForumPost(
      {Key? key,
      required this.forums,
      required this.comment,
      required this.user,
      this.own,
      required this.userList})
      : super(key: key);

  @override
  State<ForumPost> createState() => _ForumPostState();
}

class _ForumPostState extends State<ForumPost> {
  late String imageUrl = "";
  late ForumListViewModel _forumListViewModel;
  late bool load = false;

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
          final user =
          widget.userList.firstWhere((user) => user.uid == forum.userId);
          return Card(
            color: Colors.white,
            elevation: 10,
            margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: kPrimaryColorlight,
                              radius: 10,
                              backgroundImage: user.imageUrl == null
                                  ? AssetImage(icon.toString())
                                  : NetworkImage(Config.imageUrl(
                                  imageUrl:
                                  user.imageUrl.toString()))
                              as ImageProvider<Object>,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(forum.author,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  ShowTimeAgoRow(time: forum.createdAt),
                                ],
                              ),
                            )
                          ],
                        ),
                        if (widget.own == false) ...[
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return UpdateNDelete(update: () async {
                                      final getForum =
                                          await ForumApiServices.getOwnForum(
                                              forumId: forum.id.toString());
                                      openUpdateForum(context, getForum);
                                    }, delete: () async {
                                      int res = await ForumApiServices.deleteForum(
                                          forum.id.toString());
                                      if(res == resOk){
                                        Provider.of<ForumListViewModel>(context,
                                            listen: false)
                                            .getOwnAllForums();
                                        Navigator.pop(context);
                                        ToastWidget.toast(msg: "Forum deleted successfully");
                                      }else{
                                        ToastWidget.toast(msg: "Something went to wrong.");
                                      }


                                    });
                                  },
                                );
                              },
                              icon: const Icon(Icons.more_vert))
                        ] else ...[
                          Container()
                        ]
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
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  forum.imageUrl == null
                      ? Container()
                      : SizedBox(
                          height: 500,
                          child: Image.network(Config.imageUrl(
                              imageUrl: forum.imageUrl.toString()))),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    // ignore: prefer_const_constructors
                    child: ExpandableText(
                      forum.description,
                      textAlign: TextAlign.justify,
                      maxLines: 4,
                      collapseText: "show less",
                      expandText: 'show more',
                    ),
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
                                  const SizedBox(width: 8),
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
                                  const SizedBox(width: 8),
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
