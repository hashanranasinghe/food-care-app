import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/widgets/food%20post/my%20tab%20view/accept_tab.dart';
import 'package:food_care/widgets/food%20post/my%20tab%20view/complete_tab.dart';
import 'package:food_care/widgets/food%20post/my%20tab%20view/request_tab.dart';

class MyRequestsLitScreen extends StatelessWidget {
  UserViewModel userViewModel;
  MyRequestsLitScreen({super.key, required this.userViewModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: kNavBarColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: kNavBarColor,
          title: Text(
            "My Requests",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Requests",
              ),
              Tab(
                text: "Accept",
              ),
              Tab(
                text: "Complete",
              )
            ],
            indicatorPadding:
                EdgeInsets.symmetric(horizontal: size.width * 0.01),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicatorColor: kPrimaryColorDark,
            indicator: BoxDecoration(
                color: kPrimaryColorDark,
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
        body: const TabBarView(
          children: [MyRequestTab(), MyAcceptTab(), MyCompleteTab()],
        ),
      ),
    );
  }
}
