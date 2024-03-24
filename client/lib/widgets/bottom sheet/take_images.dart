import 'package:flutter/material.dart';

void showTakwImageModal(
    {required BuildContext context,
    required Function galleryOnPress,
    required Function cameraOnPress}) {
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
            horizontal: size.width * 0.05, vertical: size.height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
              child: GestureDetector(
                onTap: () async {
                  await cameraOnPress();
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
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
              child: GestureDetector(
                  onTap: () async {
                    await galleryOnPress();
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
                  )),
            ),
          ],
        ),
      );
    },
  );
}
