import 'package:flutter/material.dart';
import 'package:food_care/widgets/app_bar.dart';
import 'package:food_care/widgets/forum_post.dart';
import 'package:provider/provider.dart';
import '../view models/forum view/forum_list-view_model.dart';
import '../view models/userViewModel.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late UserViewModel _userViewModel;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    _populateAllForums();
  }

  void _populateAllForums() {
    Provider.of<ForumListViewModel>(context, listen: false).getAllForums();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
        builder: (context, userViewModel, child) {
          final vm = Provider.of<ForumListViewModel>(context);
          print(userViewModel.user!.id);
          return AppBarWidget(
            text: "Forum",
            widget: _updateUi(vm,userViewModel),
          );
        });
  }

  Widget _updateUi(ForumListViewModel vm,user) {
    switch (vm.status) {
      case Status.loading:
        return Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      case Status.success:
        return ForumPost(forums: vm.forums, comment: () {},user: user,);
      case Status.empty:
        return Align(
          alignment: Alignment.center,
          child: Text("No foru found...."),
        );
    }
  }
}