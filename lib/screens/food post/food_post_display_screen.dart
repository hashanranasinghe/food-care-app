import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/chat_api_services.dart';
import 'package:food_care/services/api%20services/food_api_services.dart';
import 'package:food_care/services/api%20services/map_services.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversastion_add_view_model.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversation_view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/widgets/buttons.dart';
import 'package:food_care/widgets/get_user_image.dart';
import 'package:food_care/widgets/popup_dialog.dart';
import 'package:food_care/widgets/show_time_ago_row.dart';
import 'package:provider/provider.dart';

import '../../models/foodPostModel.dart';
import '../../utils/config.dart';
import '../../view models/food post view/food_post_list_view_model.dart';
import '../../widgets/flutter_toast.dart';

class FoodPostDisplayScreen extends StatefulWidget {
  final String foodId;
  final String id;
  const FoodPostDisplayScreen(
      {Key? key, required this.foodId, required this.id})
      : super(key: key);

  @override
  State<FoodPostDisplayScreen> createState() => _FoodPostDisplayScreenState();
}

class _FoodPostDisplayScreenState extends State<FoodPostDisplayScreen> {
  late ConversationAddViewModel conversationAddViewModel;
  late FoodPostListViewModel _foodPostListViewModel;

  @override
  void initState() {
    super.initState();
    _getFood();
    conversationAddViewModel =
        Provider.of<ConversationAddViewModel>(context, listen: false);
    _foodPostListViewModel =
        Provider.of<FoodPostListViewModel>(context, listen: false);
  }

  Future<Food> _getFood() async {
    return await FoodApiServices.getFoodPost(foodId: widget.foodId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if (userViewModel.user == null) {
        userViewModel.getCurrentUser();
        return const Center(child: CircularProgressIndicator());
      } else {
        return Scaffold(
          body: FutureBuilder<Food>(
              future: _getFood(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final Food foodPost = snapshot.data!;
                  return Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      backgroundColor: kPrimaryColordark,
                      title: Text(foodPost.title),
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CarouselSlider(
                              items: foodPost.imageUrls.map((image) {
                                return Image.network(
                                    Config.imageUrl(imageUrl: image));
                              }).toList(),
                              options: CarouselOptions(
                                height: 300.0,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: kSecondColorDark,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 8,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GetUserImage(
                                          id: foodPost.userId.toString(),
                                          radius: 30,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${foodPost.author} give away",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      foodPost.title,
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    ShowTimeAgoRow(
                                                        time:
                                                            foodPost.updatedAt),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${foodPost.description}",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Listing for",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child:
                                                    Icon(Icons.label_important),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Text(
                                                    "${foodPost.listDays}"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Pickup times",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child:
                                                    Icon(Icons.label_important),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Text(
                                                    "${foodPost.pickupTimes}"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    MapServices.openMapApp(
                                                        double.parse(foodPost
                                                            .location.lan
                                                            .toString()),
                                                        double.parse(foodPost
                                                            .location.lon
                                                            .toString()));
                                                  },
                                                  child:
                                                      Text("Go to direction"))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (foodPost.userId != userViewModel.user!.id) ...[
                            Column(
                              children: [
                                if (foodPost.requests
                                    .contains(userViewModel.user!.id)) ...[
                                  Genaralbutton(
                                    pleft: 60,
                                    pright: 60,
                                    ptop: 15,
                                    pbottom: 15,
                                    onpress: () async {
                                      PopupDialog.showPopupDialog(
                                          context,
                                          "Cancel Request",
                                          "Do you want to cancel request?",
                                          () async {
                                        int res = await FoodApiServices
                                            .requestFoodPost(
                                                foodId: foodPost.id.toString(),
                                                requesterId: '');
                                        _foodPostListViewModel
                                            .getAllFoodPosts();
                                        await UserAPiServices.foodRequest(
                                            foodId: foodPost.id.toString(),
                                            userId: userViewModel.user!.id
                                                .toString());
                                        setState(() {});
                                      });
                                    },
                                    text: "Cancel Request",
                                  ),
                                ] else ...[
                                  if (userViewModel.user!.dailyRequests !=
                                          null &&
                                      userViewModel
                                              .user!.dailyRequests!.length <
                                          4) ...[
                                    Genaralbutton(
                                      pleft: 60,
                                      pright: 60,
                                      ptop: 15,
                                      pbottom: 15,
                                      onpress: () async {
                                        PopupDialog.showPopupDialog(
                                            context,
                                            "Request For Food",
                                            "Do you want to request this food?",
                                            () async {
                                          int res = await FoodApiServices
                                              .requestFoodPost(
                                                  foodId:
                                                      foodPost.id.toString(),
                                                  requesterId: '');
                                          _foodPostListViewModel
                                              .getAllFoodPosts();
                                          await UserAPiServices.foodRequest(
                                              foodId: foodPost.id.toString(),
                                              userId: userViewModel.user!.id
                                                  .toString());
                                          setState(() {});
                                          await userViewModel.getCurrentUser();
                                        });

                                      },
                                      text: "Request for Food",
                                    )
                                  ] else ...[
                                    Genaralbutton(
                                      isActive: false,
                                      pleft: 60,
                                      pright: 60,
                                      ptop: 15,
                                      pbottom: 15,
                                      onpress: () async {
                                        ToastWidget.toast(msg: "limit");
                                      },
                                      text: "Request for Food",
                                    )
                                  ]
                                ],
                                Genaralbutton(
                                  onpress: () async {
                                    try {
                                      final ConversationViewModel vm =
                                          await ChatApiServices.getConversation(
                                              senderId: userViewModel.user!.id
                                                  .toString(),
                                              receiverId: widget.id);
                                      openMessaging(
                                        context: context,
                                        conversationViewModel: vm,
                                        receiverName:
                                            foodPost.author.toString(),
                                        conversationId: vm.id.toString(),
                                        id: widget.id,
                                      );
                                    } catch (e) {
                                      conversationAddViewModel.members
                                          .add(userViewModel.user!.id);
                                      conversationAddViewModel.members
                                          .add(foodPost.userId);
                                      conversationAddViewModel.createdAt =
                                          DateTime.now();
                                      conversationAddViewModel.updatedAt =
                                          DateTime.now();
                                      await conversationAddViewModel
                                          .createConversation();
                                      final ConversationViewModel vm =
                                          await ChatApiServices.getConversation(
                                              senderId: userViewModel.user!.id
                                                  .toString(),
                                              receiverId: widget.id);
                                      openMessaging(
                                        context: context,
                                        conversationViewModel: vm,
                                        receiverName:
                                            foodPost.author.toString(),
                                        conversationId: vm.id.toString(),
                                        id: widget.id,
                                      );
                                    }
                                  },
                                  text: "Contact",
                                  pleft: 60,
                                  pright: 60,
                                  ptop: 15,
                                  pbottom: 15,
                                ),
                              ],
                            ),
                          ] else ...[
                            Container()
                          ],
                          ElevatedButton(onPressed: (){
                            print(userViewModel.user!.dailyRequests!.length);
                          }, child:Text("print"))

                        ],
                      ),
                    ),
                  );
                }
              }),
        );
      }
    });
  }
}
