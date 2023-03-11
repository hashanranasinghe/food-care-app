import 'package:flutter/material.dart';
import 'package:food_care/widgets/popup_dialog.dart';

import '../utils/constraints.dart';

class UpdateNDelete extends StatelessWidget {
  final Function update;
  final Function delete;
  const UpdateNDelete({Key? key, required this.update, required this.delete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () async {
                    update();
                  },
                  child: const Text(
                    'Update Forum',
                    style: TextStyle(
                      color: kPrimaryColordark,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                TextButton(
                  onPressed: () async {
                    PopupDialog.showPopupWarning(
                        context,
                        "Do you want to delete this post?",
                        "description",
                        () async {
                          delete();
                        });
                  },
                  child: const Text(
                    'Delete  Forum',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                    ),
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
