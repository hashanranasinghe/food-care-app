import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/widgets/buttons.dart';
import 'package:food_care/widgets/food_post.dart';

import '../widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey, // set the key to the scaffold
      drawer: MenuDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Hi Hashan",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState
                ?.openDrawer(); // use the current state of the key to open the drawer
          },
          icon: Icon(
            Icons.menu_rounded,
            color: Colors.black,
            size: 35,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon:
                  Icon(Icons.notifications_none, color: Colors.black, size: 35))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 300, child: _buildSearchBar()),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        size: 35,
                      )),
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColorChangeButton(
                    onpress: () {},
                    pleft: 30,
                    pright: 30,
                    pbottom: 15,
                    ptop: 15,
                    text: "Nearby",
                    fontsize: 20,
                  ),
                  ColorChangeButton(
                    onpress: () {},
                    pleft: 30,
                    pright: 30,
                    pbottom: 15,
                    ptop: 15,
                    text: "Top Rated",
                    fontsize: 20,
                  ),
                  ColorChangeButton(
                    onpress: () {},
                    pleft: 30,
                    pright: 30,
                    pbottom: 15,
                    ptop: 15,
                    text: "Quick",
                    fontsize: 20,
                  ),
                ],
              ),
            ),
            FoodPost()
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return CupertinoSearchTextField(
      padding: EdgeInsets.symmetric(vertical: 15),
      prefixInsets: EdgeInsets.only(left: 20, right: 10),
      itemSize: 25,
      onChanged: (value) {
        setState(() {});
      },
      style: TextStyle(fontSize: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kSecondColorlight,
      ),
    );
  }
}
