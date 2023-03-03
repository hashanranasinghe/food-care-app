import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/widgets/Gtextformfiled.dart';
import 'package:food_care/widgets/app_bar.dart';

import '../services/validate_handeler.dart';
import '../widgets/buttons.dart';

class AddForumScreen extends StatefulWidget {
  const AddForumScreen({Key? key}) : super(key: key);

  @override
  State<AddForumScreen> createState() => _AddForumScreenState();
}

class _AddForumScreenState extends State<AddForumScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String title = "";
  String description = "";
  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
        text: "Add Post",
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kPrimaryColorlight,
                        child: Image.asset(image),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Hashan Ranasinghe"),
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.camera_alt_outlined))
                ],
              ),
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
            Genaralbutton(
              pleft: 100,
              pright: 100,
              onpress: () {},
              text: "Upload",
            ),
          ],
        ));
  }
}
