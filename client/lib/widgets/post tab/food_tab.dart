import 'package:flutter/material.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_list_view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/view%20models/user%20view/user_list_view_model.dart';
import 'package:food_care/widgets/food%20post/food_post.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:food_care/utils/constraints.dart';

class MyFoods extends StatefulWidget {
  final UserViewModel userViewModel;

  const MyFoods({
    super.key,
    required this.userViewModel,
  });

  @override
  State<MyFoods> createState() => _MyFoodsState();
}

class _MyFoodsState extends State<MyFoods> {
  Position? position;
  String _locationMessage = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        if (mounted) {
    _getCurrentLocation();
    Provider.of<FoodPostListViewModel>(context, listen: false)
        .getAllOwnFoodPosts();

    Provider.of<UserListViewModel>(context, listen: false).getAllUsers();}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final vm = Provider.of<FoodPostListViewModel>(context);
    final um = Provider.of<UserListViewModel>(context);
    if (position == null) {
      return Center(child: const CircularProgressIndicator());
    } else {
      switch (vm.status) {
        case Status.loading:
          return Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        case Status.success:
          return FoodPost(
            position: position!,
            foods: vm.ownFoods,
            food: false,
            userId: widget.userViewModel.user!.id.toString(),
            users: um.users,
          );
        case Status.empty:
          return Align(
            alignment: Alignment.center,
            child: Lottie.asset(nodataAnim, repeat: true, width: size.width),
          );
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      setState(() {
        _locationMessage = 'Location permissions denied';
      });
    } else {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _locationMessage =
            'Latitude: ${position!.latitude}, Longitude: ${position!.longitude}';
      });
    }
    print(_locationMessage);
  }
}
