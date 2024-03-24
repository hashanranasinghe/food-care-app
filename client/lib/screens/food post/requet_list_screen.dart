import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/widgets/food%20post/tab%20view/accept_tab.dart';
import 'package:food_care/widgets/food%20post/tab%20view/request_tab.dart';
import 'package:provider/provider.dart';
import '../../view models/user view/userViewModel.dart';
import '../../widgets/food post/tab view/complete_tab.dart';

class RequestListScreen extends StatelessWidget {
  const RequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if (userViewModel.user == null) {
        userViewModel.getCurrentUser();
        return const Center(child: CircularProgressIndicator());
      }
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: kNavBarColor,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: kNavBarColor,
            title: Text(
              "Requests",
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
          body: TabBarView(
            children: [RequestTab(), AcceptTab(), CompleteTab()],
          ),
        ),
      );
    });
  }
}
