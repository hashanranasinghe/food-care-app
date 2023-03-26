import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/chat_api_services.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversastion_add_view_model.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversation_view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/widgets/buttons.dart';
import 'package:food_care/widgets/get_user_image.dart';
import 'package:food_care/widgets/show_time_ago_row.dart';
import 'package:provider/provider.dart';

import '../../models/foodPostModel.dart';
import '../../utils/config.dart';

class FoodPostDisplayScreen extends StatefulWidget {
  final Food? foodPost;
  final String id;
  const FoodPostDisplayScreen({Key? key, this.foodPost, required this.id})
      : super(key: key);

  @override
  State<FoodPostDisplayScreen> createState() => _FoodPostDisplayScreenState();
}

class _FoodPostDisplayScreenState extends State<FoodPostDisplayScreen> {
  late ConversationAddViewModel conversationAddViewModel;

  @override
  void initState() {
    super.initState();
    conversationAddViewModel =
        Provider.of<ConversationAddViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if (userViewModel.user == null) {
        userViewModel.getCurrentUser();
        return const Center(child: CircularProgressIndicator());
      } else {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: kPrimaryColordark,
            title: Center(child: Text(widget.foodPost!.title)),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CarouselSlider(
                    items: widget.foodPost!.imageUrls.map((image) {
                      return Image.network(Config.imageUrl(imageUrl: image));
                    }).toList(),
                    options: CarouselOptions(
                      height: 300.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GetUserImage(
                                id: widget.foodPost!.userId.toString(),
                                radius: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${widget.foodPost!.author} give away",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            widget.foodPost!.title,
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          ShowTimeAgoRow(
                                              time: widget.foodPost!.updatedAt),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.foodPost!.description}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 20),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      "Listing for",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Icon(Icons.label_important),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child:
                                          Text("${widget.foodPost!.listDays}"),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      "Pickup times",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Icon(Icons.label_important),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                          "${widget.foodPost!.pickupTimes}"),
                                    ),
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
                if (widget.foodPost!.userId != userViewModel.user!.id) ...[
                  Genaralbutton(
                    onpress: () async {
                      try{
                        final ConversationViewModel vm =
                        await ChatApiServices.getConversation(
                            senderId: userViewModel.user!.id.toString(),
                            receiverId: widget.id);
                        openMessaging(context, widget.foodPost!.author.toString(),vm.id.toString(), vm, widget.id);
                      }catch(e){
                        conversationAddViewModel.members
                            .add(userViewModel.user!.id);
                        conversationAddViewModel.members
                            .add(widget.foodPost!.userId);
                        conversationAddViewModel.createdAt = DateTime.now();
                        conversationAddViewModel.updatedAt = DateTime.now();
                        await conversationAddViewModel.createConversation();
                        final ConversationViewModel vm =
                        await ChatApiServices.getConversation(
                            senderId: userViewModel.user!.id.toString(),
                            receiverId: widget.id);
                        openMessaging(context, widget.foodPost!.author.toString(),vm.id.toString(), vm, widget.id);
                      }
                    },
                    text: "Request for Food",
                    pleft: 60,
                    pright: 60,
                    ptop: 15,
                    pbottom: 15,
                  ),
                ] else ...[
                  Container()
                ]
              ],
            ),
          ),
        );
      }
    });
  }
}
