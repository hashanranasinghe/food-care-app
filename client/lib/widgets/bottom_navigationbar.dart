import 'package:flutter/material.dart';
import 'package:food_care/screens/chat/chat_screen.dart';
import 'package:food_care/screens/forum/forum_screen.dart';
import 'package:food_care/screens/food%20post/home_screen.dart';
import 'package:food_care/screens/profile/profile_options.dart';
import 'package:food_care/screens/profile/profile_screen.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_care/widgets/add_post_row.dart';
import '../models/userModel.dart';

class BottomNavigation extends StatefulWidget {
  final User user;
  int index;
  BottomNavigation({Key? key, required this.user, this.index = 0})
      : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();

  void _showAddModal(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: 150,
            child: Column(
              children: [
                AddPostRow(
                    onpress: () {
                      openAddFoodPost(context);
                    },
                    icon: Icons.fastfood_rounded,
                    title: "Free",
                    subtitle: "Give away free food"),
                Divider(
                  thickness: 2,
                ),
                AddPostRow(
                    onpress: () {
                      openAddForum(context);
                    },
                    icon: Icons.forum_rounded,
                    title: "Forum",
                    subtitle: "Share your ideas"),
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kNavBarColor,
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddModal(context);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        color: Colors.white,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                      minWidth: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.house,
                            color: widget.index == 0
                                ? kNavItemsColor
                                : Colors.grey.shade500,
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                              color: widget.index == 0
                                  ? kNavItemsColor
                                  : Colors.grey.shade500,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          currentScreen = const HomeScreen();
                          widget.index = 0;
                        });
                      }),
                  MaterialButton(
                      minWidth: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dashboard_outlined,
                            color: widget.index == 1
                                ? kNavItemsColor
                                : Colors.grey.shade500,
                          ),
                          Text(
                            "Community",
                            style: TextStyle(
                              color: widget.index == 1
                                  ? kNavItemsColor
                                  : Colors.grey.shade500,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          currentScreen = const ForumScreen(forum: true);
                          widget.index = 1;
                        });
                      }),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                      minWidth: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.message_outlined,
                            color: widget.index == 2
                                ? kNavItemsColor
                                : Colors.grey.shade500,
                          ),
                          Text(
                            "Chat",
                            style: TextStyle(
                              color: widget.index == 2
                                  ? kNavItemsColor
                                  : Colors.grey.shade500,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          currentScreen = ChatScreen(
                            id: widget.user.id,
                          );
                          widget.index = 2;
                        });
                      }),
                  MaterialButton(
                      minWidth: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.face,
                            color: widget.index == 3
                                ? kNavItemsColor
                                : Colors.grey.shade500,
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: widget.index == 3
                                  ? kNavItemsColor
                                  : Colors.grey.shade500,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              ProfileOptionsScreen(user: widget.user);
                          widget.index = 3;
                        });
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
