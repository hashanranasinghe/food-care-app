import 'package:flutter/material.dart';
import 'package:food_care/models/forumModel.dart';
import 'package:food_care/screens/Ai%20chat/ai_chat_screen.dart';
import 'package:food_care/screens/food%20post/add_food_post_screen.dart';
import 'package:food_care/screens/food%20post/map_screen.dart';
import 'package:food_care/screens/food%20post/my_requests_list_screen.dart';
import 'package:food_care/screens/policies/faq.dart';
import 'package:food_care/screens/policies/privacy.dart';
import 'package:food_care/screens/policies/terms.dart';
import 'package:food_care/screens/profile/profile_options.dart';
import 'package:food_care/screens/report%20post/post_report_screen.dart';
import 'package:food_care/screens/food%20post/requested_food_screen.dart';
import 'package:food_care/screens/food%20post/requet_list_screen.dart';
import 'package:food_care/screens/forum/add_forum_screen.dart';
import 'package:food_care/screens/chat/chat_screen.dart';
import 'package:food_care/screens/food%20post/food_post_display_screen.dart';
import 'package:food_care/screens/forum/forum_screen.dart';
import 'package:food_care/screens/login%20&%20register/foget_password_screen.dart';
import 'package:food_care/screens/login%20&%20register/login_screen.dart';
import 'package:food_care/screens/chat/messaging_screen.dart';
import 'package:food_care/screens/login%20&%20register/reset_password_screen.dart';
import 'package:food_care/screens/onBoarding/onboarding.dart';
import 'package:food_care/screens/profile/my_post_screen.dart';

import 'package:food_care/screens/profile/profile_screen.dart';

import 'package:food_care/screens/login%20&%20register/signup_screen.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversation_view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/widgets/bottom_navigationbar.dart';
import 'package:geolocator/geolocator.dart';
import '../models/foodPostModel.dart';
import '../models/userModel.dart';

void openUserSignUp(BuildContext context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignupScreen()));
}

void openOnBoard(BuildContext context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));
}

void openUserSignIn(BuildContext context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const LoginScreen()));
}

void openHome(BuildContext context, User user, int index) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BottomNavigation(
                index: index,
                user: user,
              )));
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
    {required BuildContext context,
    required String receiverName,
    required String conversationId,
    required ConversationViewModel conversationViewModel,
    required String id}) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MessagingScreen(
                receiverName: receiverName,
                conversationId: conversationId,
                conversationViewModel: conversationViewModel,
                id: id,
              )));
}

void openDisplayFoodPost(
    BuildContext context, String foodId, String id, Position position) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FoodPostDisplayScreen(
                foodId: foodId,
                id: id,
                position: position,
              )));
}

void openMyProfile(BuildContext context, User user) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileScreen(
                user: user,
              )));
}

void openForget(BuildContext context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()));
}

void openMap(BuildContext context, Location location) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => MapScreen(location: location)));
}

void openReset(BuildContext context, String token) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(
                token: token,
              )));
}

void openRequestedFood(BuildContext context, String id) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RequestedFoodScreen(
                id: id,
              )));
}

void openRequestList(BuildContext context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const RequestListScreen()));
}

void openMyRequestList(
    BuildContext context, UserViewModel userViewModel) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyRequestsLitScreen(
                userViewModel: userViewModel,
              )));
}

void openReport(BuildContext context, String id, String type) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PostReportScreen(
                id: id,
                type: type,
              )));
}

void openMyPosts(BuildContext context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MyPostsScreen()));
}

void openFaq(BuildContext context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => FAQScreen()));
}

void openTerms(BuildContext context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => TermsAndConditionsScreen()));
}

void openPrivacy(BuildContext context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
}

void openAi(BuildContext context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => AIChatView()));
}


void openProfile(BuildContext context, User user) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileOptionsScreen(
                user: user,
              )));
}
