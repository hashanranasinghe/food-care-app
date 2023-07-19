import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_care/screens/intro/splash_screen.dart';
import 'package:food_care/screens/settings/settings_screen.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversastion_add_view_model.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversation_list_view_model.dart';
import 'package:food_care/view%20models/chat%20view/message/message_list_view_model.dart';
import 'package:food_care/view%20models/chat%20view/message/send_message_view_model.dart';
import 'package:food_care/view%20models/comment%20view%20model/comment_add_view_model.dart';
import 'package:food_care/view%20models/comment%20view%20model/comment_list_view_model.dart';
import 'package:food_care/view%20models/filter%20view/filter_provider.dart';

import 'package:food_care/view%20models/food%20post%20view/food_post_add_view_model.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_list_view_model.dart';
import 'package:food_care/view%20models/forum%20view/forum_add_view_model.dart';
import 'package:food_care/view%20models/forum%20view/forum_list-view_model.dart';
import 'package:food_care/view%20models/map_view/place_list_view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/view%20models/user%20view/user_list_view_model.dart';
import 'package:food_care/view%20models/user%20view/user_update_view_model.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();

  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FilterProvider()),
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
        ChangeNotifierProvider(create: (_) => PlaceListViewModel()),
      ],
      child: MyApp(
        initialLink: initialLink,
      )));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  // final ConversationViewModel vm = await ChatApiServices.getConversation(
  //     senderId: message.data["userId"], receiverId: message.data["receiverId"]);
  // openMessaging(
  //     context: navigatorKey.currentState!.context,
  //     receiverName: message.data["receiverName"],
  //     conversationId: message.data["conversationId"],
  //     conversationViewModel: vm,
  //     id: message.data["userId"]);
  Navigator.push(navigatorKey.currentState!.context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()));

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;
  const MyApp({Key? key, this.initialLink}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          fontFamily: "Poppins",
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          initialLink: widget.initialLink,
        ));
  }
}
