import 'package:flutter/material.dart';
import 'package:food_care/models/userModel.dart';
import 'package:food_care/services/api%20services/food_api_services.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';
import 'package:food_care/utils/config.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_list_view_model.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_view_model.dart';
import 'package:food_care/widgets/food%20post/food_card_request.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:food_care/utils/constraints.dart';

class RequestTab extends StatefulWidget {
  const RequestTab({
    super.key,
  });

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  late FoodPostListViewModel _foodPostListViewModel;
  @override
  void initState() {
    Provider.of<FoodPostListViewModel>(context, listen: false)
        .getAllRequestedFood();
    _foodPostListViewModel =
        Provider.of<FoodPostListViewModel>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FoodPostListViewModel>(context);
    Size size = MediaQuery.of(context).size;

    switch (vm.status) {
      case Status.loading:
        return Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      case Status.success:
        return Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: vm.requetedFoods.length,
                itemBuilder: (context, index) {
                  final foodPost = vm.requetedFoods[index];

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: foodPost.requests.length,
                    itemBuilder: (context, index) {
                      final requests = foodPost.requests[index];
                      return FutureBuilder<User>(
                        future: UserAPiServices.getUser(requests),
                        builder: (BuildContext context,
                            AsyncSnapshot<User> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              final user = snapshot.data!;
                              return FoodCardRequest(
                                permission: "PENDING",
                                user: user,
                                food: foodPost,
                                accept: () {
                                  accept(food: foodPost, user: user);
                                },
                                reject: () {
                                  reject(
                                      food: foodPost,
                                      user: user,
                                      context: context);
                                },
                              );
                            } else {
                              return Text("No user");
                            }
                          } else {
                            return Text("No user");
                          }
                        },
                      );
                    },
                  );
                })
          ],
        );
      case Status.empty:
        return Align(
          alignment: Alignment.center,
          child: Lottie.asset(nodataAnim, repeat: true, width: size.width),
        );
    }
  }

  reject(
      {required FoodPostViewModel food,
      required User user,
      required BuildContext context}) async {
    await FoodApiServices.permissionFoodPost(
        foodId: food.id.toString(),
        requesterId: user.uid.toString(),
        status: 'REJECT',
        path: Config.rejectFood);
    await UserAPiServices.foodRequest(
        state: "REJECT",
        foodId: food.id.toString(),
        userId: user.uid.toString(),
        path: Config.permission,
        complete: "NO");
    await _foodPostListViewModel.getAllRequestedFood();
    print("reject");
  }

  accept({required FoodPostViewModel food, required User user}) async {
    await FoodApiServices.permissionFoodPost(
        foodId: food.id.toString(),
        requesterId: user.uid.toString(),
        status: 'PENDING',
        path: Config.acceptFood);
    await UserAPiServices.foodRequest(
        state: "ACCEPT",
        foodId: food.id.toString(),
        userId: user.uid.toString(),
        path: Config.permission,
        complete: "NO");
    await _foodPostListViewModel.getAllRequestedFood();
    print("accept");
  }
}
