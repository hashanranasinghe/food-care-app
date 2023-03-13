import 'package:flutter/material.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_add_view_model.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_list_view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/widgets/divider.dart';
import 'package:food_care/widgets/quantity_row.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/foodPostModel.dart';
import '../services/validate_handeler.dart';
import '../utils/config.dart';
import '../widgets/Gtextformfiled.dart';
import '../widgets/buttons.dart';
import '../widgets/showServerImages.dart';
import '../widgets/show_images.dart';

class AddFoodPostScreen extends StatefulWidget {
  final Food? food;
  const AddFoodPostScreen({Key? key, this.food}) : super(key: key);

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
    if (widget.food != null) {
      titleController.text = widget.food!.title;
      descriptionController.text = widget.food!.description;
      otherController.text = widget.food!.other!;
      pickUptimesController.text = widget.food!.pickupTimes;
      _selectedDay = widget.food!.listDays;
      imageUrls = widget.food!.imageUrls;
    }

    _foodPostAddViewModel =
        Provider.of<FoodPostAddViewModel>(context, listen: false);
    _foodPostListViewModel =
        Provider.of<FoodPostListViewModel>(context, listen: false);
  }

  String title = "";
  String description = "";
  String other = "";
  String pickUpTimes = "";
  List<String> imagePaths = [];
  List<String> imageUrls = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  TextEditingController pickUptimesController = TextEditingController();

  String? _selectedDay;
  final List<String> _days = [
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

  final List<String> quantities = ['1', '2', '3', '4', '5'];

  final _form = GlobalKey<FormState>();

  List<String> _convertToLinks() {
    imageUrls =
        imageUrls.map((image) => Config.imageUrl(imageUrl: image)).toList();
    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FoodPostAddViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Free Food",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
          key: _form,
          child:
              Consumer<UserViewModel>(builder: (context, userViewModel, child) {
            if (userViewModel.user == null) {
              userViewModel.getCurrentUser();
              return const Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (imageUrls.length == 0) ...[
                      ShowImages(
                          imagePaths: imagePaths,
                          galleryOnPress: () async {
                            final pickedFiles =
                                await ImagePicker().pickMultiImage(
                              maxWidth: 800,
                              imageQuality: 80,
                            );
                            if (pickedFiles != null) {
                              setState(() {
                                imagePaths.addAll(pickedFiles
                                    .map((file) => file.path)
                                    .toList());
                              });
                              print(imagePaths);
                              Navigator.pop(context);
                            }
                          },
                          cameraOnPress: () async {
                            final pickedFile = await ImagePicker()
                                .pickImage(source: ImageSource.camera);
                            if (pickedFile != null) {
                              setState(() {
                                imagePaths.add(pickedFile.path);
                              });
                              Navigator.pop(context);
                            }
                          })
                    ] else ...[
                      ShowServerImages(
                          imageUrls: _convertToLinks(),
                          galleryOnPress: () async {
                            final pickedFiles =
                                await ImagePicker().pickMultiImage(
                              maxWidth: 800,
                              imageQuality: 80,
                            );
                            if (pickedFiles != null) {
                              setState(() {
                                imagePaths.addAll(pickedFiles
                                    .map((file) => file.path)
                                    .toList());
                              });
                              print(imagePaths);
                              Navigator.pop(context);
                            }
                          },
                          cameraOnPress: () async {
                            final pickedFile = await ImagePicker()
                                .pickImage(source: ImageSource.camera);
                            if (pickedFile != null) {
                              setState(() {
                                imagePaths.add(pickedFile.path);
                              });
                              Navigator.pop(context);
                            }
                          })
                    ],
                    const DividerWidget(),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
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
                    QuantityRow(
                        quantities: quantities,
                        function: (index) {
                          setState(() {
                            vm.quantity = quantities[index];
                          });
                          print(vm.quantity);
                        }),
                    const DividerWidget(),
                    Gtextformfiled(
                        label: "Other",
                        onchange: (text) {
                          vm.other = text;
                        },
                        valid: (text) {},
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
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
                    const DividerWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
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
                    const DividerWidget(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Genaralbutton(
                        pleft: 100,
                        pright: 100,
                        onpress: () {
                          uploadAPost(vm: vm, author: userViewModel.user!.name);
                        },
                        text: "Upload",
                      ),
                    ),
                  ],
                ),
              );
            }
          })),
    );
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

  void uploadAPost(
      {required FoodPostAddViewModel vm, required String author}) async {
    if (_form.currentState!.validate()) {
      setState(() {
        vm.listDays = _selectedDay.toString();
        vm.imageUrls = imagePaths;
        vm.author = author;
        vm.location = Location(lan: '2', lon: '2');
      });
      await _foodPostAddViewModel.saveFoodPost();
      await _foodPostListViewModel.getAllFoodPosts();
      openHome(context);
    }
  }
}
