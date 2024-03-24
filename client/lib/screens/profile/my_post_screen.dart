import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/widgets/post%20tab/food_tab.dart';
import 'package:food_care/widgets/post%20tab/forum_tab.dart';
import 'package:provider/provider.dart';
import '../../view models/user view/userViewModel.dart';

class MyPostsScreen extends StatefulWidget {
  const MyPostsScreen({super.key});

  @override
  State<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if (userViewModel.user == null) {
        userViewModel.getCurrentUser();
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: kNavBarColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: kNavBarColor,
            title: Text(
              "My Posts",
              style: TextStyle(color: Colors.black),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            bottom: TabBar(
              indicatorPadding:
                  EdgeInsets.symmetric(horizontal: size.width * 0.01),
              tabs: [
                Tab(
                  text: "Food Posts",
                ),
                Tab(
                  text: "Community Posts",
                ),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicatorColor: kPrimaryColorDark,
              indicator: BoxDecoration(
                  color: kPrimaryColorDark,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          body: TabBarView(
            children: [
              MyFoods(userViewModel: userViewModel),
              MyForums(userViewModel: userViewModel)
            ],
          ),
        ),
      );
    });
  }
}
