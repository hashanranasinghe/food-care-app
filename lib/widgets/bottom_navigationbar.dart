import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_care/screens/chat_screen.dart';
import 'package:food_care/screens/forum_screen.dart';
import 'package:food_care/screens/home_screen.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/widgets/add_post_row.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);
  static const routName = 'bottom-nav-screen';

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 0;
  final screens = [
    const HomeScreen(food: true,),
    const ForumScreen(forum: true),
    const HomeScreen(food: true,),
    const ChatScreen(),
    const HomeScreen(food: true,)
  ];
  late final List<Widget> items;

  @override
  void initState() {
    super.initState();
    items = [
      Icon(
        Icons.home_outlined,
        size: 30,
        color: kPrimaryColorlight,
      ),
      Icon(
        Icons.forum_outlined,
        size: 30,
        color: kPrimaryColorlight,
      ),
      InkWell(
        onTap: () => _showAddModal(context),
        child: Icon(
          Icons.add,
          size: 30,
          color: kPrimaryColorlight,
        ),
      ),
      Icon(
        Icons.message_rounded,
        size: 30,
        color: kPrimaryColorlight,
      ),
      Icon(
        Icons.face_outlined,
        size: 30,
        color: kPrimaryColorlight,
      ),
    ];
  }

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
    return ClipRect(
      child: Scaffold(
        extendBody: true,
        body: screens[index],
        bottomNavigationBar: CurvedNavigationBar(
          buttonBackgroundColor: kPrimaryColordark,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          color: kBNavigationColordark,
          backgroundColor: Colors.transparent,
          index: index,
          height: 60,
          items: items,
          onTap: (index) {
            setState(() => this.index = index);
          },
        ),
      ),
    );
  }
}
