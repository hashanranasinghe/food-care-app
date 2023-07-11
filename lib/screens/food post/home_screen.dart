import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/food_api_services.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/widgets/app_bar.dart';
import 'package:food_care/widgets/buttons.dart';
import 'package:food_care/widgets/food_post.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../view models/food post view/food_post_list_view_model.dart';
import '../../view models/user view/userViewModel.dart';
import '../../view models/user view/user_list_view_model.dart';

class HomeScreen extends StatefulWidget {
  final bool food;
  const HomeScreen({Key? key, required this.food}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  String _locationMessage = '';
  late Position position;
  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _populateAllFoodPosts();
    _getCurrentLocation();
  }

  void _populateAllFoodPosts() {
    if (widget.food == true) {
      Provider.of<FoodPostListViewModel>(context, listen: false)
          .getAllFoodPosts();
    } else {
      Provider.of<FoodPostListViewModel>(context, listen: false)
          .getAllOwnFoodPosts();
    }
    Provider.of<UserListViewModel>(context, listen: false).getAllUsers();
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
        print(userViewModel.user!.name);
        return AppBarWidget(
          text: "Hi ${userViewModel.user!.name}",
          icon: Icons.notifications_none,
          widget: Column(
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
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ColorChangeButton(
                            onpress: () async {
                              await FoodApiServices.getFoodPosts();
                            },
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
                    Expanded(child: _updateUi(vm, userViewModel,um)),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  Widget _updateUi(FoodPostListViewModel vm, UserViewModel userViewModel,UserListViewModel um) {
    switch (vm.status) {
      case Status.loading:
        return Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      case Status.success:
        return FoodPost(
          position: position,
          foods: vm.foods,
          food: widget.food,
          userId: userViewModel.user!.id.toString(), users: um.users,
        );
      case Status.empty:
        return Align(
          alignment: Alignment.center,
          child: Text("No food post found...."),
        );
    }
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
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close))
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
