import 'package:flutter/material.dart';

import 'package:food_care/view%20models/food%20post%20view/food_post_add_view_model.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_list_view_model.dart';

import 'package:food_care/widgets/app_bar.dart';
import 'package:food_care/widgets/dash_line.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../services/validate_handeler.dart';
import '../widgets/Gtextformfiled.dart';
import '../widgets/buttons.dart';

class AddFoodPostScreen extends StatefulWidget {
  const AddFoodPostScreen({Key? key}) : super(key: key);

  @override
  State<AddFoodPostScreen> createState() => _AddFoodPostScreenState();
}

class _AddFoodPostScreenState extends State<AddFoodPostScreen> {
  late FoodPostAddViewModel _foodPostAddViewModel;
  late FoodPostListViewModel _foodPostListViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foodPostAddViewModel =
        Provider.of<FoodPostAddViewModel>(context, listen: false);
    _foodPostListViewModel =
        Provider.of<FoodPostListViewModel>(context, listen: false);
  }

  String title = "";
  String description = "";
  String other = "";
  String pickUpTimes = "";
  String imagePath = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  TextEditingController pickUptimesController = TextEditingController();

  String? _selectedDay;
  List<String> _days = [
    'Until midnight',
    '1 hour',
    '2 hours',
    '4 hours',
    '6 hours',
    '8 hours',
    '1 day',
    '2 days',
    '3 days',
    '4 days',
    '5 days',
    '6 days',
    '1 week',
  ];

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FoodPostAddViewModel>(context);
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
                    child: GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _takeImage(context);
                          },
                        );
                      },
                      child: DashedSquare(
                        size: 120,
                        strokeWidth: 2.5,
                        borderRadius: 10,
                        icon: Icons.camera_alt_outlined,
                        iconSize: 60,
                      ),
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
                    vm.title = text;
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
                    vm.description = text;
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
                      onpress: () {
                        setState(() {
                          vm.quantity = "1";
                        });
                      },
                      text: "1",
                      ptop: 5,
                      pbottom: 5,
                      pleft: 25,
                      pright: 25,
                    ),
                    ColorChangeButton(
                      onpress: () {
                        setState(() {
                          vm.quantity = "2";
                        });
                      },
                      text: "2",
                      ptop: 5,
                      pbottom: 5,
                      pleft: 25,
                      pright: 25,
                    ),
                    ColorChangeButton(
                      onpress: () {
                        setState(() {
                          vm.quantity = "3";
                        });
                      },
                      text: "3",
                      ptop: 5,
                      pbottom: 5,
                      pleft: 25,
                      pright: 25,
                    ),
                    ColorChangeButton(
                      onpress: () {
                        setState(() {
                          vm.quantity = "4";
                        });
                      },
                      text: "4",
                      ptop: 5,
                      pbottom: 5,
                      pleft: 25,
                      pright: 25,
                    ),
                    ColorChangeButton(
                      onpress: () {
                        setState(() {
                          vm.quantity = "5";
                        });
                      },
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
                    vm.other = text;
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
                    vm.pickupTimes = text;
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
                    _getDropDown(),
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
                  onpress: () {
                    vm.listDays = _selectedDay.toString();
                  },
                  text: "Upload",
                ),
              ),
            ],
          ),
        ));
  }

  _getDropDown() {
    return DropdownButton(
      hint: Text('Select'),
      value: _selectedDay,
      onChanged: (newValue) {
        setState(() {
          _selectedDay = newValue.toString();
        });
      },
      items: _days.map((day) {
        return DropdownMenuItem(
          child: new Text(day),
          value: day,
        );
      }).toList(),
    );
  }

  Widget _takeImage(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    final pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.camera);
                    print(pickedFile!.path);
                    setState(() {
                      imagePath = pickedFile.path;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt),
                        SizedBox(width: 8),
                        Text("Take a picture"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    final pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    print(pickedFile!.path);

                    setState(() {
                      imagePath = pickedFile.path;
                      print(imagePath);
                    });

                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.photo_library),
                        SizedBox(width: 8),
                        Text("Choose from gallery"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
