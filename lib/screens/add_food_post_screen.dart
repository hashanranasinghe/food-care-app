import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';

import 'package:food_care/widgets/app_bar.dart';
import 'package:food_care/widgets/dash_line.dart';

import '../services/validate_handeler.dart';
import '../widgets/Gtextformfiled.dart';
import '../widgets/buttons.dart';

class AddFoodPostScreen extends StatefulWidget {
  const AddFoodPostScreen({Key? key}) : super(key: key);

  @override
  State<AddFoodPostScreen> createState() => _AddFoodPostScreenState();
}

class _AddFoodPostScreenState extends State<AddFoodPostScreen> {
  String title = "";
  String description = "";
  String other = "";
  String pickUpTimes = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  TextEditingController pickUptimesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
        text: "Free Food",
        widget: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    child: DashedSquare(
                      size: 120,
                      strokeWidth: 2.5,
                      borderRadius: 10,
                      icon: Icons.camera_alt_outlined,
                      iconSize: 60,
                    ),
                  ),
                  Text("Add upto 5 images"),
                ],
              ),
              Divider(
                thickness: 2,
              ),
              Gtextformfiled(
                  label: "Title",
                  onchange: (text) {
                    title = text;
                  },
                  valid: (text) {
                    return Validater.genaralvalid(text!);
                  },
                  save: (text) {
                    title = text!;
                  },
                  controller: titleController),
              Gtextformfiled(
                  label: "Description",
                  onchange: (text) {
                    description = text;
                  },
                  valid: (text) {
                    return Validater.genaralvalid(text!);
                  },
                  save: (text) {
                    description = text!;
                  },
                  controller: descriptionController),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Text(
                      "Quantity",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "(optional)",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ColorChangeButton(
                      onpress: () {},
                      text: "1",
                      ptop: 5,
                      pbottom: 5,
                      pleft: 25,
                      pright: 25,
                    ),
                    ColorChangeButton(
                      onpress: () {},
                      text: "2",
                      ptop: 5,
                      pbottom: 5,
                      pleft: 25,
                      pright: 25,
                    ),
                    ColorChangeButton(
                      onpress: () {},
                      text: "3",
                      ptop: 5,
                      pbottom: 5,
                      pleft: 25,
                      pright: 25,
                    ),
                    ColorChangeButton(
                      onpress: () {},
                      text: "4",
                      ptop: 5,
                      pbottom: 5,
                      pleft: 25,
                      pright: 25,
                    ),
                    ColorChangeButton(
                      onpress: () {},
                      text: "5",
                      ptop: 5,
                      pbottom: 5,
                      pleft: 25,
                      pright: 25,
                    ),
                  ],
                ),
              ),
              Gtextformfiled(
                  label: "Other",
                  onchange: (text) {
                    other = text;
                  },
                  valid: (text) {
                    return Validater.genaralvalid(text!);
                  },
                  save: (text) {
                    other = text!;
                  },
                  controller: otherController),
              Gtextformfiled(
                  label: "PickUp Times",
                  onchange: (text) {
                    pickUpTimes = text;
                  },
                  valid: (text) {
                    return Validater.genaralvalid(text!);
                  },
                  save: (text) {
                    pickUpTimes = text!;
                  },
                  controller: pickUptimesController),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your Location",
                      style: TextStyle(color: Colors.black),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_ios_rounded)),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Divider(
                  thickness: 2,
                  color: Color(0xFFE3E3E3FF),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "List for",
                      style: TextStyle(color: Colors.black),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_ios_rounded)),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Divider(
                  thickness: 2,
                  color: Color(0xFFE3E3E3FF),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Genaralbutton(
                  pleft: 100,
                  pright: 100,
                  onpress: () {},
                  text: "Upload",
                ),
              ),
            ],
          ),
        ));
  }
}
