import 'package:flutter/material.dart';
import 'package:food_care/models/userModel.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_list_view_model.dart';
import 'package:food_care/widgets/food%20post/food_card.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:food_care/utils/constraints.dart';
class CompleteTab extends StatefulWidget {
  const CompleteTab({
    super.key,
  });

  @override
  State<CompleteTab> createState() => _CompleteTabState();
}

class _CompleteTabState extends State<CompleteTab> {
  late FoodPostListViewModel _foodPostListViewModel;
  @override
  void initState() {
    Provider.of<FoodPostListViewModel>(context, listen: false)
        .getCompleteFoodPosts();
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
        return ListView.builder(
            shrinkWrap: true,
            itemCount: vm.completedFoods.length,
            itemBuilder: (context, index) {
              final foodPost = vm.completedFoods[index];
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
