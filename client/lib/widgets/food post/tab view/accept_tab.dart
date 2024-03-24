import 'package:flutter/material.dart';
import 'package:food_care/models/userModel.dart';
import 'package:food_care/services/api%20services/food_api_services.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';
import 'package:food_care/utils/config.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_list_view_model.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_view_model.dart';
import 'package:food_care/widgets/food%20post/food_card.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:food_care/utils/constraints.dart';
class AcceptTab extends StatefulWidget {
  const AcceptTab({super.key});

  @override
  State<AcceptTab> createState() => _AcceptTabState();
}

class _AcceptTabState extends State<AcceptTab> {
  late FoodPostListViewModel _foodPostListViewModel;
  @override
  void initState() {
    Provider.of<FoodPostListViewModel>(context, listen: false)
        .getAcceptFoodPosts();
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
                itemCount: vm.acceptedFoods.length,
                itemBuilder: (context, index) {
                  final foodPost = vm.acceptedFoods[index];
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: foodPost.acceptRequest.length,
                    itemBuilder: (context, index) {
                      final acceptRequests = foodPost.acceptRequest[index];
                      return FutureBuilder<User>(
                        future:
                            UserAPiServices.getUser(acceptRequests.requesterId),
                        builder: (BuildContext context,
                            AsyncSnapshot<User> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              final user = snapshot.data!;
                              return FoodCard(
                                comp: "NO",
                                  user: user,
                                  food: foodPost,
                                  complete: () {
                                    continuingFoodPost(
                                        food: foodPost, user: user);
                                  });
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

  continuingFoodPost(
      {required FoodPostViewModel food, required User user}) async {
    await FoodApiServices.permissionFoodPost(
        foodId: food.id.toString(),
        requesterId: user.uid.toString(),
        status: 'COMPLETE',
        path: Config.completeDonation);
    await UserAPiServices.foodRequest(
        state: "ACCEPT",
        foodId: food.id.toString(),
        userId: user.uid.toString(),
        path: Config.permission,
        complete: "COMPLETE");
    await _foodPostListViewModel.getAcceptFoodPosts();
    print("complete");
  }
}
