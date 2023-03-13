import 'package:flutter/material.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_list_view_model.dart';
import 'package:food_care/widgets/get_user_image.dart';
import 'package:food_care/widgets/show_time_ago_row.dart';
import 'package:food_care/widgets/updateNdelete.dart';
import 'package:provider/provider.dart';
import '../models/foodPostModel.dart';
import '../models/userModel.dart';
import '../services/api services/food_api_services.dart';
import '../services/date.dart';
import '../utils/config.dart';
import '../view models/food post view/food_post_view_model.dart';

class FoodPost extends StatefulWidget {
  final bool? food;
  final List<FoodPostViewModel> foods;
  const FoodPost({Key? key, required this.foods, this.food}) : super(key: key);

  @override
  State<FoodPost> createState() => _FoodPostState();
}

class _FoodPostState extends State<FoodPost> {
  late FoodPostListViewModel _foodPostListViewModel;
  late User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _foodPostListViewModel =
        Provider.of<FoodPostListViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.foods.length,
          itemBuilder: (context, index) {
            final food = widget.foods[index];
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Stack(children: [
                Card(
                  color: kSecondColorDark,
                  elevation: 10,
                  margin: EdgeInsets.only(top: 48, left: 15, right: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 50, bottom: 10),
                              child: Text(
                                food.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  height: 1.5,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_rounded,
                                      size: 15,
                                    ),
                                    Text(
                                      "4 km",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Icon(
                                        Icons.circle,
                                        size: 5,
                                      ),
                                    ),
                                    ShowTimeAgoRow(time: food.updatedAt),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 3,
                        height: 190,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                      radius: 10.0,
                                      backgroundColor: Colors.transparent,
                                      child: GetUserImage(
                                          id: food.userId.toString())),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      food.author.toString(),
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pick up Times",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      height: 1.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      food.pickupTimes.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.5,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "List for Days",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      height: 1.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      food.listDays.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.5,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (widget.food == true) ...[
                                        IconButton(
                                            onPressed: () async {
                                              print("ok");
                                              final Food foodPost = await FoodApiServices.getFoodPost(foodId: food.id.toString());
                                              print(foodPost.author);
                                              openDisplayFoodPost(context,foodPost);
                                            },
                                            icon: Icon(Icons
                                                .arrow_circle_right_outlined))
                                      ] else ...[
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return UpdateNDelete(
                                                      update: () async {
                                                    final getFood =
                                                        await FoodApiServices
                                                            .getOwnFoodPost(
                                                                foodId: food.id
                                                                    .toString());
                                                    print(getFood.listDays);
                                                    openUpdateFoodPost(context, getFood);
                                                    openUpdateFoodPost(context, getFood);
                                                  }, delete: () async {
                                                    print("ok");
                                                    await FoodApiServices
                                                        .deleteFoodPost(
                                                            foodId: food.id
                                                                .toString());
                                                    Provider.of<FoodPostListViewModel>(
                                                            context,
                                                            listen: false)
                                                        .getAllOwnFoodPosts();
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              );
                                            },
                                            icon: Icon(Icons
                                                .arrow_circle_right_outlined))
                                      ]
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
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
                            backgroundColor: kPrimaryColorlight,
                            backgroundImage: food.imageUrls.length == 0
                                ? AssetImage('assets/images/food.jpg')
                                : NetworkImage(Config.imageUrl(
                                        imageUrl: food.imageUrls[0].toString()))
                                    as ImageProvider<Object>,
                          ),
                        ),
                      )),
                ),
              ]),
            );
          }),
    );
  }
}
