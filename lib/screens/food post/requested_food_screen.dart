import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../view models/food post view/food_post_list_view_model.dart';
import '../../view models/user view/userViewModel.dart';
import '../../view models/user view/user_list_view_model.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/food_post.dart';

class RequestedFoodScreen extends StatefulWidget {
  final String id;
  const RequestedFoodScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<RequestedFoodScreen> createState() => _RequestedFoodScreenState();
}

class _RequestedFoodScreenState extends State<RequestedFoodScreen> {
  String _locationMessage = '';
  late Position position;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
    _populateAllFoodPosts(widget.id);
  }
  void _populateAllFoodPosts(id) {
    print(id);
      Provider.of<FoodPostListViewModel>(context, listen: false)
          .getAllRequestedFoodPosts(id: id);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FoodPostListViewModel>(context);
    final um = Provider.of<UserListViewModel>(context);
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if (userViewModel.user == null) {
        userViewModel.getCurrentUser();
        return const Center(child: CircularProgressIndicator());
      } else {
        return AppBarWidget(
            text: "Requested Food",
            widget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: _updateUi(vm, userViewModel, um)),
                ],
              ),
            ));
      }
    });
  }

  Widget _updateUi(FoodPostListViewModel vm, UserViewModel userViewModel,
      UserListViewModel um) {
    switch (vm.status) {
      case Status.loading:
        return Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      case Status.success:
        return FoodPost(
          food: true,
          position: position,
          foods: vm.foods,
          userId: userViewModel.user!.id.toString(),
          users: um.users,
        );
      case Status.empty:
        return Align(
          alignment: Alignment.center,
          child: Text("No food post found...."),
        );
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
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
    }
    print(_locationMessage);
  }
}
