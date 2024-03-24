import 'package:flutter/material.dart';
import 'package:food_care/models/userModel.dart';
import 'package:food_care/services/api%20services/food_api_services.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';
import 'package:food_care/utils/config.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_list_view_model.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_view_model.dart';
import 'package:food_care/widgets/food%20post/my_food_request.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:food_care/utils/constraints.dart';
class MyRequestTab extends StatefulWidget {
  const MyRequestTab({
    super.key,
  });

  @override
  State<MyRequestTab> createState() => _MyRequestTabState();
}

class _MyRequestTabState extends State<MyRequestTab> {
  late FoodPostListViewModel _foodPostListViewModel;
  @override
  void initState() {
    Provider.of<FoodPostListViewModel>(context, listen: false)
        .getAllMyRequestedFood();
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
                itemCount: vm.requetedMyFoods.length,
                itemBuilder: (context, index) {
                  final foodPost = vm.requetedMyFoods[index];

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
                              return MyFoodCardRequest(
                                user: user,
                                food: foodPost,
                                cancel: () {
                                  cancel(
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

  cancel(
      {required FoodPostViewModel food,
      required User user,
      required BuildContext context}) async {
    int res = await FoodApiServices.requestFoodPost(
        foodId: food.id.toString(), requesterId: '');

    await UserAPiServices.foodRequest(
        state: "PENDING",
        complete: "NO",
        path: Config.request,
        foodId: food.id.toString(),
        userId: user.uid.toString());
  }
}
