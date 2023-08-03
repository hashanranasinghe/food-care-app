import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/food_api_services.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';
import 'package:food_care/utils/config.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_view_model.dart';
import 'package:food_care/widgets/app_bar.dart';
import 'package:food_care/widgets/popup_dialog.dart';
import 'package:food_care/widgets/requesting_card.dart';
import 'package:provider/provider.dart';
import '../../models/userModel.dart';
import '../../view models/food post view/food_post_list_view_model.dart';
import '../../view models/user view/userViewModel.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FoodPostListViewModel>(context);
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if (userViewModel.user == null) {
        userViewModel.getCurrentUser();
        return const Center(child: CircularProgressIndicator());
      } else {
        return AppBarWidget(
          text: "Request list",
          widget: Column(
            children: [
              Expanded(
                // Wrap the ListView.builder with an Expanded widget to allow the list to take all available space.
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: vm.foods.length,
                  itemBuilder: (context, index) {
                    final food = vm.foods[index];

                    if (food.requests.isNotEmpty &&
                        food.userId == userViewModel.user!.id.toString()) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: food.requests.length,
                        itemBuilder: (context, index) {
                          final request = food.requests[index];
                          // Initialize acceptRequest here and set it to null initially.
                          String? acceptRequest;

                          if (food.acceptRequest.isNotEmpty) {
                            // If food.acceptRequests is not empty, assign the value to acceptRequest.
                            acceptRequest = food.acceptRequest[index];
                          } else {
                            acceptRequest = null;
                          }

                          if (request != acceptRequest ||
                              acceptRequest == null) {
                            return FutureBuilder<User>(
                              future: UserAPiServices.getUser(request),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text('Loading...');
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  final user = snapshot.data;
                                  if (user != null) {
                                    return RequestingCard(
                                        user: user,
                                        food: food,
                                        accept: () async {
                                          PopupDialog.showPopupDialog(
                                              context,
                                              "Request",
                                              "Are you sure about the accepting request?",
                                              () async {
                                            await accept(
                                                food: food, user: user);
                                            vm.getAllFoodPosts();
                                          });
                                        },
                                        reject: () async {
                                          PopupDialog.showPopupDialog(
                                              context,
                                              "Request",
                                              "Are you sure about the rejecting request?",
                                              () async {
                                            await reject(
                                                food: food, user: user);

                                          });
                                        });
                                  } else {
                                    return Text('User not found');
                                  }
                                }
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  reject({required FoodPostViewModel food, required User user}) async {
    await FoodApiServices.permissionFoodPost(
        foodId: food.id.toString(),
        requesterId: user.uid.toString(),
        path: Config.rejectFood);
    await UserAPiServices.foodRequest(
        state: "REJECT",
        foodId: food.id.toString(),
        userId: user.uid.toString(),
        path: Config.permission).whenComplete(() => Navigator.pop(context));

    print("reject");

  }

  accept({required FoodPostViewModel food, required User user}) async {
    await FoodApiServices.permissionFoodPost(
        foodId: food.id.toString(),
        requesterId: user.uid.toString(),
        path: Config.acceptFood);
    await UserAPiServices.foodRequest(
        state: "ACCEPT",
        foodId: food.id.toString(),
        userId: user.uid.toString(),
        path: Config.permission);

    print("accept");
  }
}
