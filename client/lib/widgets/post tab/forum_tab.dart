import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/forum%20view/forum_list-view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/view%20models/user%20view/user_list_view_model.dart';
import 'package:food_care/widgets/forum_post.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class MyForums extends StatefulWidget {
  final UserViewModel userViewModel;

  const MyForums({
    super.key,
    required this.userViewModel,
  });

  @override
  State<MyForums> createState() => _MyForumsState();
}

class _MyForumsState extends State<MyForums> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ForumListViewModel>(context, listen: false).getOwnAllForums();

    Provider.of<UserListViewModel>(context, listen: false).getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ForumListViewModel>(context);
    Size size = MediaQuery.of(context).size;
    final um = Provider.of<UserListViewModel>(context);
    switch (vm.status) {
      case Status.loading:
        return Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      case Status.success:
        return ForumPost(
          forums: vm.ownForums,
          comment: () {},
          user: widget.userViewModel,
          own: false,
          userList: um.users,
        );
      case Status.empty:
        return Align(
          alignment: Alignment.center,
          child: Lottie.asset(nodataAnim, repeat: true, width: size.width),
        );
    }
  }
}
