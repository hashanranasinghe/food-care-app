import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_care/utils/constraints.dart';

import '../services/date.dart';
import '../utils/config.dart';
import '../view models/forum view/forum_view_model.dart';

class ForumPost extends StatelessWidget {
  final List<ForumViewModel> forums;
  final Function comment;
  final Function like;
  const ForumPost(
      {Key? key,
      required this.forums,
      required this.comment,
      required this.like})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: forums.length,
        itemBuilder: (context, index) {
          final forum = forums[index];
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
                              Text(forum.author),
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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Text(textAlign: TextAlign.left, forum.title),
                  ),
                  forum.imageUrl == null
                      ? Container()
                      : SizedBox(
                          height: 200,
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
                                        onTap: () {
                                          comment();
                                        },
                                        child: Image.asset(
                                            "assets/images/comment.png")),
                                  ),
                                  SizedBox(width: 8),
                                  Text("${forum.comments.length} Comments"),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () {
                                          like();
                                        },
                                        child: Image.asset(
                                            "assets/images/unfavorite.png")),
                                  ),
                                  SizedBox(width: 8),
                                  Text("${forum.likesCount} Likes"),
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
}
