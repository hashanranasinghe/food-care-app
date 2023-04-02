import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:food_care/screens/intro/splash_screen.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversastion_add_view_model.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversation_list_view_model.dart';
import 'package:food_care/view%20models/chat%20view/message/message_list_view_model.dart';
import 'package:food_care/view%20models/chat%20view/message/send_message_view_model.dart';
import 'package:food_care/view%20models/comment%20view%20model/comment_add_view_model.dart';
import 'package:food_care/view%20models/comment%20view%20model/comment_list_view_model.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_add_view_model.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_list_view_model.dart';
import 'package:food_care/view%20models/forum%20view/forum_add_view_model.dart';
import 'package:food_care/view%20models/forum%20view/forum_list-view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/view%20models/user%20view/user_list_view_model.dart';
import 'package:food_care/view%20models/user%20view/user_update_view_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => ForumListViewModel()),
        ChangeNotifierProvider(create: (_) => AddForumViewModel()),
        ChangeNotifierProvider(create: (_) => CommentListViewModel()),
        ChangeNotifierProvider(create: (_) => CommentAddViewModel()),
        ChangeNotifierProvider(create: (_) => FoodPostListViewModel()),
        ChangeNotifierProvider(create: (_) => FoodPostAddViewModel()),
        ChangeNotifierProvider(create: (_) => UserListViewModel()),
        ChangeNotifierProvider(create: (_) => UserUpdateViewModel()),
        ChangeNotifierProvider(create: (_) => ChatListViewModel()),
        ChangeNotifierProvider(create: (_) => MessageListViewModel()),
        ChangeNotifierProvider(create: (_) => SendMessageViewModel()),
        ChangeNotifierProvider(create: (_) => ConversationAddViewModel()),
      ],
      child: MyApp(
        initialLink: initialLink,
      )));
}

class MyApp extends StatelessWidget {
  final PendingDynamicLinkData? initialLink;
  const MyApp({Key? key, this.initialLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: "Poppins",
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          initialLink: initialLink,
        ));
  }
}
