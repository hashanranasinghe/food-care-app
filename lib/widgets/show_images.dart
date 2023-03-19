import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/food_api_services.dart';
import 'package:food_care/widgets/take_images.dart';

import 'dash_line.dart';

class ShowImages extends StatefulWidget {
  final String? foodId;
  final List<String> imagePaths;
  final Function galleryOnPress;
  final Function cameraOnPress;
  const ShowImages({
    Key? key,
    required this.imagePaths,
    required this.galleryOnPress,
    required this.cameraOnPress, this.foodId,
  }) : super(key: key);

  @override
  State<ShowImages> createState() => _ShowImagesState();
}

class _ShowImagesState extends State<ShowImages> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (widget.imagePaths.isEmpty) ...[
            Container()
          ] else ...[
            _showImages(imagePaths: widget.imagePaths)
          ],
          if(widget.imagePaths.length<5)...[Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return TakeImages(galleryOnPress: () async {
                      await widget.galleryOnPress();
                    }, cameraOnPress: () async {
                      await widget.cameraOnPress();
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
          Text("Add upto 5 images"),]else...[
            Container(),
          ]
        ],
      ),
    );
  }

  Widget _showImages({required List<String> imagePaths}) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: imagePaths.length,
        itemBuilder: (BuildContext context, int index) {
          var image = widget.imagePaths[index];
          print(image);
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: image.contains("http")
                              ? NetworkImage(image) as ImageProvider<Object>
                              : FileImage(File(image)),
                          fit: BoxFit.cover)),
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
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
                      setState(() {
                        if(image.contains('http')){
                          FoodApiServices.deleteFoodPostImages(foodId:widget.foodId.toString());
                          widget.imagePaths.removeAt(index);
                        }else{
                          widget.imagePaths.removeAt(index);
                        }

                      });
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
