import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_care/models/forumModel.dart';
import 'package:food_care/models/userModel.dart';
import 'package:food_care/services/api%20services/forum_api_services.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/forum%20view/forum_add_view_model.dart';
import 'package:food_care/view%20models/forum%20view/forum_list-view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:food_care/widgets/Gtextformfiled.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../services/validate_handeler.dart';
import '../../utils/config.dart';
import '../../widgets/buttons.dart';
import '../../widgets/flutter_toast.dart';
import '../../widgets/bottom sheet/take_images.dart';

class AddForumScreen extends StatefulWidget {
  final Forum? forum;
  const AddForumScreen({Key? key, this.forum}) : super(key: key);

  @override
  State<AddForumScreen> createState() => _AddForumScreenState();
}

class _AddForumScreenState extends State<AddForumScreen> {
  late AddForumViewModel _addForumViewModel;
  late ForumListViewModel _forumListViewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addForumViewModel = Provider.of<AddForumViewModel>(context, listen: false);
    if (widget.forum != null) {
      titleController.text = widget.forum!.title;
      descriptionController.text = widget.forum!.description;
      imageUrl = widget.forum!.imageUrl.toString();
      _addForumViewModel.imageUrl = widget.forum!.imageUrl.toString();
      _selectCategory = widget.forum!.category;
    }

    _forumListViewModel =
        Provider.of<ForumListViewModel>(context, listen: false);
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String description = "";
  String imagePath = "";
  String imageUrl = "";
  String? _selectCategory;
  final List<String> _categories = [
    'Recipe',
    'Preservation methods',
    'Food-thoughts',
    'Food-culture',
  ];
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddForumViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Forum",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<UserViewModel>(
        builder: (context, userViewModel, child) {
          if (userViewModel.user == null) {
            userViewModel.getCurrentUser();
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: kPrimaryColorLight,
                              child: Image.asset(icon),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(userViewModel.user!.name),
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              showTakwImageModal(
                                  context: context,
                                  galleryOnPress: () async {
                                    final pickedFile = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    print(pickedFile!.path);

                                    setState(() {
                                      imagePath = pickedFile.path;
                                    });

                                    Navigator.pop(context);
                                  },
                                  cameraOnPress: () async {
                                    final pickedFile = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    print(pickedFile!.path);
                                    setState(() {
                                      imagePath = pickedFile.path;
                                    });
                                    Navigator.pop(context);
                                  });
                            },
                            icon: Icon(Icons.camera_alt_outlined))
                      ],
                    ),
                  ),
                  if (imagePath != "") ...[
                    Stack(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Image.file(File(imagePath)),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.50),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 11,
                              ),
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
                                  imagePath = "";
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ] else if (imageUrl != "" &&
                      widget.forum!.imageUrl != null) ...[
                    Stack(
                      children: [
                        SizedBox(
                            height: 500,
                            child: Image.network(
                                Config.imageUrl(imageUrl: imageUrl))),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.50),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 11,
                              ),
                              color: Colors.black,
                              onPressed: () async {
                                print(Config.imageUrl(imageUrl: imageUrl));
                                await ForumApiServices.deleteImageForum(
                                    widget.forum!.id.toString());
                                setState(() {
                                  imageUrl = "";
                                });
                                print(imageUrl);
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ] else ...[
                    Container()
                  ],
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        Gtextformfiled(
                            label: "Title",
                            onchange: (text) {
                              vm.title = text;
                            },
                            valid: (text) {
                              return Validater.genaralvalid(text!);
                            },
                            save: (text) {
                              vm.title = text!;
                            },
                            controller: titleController),
                        Gtextformfiled(
                            keybordtype: TextInputType.multiline,
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
                      ],
                    ),
                  ),
                  Genaralbutton(
                    pleft: 100,
                    pright: 100,
                    onpress: () {
                      uploadForum(context, userViewModel.user!.name,userViewModel.user!);
                    },
                    text: "Post",
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void uploadForum(BuildContext context, String author,User user) async {
    if (_form.currentState!.validate()) {
      if (widget.forum != null) {
        setState(() {
          _addForumViewModel.id = widget.forum!.id.toString();
          _addForumViewModel.title = titleController.text;
          _addForumViewModel.description = descriptionController.text;
          _addForumViewModel.author = author;
          _addForumViewModel.category = _selectCategory!;
          print(_selectCategory);
          if (imagePath != "") {
            print('Image path: $imagePath');
            _addForumViewModel.imageUrl = imagePath.toString();
          } else if (imagePath == "" && imageUrl == "") {
            _addForumViewModel.imageUrl = "";
          } else {
            print('Image path is null');
          }
        });
        int res = await _addForumViewModel.updateForum();

        if (res == resOk) {
          await _forumListViewModel.getOwnAllForums();
          openForums(context);
          ToastWidget.toast(msg: "Forum updated successfully");
        } else {
          ToastWidget.toast(msg: "Something went to wrong.");
        }
      } else {
        setState(() {
          _addForumViewModel.author = author;
          _addForumViewModel.imageUrl = imagePath.toString();
        });

        int res = await _addForumViewModel.saveForum();
        if (res == resOk) {
          await _forumListViewModel.getAllForums();
          // openHome(context,user, 1);
          openForums(context);
          ToastWidget.toast(msg: "Forum uploaded successfully");
        } else {
          ToastWidget.toast(msg: "Something went to wrong.");
        }
      }
    }
  }

  _getCategoriesDropDown() {
    return DropdownButton(
      hint: const Text('Select'),
      value: _selectCategory,
      onChanged: (newValue) {
        setState(() {
          _selectCategory = newValue.toString();
          _addForumViewModel.category = (_selectCategory ?? 'none');
        });
      },
      items: _categories.map((category) {
        return DropdownMenuItem(
          child: Text(category),
          value: category,
        );
      }).toList(),
    );
  }
}
