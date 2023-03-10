import 'package:flutter/material.dart';

class TakeImages extends StatelessWidget {
  final Function galleryOnPress;
  final Function cameraOnPress;
  const TakeImages(
      {Key? key, required this.galleryOnPress, required this.cameraOnPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 16),
                InkWell(
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
