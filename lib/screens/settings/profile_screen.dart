import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_care/models/userModel.dart';

import 'package:food_care/view%20models/user%20view/user_update_view_model.dart';
import 'package:food_care/widgets/app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../services/validate_handeler.dart';
import '../../utils/config.dart';
import '../../utils/constraints.dart';
import '../../widgets/Gtextformfiled.dart';
import '../../widgets/buttons.dart';
import '../../widgets/take_images.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserUpdateViewModel _userUpdateViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userUpdateViewModel =
        Provider.of<UserUpdateViewModel>(context, listen: false);
    nameController.text = widget.user.name;
    mobileController.text = widget.user.phone;
    addressController.text = widget.user.address!;
    emailController.text = widget.user.email;
    passwordController.text = widget.user.password!;
    imageUrl = widget.user.imageUrl.toString();
    _userUpdateViewModel.imageUrl = (widget.user.imageUrl ?? "null");
  }

  String name = '';
  String mobileNumber = '';
  String address = '';
  String email = '';
  String imagePath = '';
  String imageUrl = '';
  String password = '';
  String confirmPassword = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBarWidget(
        text: "My Profile",
        widget: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.0,
                      height: 100.0,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: _getImage(),
                            backgroundColor: kPrimaryColorLight,
                            radius: 50.0,
                          ),
                          Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20.0,
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return TakeImages(
                                          galleryOnPress: () async {
                                        final pickedFile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        print(pickedFile!.path);

                                        setState(() {
                                          imageUrl ="";
                                          imagePath = pickedFile.path;
                                        });

                                        Navigator.pop(context);
                                      }, cameraOnPress: () async {
                                        final pickedFile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera);
                                        print(pickedFile!.path);
                                        setState(() {
                                          imageUrl="";
                                          imagePath = pickedFile.path;
                                        });
                                        Navigator.pop(context);
                                      });
                                    },
                                  );
                                },
                                icon: Icon(Icons.camera_alt),
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gnoiconformfiled(
                        label: "Name",
                        icon: Icons.face_outlined,
                        textinput: TextInputType.name,
                        maxlines: 1,
                        onchange: (text) {
                          name = text;
                        },
                        valid: (text) {
                          return Validater.genaralvalid(text!);
                        },
                        save: (text) {
                          name = text!;
                        },
                        controller: nameController),
                    Gnoiconformfiled(
                        label: "Mobile Number",
                        icon: Icons.phone,
                        textinput: TextInputType.phone,
                        maxlines: 1,
                        onchange: (text) {
                          mobileNumber = text;
                        },
                        valid: (text) {
                          return Validater.validMobile(text!);
                        },
                        save: (text) {
                          mobileNumber = text!;
                        },
                        controller: mobileController),
                    Gnoiconformfiled(
                        label: "Address",
                        icon: Icons.location_on_outlined,
                        textinput: TextInputType.name,
                        maxlines: 1,
                        onchange: (text) {
                          address = text;
                        },
                        valid: (text) {
                          return Validater.genaralvalid(text!);
                        },
                        save: (text) {
                          address = text!;
                        },
                        controller: addressController),
                    Gnoiconformfiled(
                        label: "Email",
                        icon: Icons.email_outlined,
                        textinput: TextInputType.emailAddress,
                        maxlines: 1,
                        onchange: (text) {
                          email = text;
                        },
                        valid: (text) {
                          return Validater.validEmail(text!);
                        },
                        save: (text) {
                          email = text!;
                        },
                        controller: emailController),
                  ],
                ),
              ),
              Genaralbutton(
                pleft: 100,
                pright: 100,
                onpress: () {
                  _updateUser();
                },
                text: "Update",
              ),
            ],
          ),
        ));
  }

  _getImage() {
    if (imageUrl == "null") {
      return AssetImage(icon.toString());
    } else {
      if (imagePath == "") {
        return NetworkImage(Config.imageUrl(imageUrl: imageUrl));
      } else {
        return FileImage(File(imagePath));
      }
    }
  }

  _updateUser() async {
    setState(() {
      _userUpdateViewModel.id = widget.user.id.toString();
      _userUpdateViewModel.name = name;
      _userUpdateViewModel.phone = mobileNumber;
      _userUpdateViewModel.address = address;
      _userUpdateViewModel.email = email;

      if (imagePath != "") {
        print('Image path: $imagePath');
        _userUpdateViewModel.imageUrl = imagePath.toString();
      } else if (imagePath == "" && imageUrl == "") {
        _userUpdateViewModel.imageUrl = "";
      } else {
        print('Image path is null');
      }
    });
    print(widget.user.id);
    await _userUpdateViewModel.updateUser();
    Navigator.pop(context);
  }
}
