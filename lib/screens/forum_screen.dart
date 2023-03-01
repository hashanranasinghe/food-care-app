import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey, // set the key to the scaffold
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: Text(
          "Forum",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState
                ?.openDrawer(); // use the current state of the key to open the drawer
          },
          icon: Icon(
            Icons.menu_rounded,
            color: Colors.black,
            size: 35,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ForumPost(comment: (){}, like: (){

            },),
          ],
        ),
      ),
    );
  }
}
