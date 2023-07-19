import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/food_api_services.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/widgets/app_bar.dart';
import 'package:food_care/widgets/buttons.dart';
import 'package:food_care/widgets/filter_food.dart';
import 'package:food_care/widgets/food_post.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../view models/filter view/filter_provider.dart';
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
  Position? position;
  int filterCount = 0;
  bool? sort;
  late FilterProvider _filterProvider;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    _scaffoldKey = GlobalKey<ScaffoldState>();
    _populateAllFoodPosts();
    _getCurrentLocation();
    _loadFilter();
  }

  Future<void> _loadFilter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("sort") != null) {
      setState(() {
        sort = prefs.getBool('sort')!;
      });
    }
  }

  void _populateAllFoodPosts() {
    _filterProvider = Provider.of<FilterProvider>(context,listen: false);
    final filterFood = _filterProvider.filter;
    if(filterFood.sortByCloset != null || filterFood.sortByCloset ==false){
      setState(() {
        filterCount++;
      });
    }


    if (widget.food == true) {
      if(filterCount!=0){
        Provider.of<FoodPostListViewModel>(context, listen: false)
            .getAllFilterFoodPosts(filterFood);
      }else{
        Provider.of<FoodPostListViewModel>(context, listen: false)
            .getAllFoodPosts();
      }

    } else {
      Provider.of<FoodPostListViewModel>(context, listen: false)
          .getAllOwnFoodPosts();
    }
    searchController.addListener(() {
      setState(() {
        Provider.of<FoodPostListViewModel>(context, listen: false)
            .getSearchFood(query: searchController.text);
      });
    });

    Provider.of<UserListViewModel>(context, listen: false).getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FoodPostListViewModel>(context);
    final um = Provider.of<UserListViewModel>(context);
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if ((userViewModel.user == null) || (position == null)) {
        userViewModel.getCurrentUser();
        return const Center(child: CircularProgressIndicator());
      } else {
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
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const FilterFood();
                                  });
                            },
                            child: CircleAvatar(
                              backgroundImage: AssetImage(filter),
                              backgroundColor: Colors.transparent,
                              radius: 30.0,
                            ),
                          ),
                          Positioned(
                            top: 0.0,
                            right: 0.0,
                            child: CircleAvatar(
                                backgroundColor: kBNavigationColordark,
                                radius: 10.0,
                                child: Text(
                                  _filterProvider.filter.filterCount.toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                )),
                          ),
                        ],
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
                    Expanded(child: _updateUi(vm, userViewModel, um)),
                  ],
                ),
              ),
            ],
          ),
        );
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
          position: position!,
          foods: vm.foods,
          food: widget.food,
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
      controller: searchController,
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
            'Latitude: ${position!.latitude}, Longitude: ${position!.longitude}';
      });
    }
    print(_locationMessage);
  }
}
