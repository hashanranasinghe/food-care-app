import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/widgets/app_bar.dart';
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
    return AppBarWidget(
        text: "Hi Hashan",
        icon: Icons.notifications_none,
        widget: SingleChildScrollView(
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
                        onPressed: () {
                          _showAddModal(context);
                        },
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
              FoodPost(),
              FoodPost(),
              FoodPost()
            ],
          ),
        ));
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

  void _showAddModal(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(
                        "Food Filter",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.close))
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Text("Maximum Distance",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ColorChangeButton(
                          onpress: () {},
                          text: "All",
                          ptop: 5,
                          pbottom: 5,
                          pleft: 25,
                          pright: 25,
                        ),
                        ColorChangeButton(
                          onpress: () {},
                          text: "Available only",
                          ptop: 5,
                          pbottom: 5,
                          pleft: 25,
                          pright: 25,
                        ),
                        ColorChangeButton(
                          onpress: () {},
                          text: "Just Gone",
                          ptop: 5,
                          pbottom: 5,
                          pleft: 25,
                          pright: 25,
                        ),
                      ],
                    ),
                  ),
                  Text("Item Availability",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ColorChangeButton(
                          onpress: () {},
                          text: "All",
                          ptop: 5,
                          pbottom: 5,
                          pleft: 25,
                          pright: 25,
                        ),
                        ColorChangeButton(
                          onpress: () {},
                          text: "1 km",
                          ptop: 5,
                          pbottom: 5,
                          pleft: 25,
                          pright: 25,
                        ),
                        ColorChangeButton(
                          onpress: () {},
                          text: "2 km",
                          ptop: 5,
                          pbottom: 5,
                          pleft: 25,
                          pright: 25,
                        ),
                        ColorChangeButton(
                          onpress: () {},
                          text: "5 km",
                          ptop: 5,
                          pbottom: 5,
                          pleft: 25,
                          pright: 25,
                        ),
                        ColorChangeButton(
                          onpress: () {},
                          text: "10 km",
                          ptop: 5,
                          pbottom: 5,
                          pleft: 25,
                          pright: 25,
                        ),
                      ],
                    ),
                  ),
                  Text("Sort by",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  RadioButton(),
                  Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Genaralbutton(
                      pleft: 100,
                      pright: 100,
                      onpress: () {},
                      text: "Apply",
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
