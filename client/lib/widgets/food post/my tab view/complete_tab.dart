import 'package:flutter/material.dart';
import 'package:food_care/models/userModel.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_list_view_model.dart';
import 'package:food_care/widgets/food%20post/food_card.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:food_care/utils/constraints.dart';
class MyCompleteTab extends StatefulWidget {
  const MyCompleteTab({super.key});

  @override
  State<MyCompleteTab> createState() => _MyCompleteTabState();
}

class _MyCompleteTabState extends State<MyCompleteTab> {
  late FoodPostListViewModel _foodPostListViewModel;
  @override
  void initState() {
    Provider.of<FoodPostListViewModel>(context, listen: false)
        .getMyCompleteFoodPosts();
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
        return ListView.builder(
            shrinkWrap: true,
            itemCount: vm.completedMyFoods.length,
            itemBuilder: (context, index) {
              final foodPost = vm.completedMyFoods[index];
              return ListView.builder(
                shrinkWrap: true,
                itemCount: foodPost.acceptRequest.length,
                itemBuilder: (context, index) {
                  final acceptRequests = foodPost.acceptRequest[index];
                  return FutureBuilder<User>(
                    future: UserAPiServices.getUser(acceptRequests.requesterId),
                    builder:
                        (BuildContext context, AsyncSnapshot<User> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          final user = snapshot.data!;
                          return FoodCard(
                              user: user, food: foodPost, complete: () {},comp: "COMPLETE",);
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
            });

      case Status.empty:
        return Align(
            alignment: Alignment.center,
            child: Lottie.asset(nodataAnim, repeat: true, width: size.width),
          );
    }
  }
}
