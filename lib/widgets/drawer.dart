import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/food_api_services.dart';
import 'package:food_care/services/store_token.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';
import 'package:food_care/widgets/popup_dialog.dart';

import '../services/navigations.dart';
import '../utils/constraints.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 230,
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: kPrimaryColorlight),
                accountName: const Text("Hashan Ranasinghe",style: TextStyle(
                    color: kPrimaryColordark
                ),),
                accountEmail: Text("test@gmail.com",style: TextStyle(
                  color: kPrimaryColordark
                ),),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/icon.png"),
                ),

              ),
            ),

            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.home_outlined,
                  color: kPrimaryColordark,
                ),
                title: const Text('Home'),
                onTap: () async {
                  FoodApiServices.getFoodPosts();
                },
              ),
            ),

            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.filter_alt_outlined,
                  color: kPrimaryColordark,
                ),
                title: const Text('Filter'),
                onTap: () async {

                },
              ),
            ),
            // : Container(),
            Card(
              elevation: 0,
              child: ListTile(
                  leading: const Icon(
                    Icons.message,
                    color: kPrimaryColordark,
                  ),
                  title: const Text('Message'),
                  onTap: () {}),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                  leading: const Icon(
                    Icons.forum_outlined,
                    color: kPrimaryColordark,
                  ),
                  title: const Text('My Post'),
                  onTap: () {
                    openOwnForums(context);
                  }),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                  leading: const Icon(
                    Icons.notifications_none,
                    color: kPrimaryColordark,
                  ),
                  title: const Text('Notifications'),
                  onTap: () {

                  }),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                  leading: const Icon(
                    Icons.settings_outlined,
                    color: kPrimaryColordark,
                  ),
                  title: const Text('Settings'),
                  onTap: () {
                    UserAPiServices.getCurrentUser();
                  }),
            ),

            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: kPrimaryColordark,
                ),
                title: const Text('Logout'),
                onTap: () {
                  PopupDialog.showPopuplogout(context, "Logout",
                      "Do you want to Logout ? ", () async {
                    await StoreToken.removeToken();
                    var token = await StoreToken.getToken();
                    if(token ==null){
                      openUserSignIn(context);
                    }
                      });
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
