import 'package:flutter/material.dart';

import '../models/userModel.dart';
import '../services/api services/user_api_services.dart';
import '../utils/config.dart';
import '../utils/constraints.dart';

class GetUserImage extends StatelessWidget {
  final String id;
  final double radius;
  const GetUserImage({Key? key, required this.id, this.radius = 20.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return FutureBuilder<User>(
      future: UserAPiServices.getUser(id),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return CircleAvatar(
              radius: radius,
              backgroundColor: kPrimaryColorLight,
              backgroundImage: user.imageUrl == null || user.imageUrl == ""
                  ? const AssetImage(userIcon)
                  : NetworkImage(
                          Config.imageUrl(imageUrl: user.imageUrl.toString()))
                      as ImageProvider<Object>,
            );
          } else {
            return Image(
              image: AssetImage(userIcon),
              width: screenSize.width * 0.15,
            );
          }
        } else {
          return Image(
            image: AssetImage(userIcon),
            width: screenSize.width * 0.15,
          );
        }
      },
    );
  }
}
