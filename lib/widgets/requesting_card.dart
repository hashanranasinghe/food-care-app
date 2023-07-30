import 'package:flutter/material.dart';

import 'package:food_care/view%20models/food%20post%20view/food_post_view_model.dart';

import '../models/userModel.dart';
import '../utils/config.dart';
import '../utils/constraints.dart';

class RequestingCard extends StatefulWidget {
  final User user;
  final FoodPostViewModel food;
  final Function accept;
  final Function reject;
  const RequestingCard(
      {super.key,
      required this.user,
      required this.food,
      required this.accept,
      required this.reject});

  @override
  State<RequestingCard> createState() => _RequestingCardState();
}

class _RequestingCardState extends State<RequestingCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              backgroundImage: widget.user.imageUrl == null
                  ? AssetImage(icon.toString())
                  : NetworkImage(Config.imageUrl(
                          imageUrl: widget.user.imageUrl.toString()))
                      as ImageProvider<Object>,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    widget.user.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  // Title
                  Text(
                    widget.food.title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    widget.accept();
                  },
                  icon: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () {
                    widget.reject();
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
