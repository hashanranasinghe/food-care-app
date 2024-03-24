import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/chat_api_services.dart';
import 'package:food_care/services/api%20services/food_api_services.dart';
import 'package:food_care/services/api%20services/map_services.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/utils/covertor.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversastion_add_view_model.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversation_view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/widgets/buttons.dart';
import 'package:food_care/widgets/divider.dart';
import 'package:food_care/widgets/get_user_image.dart';
import 'package:food_care/widgets/popup_dialog.dart';
import 'package:food_care/widgets/show_time_ago_row.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../models/foodPostModel.dart';
import '../../utils/config.dart';
import '../../view models/food post view/food_post_list_view_model.dart';
import '../../widgets/flutter_toast.dart';
import '../../widgets/food post/foodpost_display_row.dart';

class FoodPostDisplayScreen extends StatefulWidget {
  final String foodId;
  final String id;
  final Position position;
  const FoodPostDisplayScreen(
      {Key? key,
      required this.foodId,
      required this.id,
      required this.position})
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
    Size screenSize = MediaQuery.of(context).size;
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
                  print(foodPost.availableTime.startTime);
                  return Scaffold(
                    backgroundColor: kNavBarColor,
                    appBar: AppBar(
                      centerTitle: true,
                      backgroundColor: Colors.white,
                      elevation: 2,
                      iconTheme: IconThemeData(color: kPrimaryColorDark),
                      titleTextStyle: TextStyle(
                          color: kPrimaryColorDark,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                      title: Text(Convertor.upperCase(text: foodPost.title)),
                      actions: [
                        IconButton(
                            onPressed: () {
                              openReport(context, widget.foodId, "FOOD");
                            },
                            icon: Icon(Icons.info_outline))
                      ],
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: screenSize.height * 0.01),
                            child: CarouselSlider(
                              items: foodPost.imageUrls.map((image) {
                                return Image.network(
                                    Config.imageUrl(imageUrl: image));
                              }).toList(),
                              options: CarouselOptions(
                                height: screenSize.height * 0.3,
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
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.04,
                                vertical: screenSize.height * 0.02),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Convertor.upperCase(text: foodPost.title),
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GetUserImage(
                                          id: foodPost.userId.toString(),
                                          radius: 25,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: screenSize.width * 0.01),
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
                                                      Convertor.upperCase(
                                                          text:
                                                              "${foodPost.author} "),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                               Text(
                                                      "give away",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    ShowTimeAgoRow(
                                                        time:
                                                            foodPost.createdAt),
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.05),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${foodPost.description}",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  screenSize.height * 0.01),
                                          child: Column(
                                            children: [
                                              DividerWidget(),
                                              FoodPostDisplayRow(
                                                  text: foodPost
                                                      .availableTime.startTime,
                                                  topicIcon:
                                                      Icons.timer_outlined,
                                                  topic: "Start Time"),
                                              DividerWidget(),
                                              FoodPostDisplayRow(
                                                  text: foodPost
                                                      .availableTime.endTime,
                                                  topicIcon:
                                                      Icons.timer_outlined,
                                                  topic: "End Time"),
                                              DividerWidget(),
                                              FoodPostDisplayRow(
                                                  text:
                                                      "${Convertor.getDifferenceLocation(widget.position, foodPost.location).toString()} Km",
                                                  topicIcon: Icons
                                                      .location_on_outlined,
                                                  topic: "Distance"),
                                              DividerWidget(),
                                              FoodPostDisplayRow(
                                                  text: foodPost.category,
                                                  topicIcon:
                                                      Icons.category_outlined,
                                                  topic: "Category"),
                                              DividerWidget(),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Iconbutton(
                                                bicon: const Icon(
                                                    Icons.location_on_sharp),
                                                onpress: () {
                                                  MapServices.openMapApp(
                                                      double.parse(foodPost
                                                          .location.lan
                                                          .toString()),
                                                      double.parse(foodPost
                                                          .location.lon
                                                          .toString()));
                                                }),
                                            if (foodPost.userId !=
                                                userViewModel.user!.id) ...[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  if (foodPost.requests
                                                      .contains(userViewModel
                                                          .user!.id)) ...[
                                                    SizedBox(
                                                      width: screenSize.width *
                                                          0.05,
                                                      height:
                                                          screenSize.height *
                                                              0.1,
                                                    ),
                                                    Genaralbutton(
                                                      fontsize: 15,
                                                      onpress: () async {
                                                        PopupDialog.showPopupDialog(
                                                            context,
                                                            "Cancel Request",
                                                            "Do you want to cancel request?",
                                                            () async {
                                                          int res = await FoodApiServices
                                                              .requestFoodPost(
                                                                  foodId: foodPost
                                                                      .id
                                                                      .toString(),
                                                                  requesterId:
                                                                      '');
                                                          _foodPostListViewModel
                                                              .getAllFoodPosts();
                                                          await UserAPiServices
                                                              .foodRequest(
                                                                  state:
                                                                      "PENDING",
                                                                  complete:
                                                                      "NO",
                                                                  path: Config
                                                                      .request,
                                                                  foodId: foodPost
                                                                      .id
                                                                      .toString(),
                                                                  userId: userViewModel
                                                                      .user!.id
                                                                      .toString());
                                                          setState(() {});
                                                        });
                                                      },
                                                      text: "Cancel Request",
                                                    ),
                                                  ] else ...[
                                                    if (userViewModel.user!
                                                                .foodRequest !=
                                                            null &&
                                                        userViewModel
                                                                .user!
                                                                .foodRequest!
                                                                .length <
                                                            4) ...[
                                                      SizedBox(
                                                        width:
                                                            screenSize.width *
                                                                0.05,
                                                        height:
                                                            screenSize.height *
                                                                0.1,
                                                      ),
                                                      Genaralbutton(
                                                        fontsize: 15,
                                                        onpress: () async {
                                                          PopupDialog.showPopupDialog(
                                                              context,
                                                              "Request For Food",
                                                              "Do you want to request this food?",
                                                              () async {
                                                            int res = await FoodApiServices
                                                                .requestFoodPost(
                                                                    foodId: foodPost
                                                                        .id
                                                                        .toString(),
                                                                    requesterId:
                                                                        '');
                                                            _foodPostListViewModel
                                                                .getAllFoodPosts();
                                                            await UserAPiServices.foodRequest(
                                                                state:
                                                                    "PENDING",
                                                                complete: "NO",
                                                                path: Config
                                                                    .request,
                                                                foodId: foodPost
                                                                    .id
                                                                    .toString(),
                                                                userId: userViewModel
                                                                    .user!.id
                                                                    .toString());
                                                            setState(() {});
                                                            await userViewModel
                                                                .getCurrentUser();
                                                          });
                                                        },
                                                        text:
                                                            "Request for Food",
                                                      )
                                                    ] else ...[
                                                      SizedBox(
                                                        width:
                                                            screenSize.width *
                                                                0.05,
                                                        height:
                                                            screenSize.height *
                                                                0.1,
                                                      ),
                                                      Genaralbutton(
                                                        isActive: false,
                                                        onpress: () async {
                                                          ToastWidget.toast(
                                                              msg: "limit");
                                                        },
                                                        text:
                                                            "Request for Food",
                                                      )
                                                    ]
                                                  ],
                                                  SizedBox(
                                                    width:
                                                        screenSize.width * 0.05,
                                                  ),
                                                  Iconbutton(
                                                      onpress: () async {
                                                        try {
                                                          final ConversationViewModel
                                                              vm =
                                                              await ChatApiServices.getConversation(
                                                                  senderId:
                                                                      userViewModel
                                                                          .user!
                                                                          .id
                                                                          .toString(),
                                                                  receiverId:
                                                                      widget
                                                                          .id);
                                                          openMessaging(
                                                            context: context,
                                                            conversationViewModel:
                                                                vm,
                                                            receiverName:
                                                                foodPost.author
                                                                    .toString(),
                                                            conversationId: vm
                                                                .id
                                                                .toString(),
                                                            id: widget.id,
                                                          );
                                                        } catch (e) {
                                                          conversationAddViewModel
                                                              .members
                                                              .add(userViewModel
                                                                  .user!.id);
                                                          conversationAddViewModel
                                                              .members
                                                              .add(foodPost
                                                                  .userId);
                                                          conversationAddViewModel
                                                                  .createdAt =
                                                              DateTime.now();
                                                          conversationAddViewModel
                                                                  .updatedAt =
                                                              DateTime.now();
                                                          await conversationAddViewModel
                                                              .createConversation();
                                                          final ConversationViewModel
                                                              vm =
                                                              await ChatApiServices.getConversation(
                                                                  senderId:
                                                                      userViewModel
                                                                          .user!
                                                                          .id
                                                                          .toString(),
                                                                  receiverId:
                                                                      widget
                                                                          .id);
                                                          openMessaging(
                                                            context: context,
                                                            conversationViewModel:
                                                                vm,
                                                            receiverName:
                                                                foodPost.author
                                                                    .toString(),
                                                            conversationId: vm
                                                                .id
                                                                .toString(),
                                                            id: widget.id,
                                                          );
                                                        }
                                                      },
                                                      bicon: Icon(Icons
                                                          .message_outlined))
                                                ],
                                              ),
                                            ] else ...[
                                              Container()
                                            ],
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
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
