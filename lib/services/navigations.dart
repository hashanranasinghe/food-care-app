import 'package:flutter/material.dart';
import 'package:food_care/models/forumModel.dart';
import 'package:food_care/screens/add_food_post_screen.dart';
import 'package:food_care/screens/add_forum_screen.dart';
import 'package:food_care/screens/chat_screen.dart';
import 'package:food_care/screens/forum_screen.dart';
import 'package:food_care/screens/login_screen.dart';
import 'package:food_care/screens/signup_screen.dart';
import 'package:food_care/widgets/bottom_navigationbar.dart';

void openUserSignUp(BuildContext context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SignupScreen()));
}

void openUserSignIn(BuildContext context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const LoginScreen()));
}

void openHome(BuildContext context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const BottomNavigation()));
}

void openAddForum(BuildContext context) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => const AddForumScreen()));
}

void openAddFoodPost(BuildContext context) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => const AddFoodPostScreen()));
}

void openCHats(BuildContext context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const ChatScreen()));
}

void openOwnForums(BuildContext context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const ForumScreen(forum: false)));
}

void openForums(BuildContext context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const ForumScreen(forum: true)));
}

void openUpdateForum(BuildContext context, Forum forum) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddForumScreen(
                forum: forum,
              )));
}
