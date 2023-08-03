import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_care/models/foodPostModel.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_add_view_model.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_list_view_model.dart';
import 'package:food_care/widgets/buttons.dart';
import 'package:food_care/widgets/category_card.dart';
import 'package:food_care/widgets/food_post_detail_row.dart';
import 'package:food_care/widgets/popup_dialog.dart';
import 'package:food_care/widgets/updateNdelete.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../models/userModel.dart';
import '../services/api services/food_api_services.dart';
import '../utils/config.dart';
import '../utils/covertor.dart';
import '../view models/food post view/food_post_view_model.dart';
import '../view models/user view/user_view.dart';
import 'flutter_toast.dart';

class FoodPost extends StatefulWidget {
  final bool? food;
  final List<FoodPostViewModel> foods;
  final String userId;
  final List<UserView> users;
  final Position position;
  const FoodPost(
      {Key? key,
      required this.foods,
      this.food,
      required this.userId,
      required this.users,
      required this.position})
      : super(key: key);

  @override
  State<FoodPost> createState() => _FoodPostState();
}

class _FoodPostState extends State<FoodPost> {
  late FoodPostListViewModel foodPostListViewModel;
  late FoodPostAddViewModel foodPostAddViewModel;
  @override
  void initState() {
    super.initState();
    foodPostAddViewModel =
        Provider.of<FoodPostAddViewModel>(context, listen: false);
    foodPostListViewModel =
        Provider.of<FoodPostListViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.foods.length,
          itemBuilder: (context, index) {
            final food = widget.foods[index];
            final user =
                widget.users.firstWhere((user) => user.uid == food.userId);
            return Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.03,
                  right: screenSize.width * 0.03,
                  top: 15),
              child: GestureDetector(
                onTap: () async {
                  openDisplayFoodPost(
                      context, food.id.toString(), widget.userId);
                },
                child: Stack(children: [
                  Card(
                    color: Colors.white,
                    elevation: 10,
                    margin: EdgeInsets.only(top: 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SizedBox(
                      height: screenSize.height * 0.22,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: screenSize.height * 0.1,
                                  ),
                                  child: Text(
                                    Convertor.upperCase(text: food.title),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      height: 1.5,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                CategoryCard(text: Convertor.upperCase(text: food.category))
                              ],
                            ),
                          ),
                          Container(
                            width: screenSize.width * 0.005,
                            height: screenSize.height * 0.19,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kNavBarColor,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenSize.height * 0.02,
                                        bottom: screenSize.height * 0.01),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: kPrimaryColorLight,
                                          radius: 15,
                                          backgroundImage: user.imageUrl == null
                                              ? AssetImage(userIcon.toString())
                                              : NetworkImage(Config.imageUrl(
                                                      imageUrl: user.imageUrl
                                                          .toString()))
                                                  as ImageProvider<Object>,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  Convertor.upperCase(
                                                      text: food.author
                                                          .toString()),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15)),
                                              Text(
                                                Convertor.getDate(
                                                    date: food.createdAt),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black38),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FoodPostDetailRow(
                                      text: food.availableTime.endTime,
                                      topicIcon: Icons.timer_sharp,
                                      topic: "End TIme"),
                                  FoodPostDetailRow(
                                      text:
                                          "${getDifferenceLocation(widget.position, food.location).toString()} Km",
                                      topicIcon: Icons.location_on_outlined,
                                      topic: "Distance"),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          child: CircleAvatar(
                            radius: 70.0,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 78.0,
                              backgroundColor: kPrimaryColorLight,
                              backgroundImage: food.imageUrls.length == 0
                                  ? AssetImage('assets/images/food.jpg')
                                  : NetworkImage(Config.imageUrl(
                                          imageUrl:
                                              food.imageUrls[0].toString()))
                                      as ImageProvider<Object>,
                            ),
                          ),
                        )),
                  ),
                ]),
              ),
            );
          }),
    );
  }

  double getDifferenceLocation(
      Position currentPosition, Location foodLocation) {
    double distanceInMeters = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      double.parse(foodLocation.lan),
      double.parse(foodLocation.lon),
    );

    double distanceInKilometers = distanceInMeters / 1000;
    double roundedDistance =
        double.parse(distanceInKilometers.toStringAsFixed(1));
    return roundedDistance;
  }
}
