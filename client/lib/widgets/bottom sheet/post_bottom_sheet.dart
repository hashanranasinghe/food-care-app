import 'package:flutter/material.dart';
import 'package:food_care/widgets/popup_dialog.dart';

void showPostModal(
    {required BuildContext context,
    required Function delete,
    required Function update,
    required String updtText,
    required String delteText}) {
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Color(0xFFF5F8F9),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    ),
    context: context,
    builder: (BuildContext context) {
      final size = MediaQuery.of(context).size;
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1, vertical: size.height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
              child: GestureDetector(
                  onTap: () async {
                    update();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        updtText,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  )),
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
              child: GestureDetector(
                  onTap: () async {
                    PopupDialog.showPopupWarning(
                        context, "Do you want to delete this post?", "",
                        () async {
                      delete();
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(delteText,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      const Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  )),
            ),
          ],
        ),
      );
    },
  );
}
