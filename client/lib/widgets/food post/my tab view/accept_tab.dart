import 'package:flutter/material.dart';

import 'package:food_care/models/userModel.dart';

import 'package:food_care/services/api%20services/user_api_services.dart';

import 'package:food_care/view%20models/food%20post%20view/food_post_list_view_model.dart';

import 'package:food_care/widgets/food%20post/my_food_accept.dart';

import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:food_care/utils/constraints.dart';
class MyAcceptTab extends StatefulWidget {
  const MyAcceptTab({
    super.key,
  });

  @override
  State<MyAcceptTab> createState() => _MyAcceptTabState();
}

class _MyAcceptTabState extends State<MyAcceptTab> {
  late FoodPostListViewModel _foodPostListViewModel;
  @override
  void initState() {
    Provider.of<FoodPostListViewModel>(context, listen: false)
        .getMyAcceptFoodPosts();
    _foodPostListViewModel =
        Provider.of<FoodPostListViewModel>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
          Size size = MediaQuery.of(context).size;

    final vm = Provider.of<FoodPostListViewModel>(context);
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
                itemCount: vm.acceptedMyFoods.length,
                itemBuilder: (context, index) {
                  final foodPost = vm.acceptedMyFoods[index];
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: foodPost.acceptRequest.length,
                    itemBuilder: (context, index) {
                      final acceptRequests = foodPost.acceptRequest[index];
                    print(foodPost.acceptRequest.length);
                      return FutureBuilder<User>(
                        future:
                            UserAPiServices.getUser(acceptRequests.requesterId),
                        builder: (BuildContext context,
                            AsyncSnapshot<User> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              final user = snapshot.data!;
                              return MyFoodCard(
                                user: user,
                                food: foodPost,
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
}
