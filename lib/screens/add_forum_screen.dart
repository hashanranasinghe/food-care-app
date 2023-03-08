// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_care/models/forumModel.dart';
import 'package:food_care/services/api%20services/forum_api_services.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/forum%20view/forum_add_view_model.dart';
import 'package:food_care/view%20models/forum%20view/forum_list-view_model.dart';
import 'package:food_care/view%20models/userViewModel.dart';
import 'package:food_care/widgets/Gtextformfiled.dart';
import 'package:food_care/widgets/app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../services/validate_handeler.dart';
import '../utils/config.dart';
import '../widgets/buttons.dart';

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
    if (widget.forum != null) {
      titleController.text = widget.forum!.title;
      descriptionController.text = widget.forum!.description;
      imageUrl = widget.forum!.imageUrl.toString();
    }
    _addForumViewModel = Provider.of<AddForumViewModel>(context, listen: false);
    _forumListViewModel =
        Provider.of<ForumListViewModel>(context, listen: false);
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String description = "";
  String imagePath = "";
  String imageUrl = "";

  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddForumViewModel>(context);
    return AppBarWidget(
        text: "Add Post",
        widget: Consumer<UserViewModel>(
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
                                backgroundColor: kPrimaryColorlight,
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
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _takeImage(context);
                                  },
                                );
                              },
                              icon: Icon(Icons.camera_alt_outlined))
                        ],
                      ),
                    ),
                    if (imagePath != "") ...[
                      SizedBox(height: 200, child: Image.file(File(imagePath)))
                    ] else if (imageUrl != "") ...[
                      SizedBox(
                          height: 500,
                          child: Image.network(
                              'http://${'${Config.apiURL}\\$imageUrl'}'
                                  .replaceAll('\\', '/')))
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
                        ],
                      ),
                    ),
                    Genaralbutton(
                      pleft: 100,
                      pright: 100,
                      onpress: () {
                        uploadForum(context, author: userViewModel.user!.name);
                      },
                      text: "Upload",
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }

  void uploadForum(BuildContext context, {required String author}) async {
    if (_form.currentState!.validate()) {
      if (widget.forum != null) {
        setState(() {
          _addForumViewModel.id = widget.forum!.id.toString();
          _addForumViewModel.title = titleController.text;
          _addForumViewModel.description = descriptionController.text;
          _addForumViewModel.author = author;
          if (imagePath != "") {
            print('Image path: $imagePath');
            _addForumViewModel.imageUrl = imagePath.toString();
          } else {
            print('Image path is null');
          }
        });
        await _addForumViewModel.updateForum();
        await _forumListViewModel.getOwnAllForums();
        print("ok");
      } else {
        setState(() {
          _addForumViewModel.author = author;
          _addForumViewModel.imageUrl = imagePath.toString();
        });

        await _addForumViewModel.saveForum();
        await _forumListViewModel.getAllForums();
      }

      Navigator.pop(context);
    }
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
