import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/widgets/app_bar.dart';
import 'package:food_care/widgets/setting_tile.dart';
import 'package:provider/provider.dart';

import '../models/userModel.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if (userViewModel.user == null) {
        userViewModel.getCurrentUser();
        return const Center(child: CircularProgressIndicator());
      } else {
        return AppBarWidget(
            text: "Settings",
            widget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SettingTile(
                    title: 'Change Account Details',
                    icon: CupertinoIcons.profile_circled,
                    function: () async{
                      final User user = await UserAPiServices.getUser(userViewModel.user!.id.toString());
                      user.id = userViewModel.user!.id;

                      openMyProfile(context,user);
                    },
                  )
                ],
              ),
            ));
      }
    });
  }
}
