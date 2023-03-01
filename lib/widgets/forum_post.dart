import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_care/utils/constraints.dart';

class ForumPost extends StatelessWidget {
  final Function comment;
  final Function like;
  const ForumPost({Key? key, required this.comment, required this.like})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        Text("Hashan Ranasinghe"),
                        Row(
                          children: [
                            Icon(
                              Icons.av_timer_outlined,
                              size: 20,
                            ),
                            Text("1 hour ago"),
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
              child: Text(
                  textAlign: TextAlign.justify,
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"),
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
                                  child:
                                      Image.asset("assets/images/comment.png")),
                            ),
                            SizedBox(width: 8),
                            Text("3 Comments"),
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
                            Text("3 Likess"),
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
  }
}
