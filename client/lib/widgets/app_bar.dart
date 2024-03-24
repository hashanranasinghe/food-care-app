import 'package:flutter/material.dart';

import '../utils/constraints.dart';
import 'drawer.dart';

class AppBarWidget extends StatefulWidget {
  final String text;
  final Widget widget;
  final IconData? icon;

  const AppBarWidget(
      {Key? key, required this.text, required this.widget, this.icon})
      : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNavBarColor,
      key: _scaffoldKey, // set the key to the scaffold
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: Text(
          widget.text,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
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
              icon: Icon(widget.icon, color: Colors.black, size: 35))
        ],
      ),
      body: widget.widget,
    );
  }
}
