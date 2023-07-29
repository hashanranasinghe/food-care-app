import 'package:flutter/material.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_add_view_model.dart';
import 'package:food_care/view%20models/food%20post%20view/food_post_list_view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/widgets/divider.dart';
import 'package:food_care/widgets/flutter_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/foodPostModel.dart';
import '../../models/userModel.dart';
import '../../services/validate_handeler.dart';
import '../../utils/config.dart';
import '../../widgets/Gtextformfiled.dart';
import '../../widgets/buttons.dart';
import '../../widgets/show_images.dart';
import 'package:intl/intl.dart';

class AddFoodPostScreen extends StatefulWidget {
  final Food? food;
  const AddFoodPostScreen({Key? key, this.food}) : super(key: key);

  @override
  State<AddFoodPostScreen> createState() => _AddFoodPostScreenState();
}

class _AddFoodPostScreenState extends State<AddFoodPostScreen> {
  late FoodPostAddViewModel _foodPostAddViewModel;
  late FoodPostListViewModel _foodPostListViewModel;
  List request = [];
  DateTime now = DateTime.now();
  String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = "";
  TimeOfDay? _timeOfDay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.food != null) {
      titleController.text = widget.food!.title;
      descriptionController.text = widget.food!.description;
      _selectedDay = widget.food!.listDays;
      imageUrls = widget.food!.imageUrls;
      _selectedValue = int.parse(widget.food!.quantity);
      availableTime = widget.food!.availableTime;
      _selectCategory = widget.food!.category;
      location = widget.food!.location;
      request = widget.food!.requests;
    } else {
      location = Location(lan: "0.0", lon: "0.0");
    }
    startController.text = formattedTime;
    imageUrls = _convertToLinks();
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
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  Location? location;
  AvailableTime? availableTime;
  String? _selectCategory;
  String? _selectedDay;
  DateTime selectedTime = DateTime.now();
  final List<String> _days = [
    '1 day',
    '2 days',
    '3 days',
    '4 days',
    '5 days',
    '6 days',
    '1 week',
  ];
  final List<String> _categories = [
    'Fruits',
    'Vegetables',
    'Cooked',
    'Short-Eats',
  ];

  final List<String> quantities = ['1', '2', '3', '4', '5'];
  int _selectedValue = 0;
  final _form = GlobalKey<FormState>();

  List<String> _convertToLinks() {
    setState(() {
      imagePaths =
          imageUrls.map((image) => Config.imageUrl(imageUrl: image)).toList();
    });

    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FoodPostAddViewModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
                    ShowImages(
                        foodId: widget.food?.id.toString(),
                        imagePaths: imagePaths,
                        galleryOnPress: () async {
                          final pickedFiles =
                              await ImagePicker().pickMultiImage(
                            maxWidth: 800,
                            imageQuality: 80,
                          );
                          setState(() {
                            imagePaths.addAll(
                                pickedFiles.map((file) => file.path).toList());
                          });
                          print(imagePaths);
                          Navigator.pop(context);
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
                        }),
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _radioButtons(),
                      ),
                    ),
                    const DividerWidget(),
                    Column(
                      children: [
                        Text("Available time"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.3,
                              height: screenHeight * 0.13,
                              child: TextFieldWidget(
                                keybordtype: TextInputType.number,
                                label: "Start",
                                readOnly: false,
                                onchange: (value) {
                                  setState(() {});
                                },
                                valid: (value) {},
                                save: (value) {},
                                controller: startController,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _getTime();
                              },
                              child: SizedBox(
                                width: screenWidth * 0.3,
                                height: screenHeight * 0.13,
                                child: TextFieldWidget(
                                  keybordtype: TextInputType.number,
                                  readOnly: false,
                                  label: "End",
                                  onchange: (value) {
                                    setState(() {
                                      endTime = value;
                                    });
                                  },
                                  valid: (value) {},
                                  save: (value) {},
                                  controller: endController,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                              onPressed: () {
                                openMap(context, location!);
                              },
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
                            "Select category",
                            style: TextStyle(color: Colors.black),
                          ),
                          _getCategoriesDropDown()
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
                          _getDaysDropDown(),
                        ],
                      ),
                    ),
                    const DividerWidget(),
                    if (widget.food != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Genaralbutton(
                          pleft: 100,
                          pright: 100,
                          onpress: () {
                            update(user: userViewModel.user!);
                            //print(_foodPostAddViewModel.location.lan);
                          },
                          text: "Update",
                        ),
                      ),
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Genaralbutton(
                          pleft: 100,
                          pright: 100,
                          onpress: () {
                            uploadAPost(vm: vm, user: userViewModel.user!);
                          },
                          text: "Upload",
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }
          })),
    );
  }

  _getDaysDropDown() {
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

  _getCategoriesDropDown() {
    return DropdownButton(
      hint: Text('Select'),
      value: _selectCategory,
      onChanged: (newValue) {
        setState(() {
          _selectCategory = newValue.toString();
        });
      },
      items: _categories.map((category) {
        return DropdownMenuItem(
          child: new Text(category),
          value: category,
        );
      }).toList(),
    );
  }

  void _getTime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      if (value != null) {
        setState(() {
          _timeOfDay = value;

          String formattedTime = _formatTimeOfDay(_timeOfDay!);
          endController.text = formattedTime; // Update the text field value
        });
      }
    });
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    setState(() {
      selectedTime = DateTime(
          now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    });

    return DateFormat('hh:mm a').format(selectedTime);
  }

  void uploadAPost(
      {required FoodPostAddViewModel vm, required User user}) async {
    if (_form.currentState!.validate()) {
      setState(() {
        vm.quantity = _selectedValue.toString();
        vm.listDays = _selectedDay.toString();
        vm.category = _selectCategory.toString();
        vm.availableTime = AvailableTime(
            startTime: startController.text, endTime: endController.text);
        vm.imageUrls = imagePaths;
        vm.author = user.name;
        vm.isShared = false;
      });

      int res = await _foodPostAddViewModel.saveFoodPost();
      if (res == resOk) {
        await _foodPostListViewModel.getAllFoodPosts();
        openHome(context, user);
        ToastWidget.toast(msg: "Food Post uploaded successfully");
      } else {
        ToastWidget.toast(msg: "Something went to wrong.");
      }
    }
  }

  void update({required User user}) async {
    setState(() {
      _foodPostAddViewModel.id = widget.food!.id.toString();
      _foodPostAddViewModel.author = widget.food!.author.toString();
      _foodPostAddViewModel.title = titleController.text;
      _foodPostAddViewModel.description = descriptionController.text;
      _foodPostAddViewModel.quantity = _selectedValue.toString();
      _foodPostAddViewModel.availableTime = AvailableTime(
          startTime: startController.text, endTime: endController.text);
      _foodPostAddViewModel.listDays = _selectedDay!;
      _foodPostAddViewModel.isShared = false;
      _foodPostAddViewModel.requests = request;
      if (imagePaths.isNotEmpty) {
        print('Image path: $imagePaths');
        _foodPostAddViewModel.imageUrls = imagePaths;
      } else {
        print('Image path is null');
      }
    });

    int res = await _foodPostAddViewModel.updateFoodPost();

    if (res == resOk) {
      await _foodPostListViewModel.getAllFoodPosts();
      openHome(context, user);
      ToastWidget.toast(msg: "Food Post updated successfully");
    } else {
      ToastWidget.toast(msg: "Something went to wrong.");
    }
  }

  List<Widget> _radioButtons() {
    List<Widget> buttons = [];
    for (int i = 1; i <= 6; i++) {
      buttons.add(Row(
        children: [
          Radio(
            value: i,
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value as int;
              });
            },
          ),
          Text(i.toString()),
        ],
      ));
    }
    return buttons;
  }
}
