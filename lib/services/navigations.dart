import 'package:flutter/material.dart';
import 'package:food_care/models/forumModel.dart';
import 'package:food_care/screens/food%20post/add_food_post_screen.dart';
import 'package:food_care/screens/forum/add_forum_screen.dart';
import 'package:food_care/screens/chat/chat_screen.dart';
import 'package:food_care/screens/food%20post/food_post_display_screen.dart';
import 'package:food_care/screens/forum/forum_screen.dart';
import 'package:food_care/screens/food%20post/home_screen.dart';
import 'package:food_care/screens/login%20&%20register/login_screen.dart';
import 'package:food_care/screens/chat/messaging_screen.dart';
import 'package:food_care/screens/settings/profile_screen.dart';
import 'package:food_care/screens/settings/settings_screen.dart';
import 'package:food_care/screens/login%20&%20register/signup_screen.dart';
import 'package:food_care/widgets/bottom_navigationbar.dart';

import '../models/foodPostModel.dart';
import '../models/userModel.dart';

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

void openUpdateFoodPost(BuildContext context, Food food) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => AddFoodPostScreen(food: food)));
}

void openChats(BuildContext context, String id) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatScreen(
                id: id,
              )));
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

void openMessaging(
    BuildContext context, String receiverName, String conversationId) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MessagingScreen(
                receiverName: receiverName,
                conversationId: conversationId,
              )));
}

void openOwnFoodPosts(BuildContext context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const HomeScreen(food: false)));
}

void openDisplayFoodPost(BuildContext context, Food foodPost) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FoodPostDisplayScreen(foodPost: foodPost)));
}

void openSettings(BuildContext context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
}

void openMyProfile(BuildContext context, User user) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileScreen(
                user: user,
              )));
}
