import 'package:flutter/material.dart';
import 'package:food_care/screens/splash_screen.dart';
import 'package:food_care/view%20models/comment%20view%20model/comment_add_view_model.dart';
import 'package:food_care/view%20models/comment%20view%20model/comment_list_view_model.dart';
import 'package:food_care/view%20models/forum%20view/forum_add_view_model.dart';
import 'package:food_care/view%20models/forum%20view/forum_list-view_model.dart';
import 'package:food_care/view%20models/userViewModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => ForumListViewModel()),
        ChangeNotifierProvider(create: (_) => AddForumViewModel()),
        ChangeNotifierProvider(create: (_) => CommentListViewModel()),
        ChangeNotifierProvider(create: (_) => CommentAddViewModel()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Poppins"),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
