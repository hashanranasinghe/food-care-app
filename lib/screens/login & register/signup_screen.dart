import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_care/models/userModel.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/widgets/Gtextformfiled.dart';
import 'package:food_care/widgets/buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../services/api services/user_api_services.dart';
import '../../services/validate_handeler.dart';
import '../../widgets/flutter_toast.dart';
import '../../widgets/take_images.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String name = '';
  String mobileNumber = '';
  String address = '';
  String email = '';
  String imagePath = '';
  String password = '';
  String confirmPassword = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var uuid = const Uuid();
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.05),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        )),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Text("Profile Picture"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
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
                                          imagePath = pickedFile.path;
                                        });

                                        Navigator.pop(context);
                                      }, cameraOnPress: () async {
                                        final pickedFile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera);
                                        print(pickedFile!.path);
                                        setState(() {
                                          imagePath = pickedFile.path;
                                        });
                                        Navigator.pop(context);
                                      });
                                    },
                                  );
                                },
                                icon: Icon(Icons.camera_alt_outlined)),
                          )
                        ],
                      ),
                    ),
                    if (imagePath != "") ...[
                      SizedBox(height: 200, child: Image.file(File(imagePath)))
                    ] else ...[
                      Container()
                    ],
                    Gpasswordformfiled(
                      valid: (text) {
                        return Validater.signupPassword(text!);
                      },
                      icon: Icons.lock_outline,
                      onchange: (text) {
                        password = text;
                      },
                      save: (text) {
                        password = text!;
                      },
                    ),
                    Gpasswordformfiled(
                      hintText: "Confirm Password",
                      valid: (text) {
                        return Validater.confirmPassword(password, text!);
                      },
                      icon: Icons.lock_outline,
                      onchange: (text) {
                        confirmPassword = text;
                      },
                      save: (text) {
                        confirmPassword = text!;
                      },
                    ),
                  ],
                ),
              ),
              Genaralbutton(
                pleft: 100,
                pright: 100,
                onpress: () {
                  userRegistration();
                },
                text: "Sign Up",
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ?",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                          color: kPrimaryColorDark,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      openUserSignIn(context);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void userRegistration() async {
    if (_form.currentState!.validate()) {
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      User user = User(
          name: name,
          email: email,
          phone: mobileNumber,
          isVerify: false,
          verificationToken: uuid.v4(),
          address: address,
          imageUrl: imagePath,
          deviceToken: [deviceToken],
          foodRequest: [],
          password: password);

      int res = await UserAPiServices.registerUser(user);

      print(res);
      if (res == resOk) {
        openUserSignIn(context);
        ToastWidget.toast(msg: "Verification Email is sent.");
      } else {
        ToastWidget.toast(msg: "Something went to wrong.");
      }
    }
  }
}
