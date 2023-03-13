import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_care/widgets/take_images.dart';

import 'dash_line.dart';

class ShowServerImages extends StatelessWidget {
  final List<String> imageUrls;
  final Function galleryOnPress;
  final Function cameraOnPress;
  const ShowServerImages(
      {Key? key,
        required this.imageUrls,
        required this.galleryOnPress,
        required this.cameraOnPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (imageUrls.isEmpty) ...[
            Container()
          ] else ...[
            _showImages(imageUrls: imageUrls)
          ],
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return TakeImages(galleryOnPress: () async {
                      await galleryOnPress();
                    }, cameraOnPress: () async {
                      await cameraOnPress();
                    });
                  },
                );
              },
              child: DashedSquare(
                size: 120,
                strokeWidth: 2.5,
                borderRadius: 10,
                icon: Icons.camera_alt_outlined,
                iconSize: 60,
              ),
            ),
          ),
          Text("Add upto 5 images"),
        ],
      ),
    );
  }

  Widget _showImages({required List<String> imageUrls}) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          final image = imageUrls[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 140.0,
              height: 140.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover)),
            ),
          );
        },
      ),
    );
  }
}
