import 'package:flutter/material.dart';
import 'package:food_care/widgets/app_bar.dart';
import 'package:food_care/widgets/forum_post.dart';

import '../widgets/drawer.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      text: "Forum",
      widget: SingleChildScrollView(
        child: Column(
          children: [
            ForumPost(
              comment: () {},
              like: () {},
            ),
          ],
        ),
      ),
    );
  }
}
