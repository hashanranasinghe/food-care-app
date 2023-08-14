import 'package:flutter/material.dart';
import 'package:food_care/services/store_token.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/widgets/popup_dialog.dart';
import 'package:provider/provider.dart';
import '../services/navigations.dart';
import '../utils/config.dart';
import '../utils/constraints.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if (userViewModel.user == null) {
        userViewModel.getCurrentUser();
        return const Center(child: CircularProgressIndicator());
      } else {
        return Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 230,
                  child: UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(color: kPrimaryColorDark),
                    accountName: Text(
                      userViewModel.user!.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    accountEmail: Text(
                      userViewModel.user!.email,
                      style: TextStyle(color: Colors.white),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: userViewModel.user!.imageUrl == null
                          ? AssetImage(icon)
                          : NetworkImage(Config.imageUrl(
                              imageUrl: userViewModel.user!.imageUrl
                                  .toString())) as ImageProvider<Object>,
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    leading: const Icon(
                      Icons.home_outlined,
                      color: kPrimaryColorDark,
                    ),
                    title: const Text('Home'),
                    onTap: () async {
                      openHome(context, userViewModel.user!,0);
                    },
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                      leading: const Icon(
                        Icons.emoji_food_beverage_outlined,
                        color: kPrimaryColorDark,
                      ),
                      title: const Text('My Food Posts'),
                      onTap: () {
                        openOwnFoodPosts(context);
                      }),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                      leading: const Icon(
                        Icons.emoji_food_beverage_outlined,
                        color: kPrimaryColorDark,
                      ),
                      title: const Text('Requested food'),
                      onTap: () {
                        openRequestedFood(context,userViewModel.user!.id.toString());
                      }),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                      leading: const Icon(
                        Icons.forum_outlined,
                        color: kPrimaryColorDark,
                      ),
                      title: const Text('My Forums'),
                      onTap: () {
                        openOwnForums(context);
                      }),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                      leading: const Icon(
                        Icons.message,
                        color: kPrimaryColorDark,
                      ),
                      title: const Text('Message'),
                      onTap: () async {
                        openChats(context, userViewModel.user!.id.toString());
                      }),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                      leading: const Icon(
                        Icons.notifications_none,
                        color: kPrimaryColorDark,
                      ),
                      title: const Text('Notifications'),
                      onTap: () {
                        openRequestList(context);
                      }),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout_rounded,
                      color: kPrimaryColorDark,
                    ),
                    title: const Text('Logout'),
                    onTap: () {
                      PopupDialog.showPopuplogout(
                          context, "Logout", "Do you want to Logout ? ",
                          () async {
                        await StoreToken.removeToken();
                        userViewModel.clearUser();
                        var token = await StoreToken.getToken();
                        if (token == null) {
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
    });
  }
}
