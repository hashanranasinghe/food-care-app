import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_care/screens/home_screen.dart';
import 'package:food_care/utils/constraints.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);
  static const routName = 'bottom-nav-screen';

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 0;
  final screens = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen()
  ];
  final items = const [
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
    Icon(
      Icons.add,
      size: 30,
      color: kPrimaryColorlight,
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
