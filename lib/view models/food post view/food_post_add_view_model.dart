import 'package:flutter/cupertino.dart';
import 'package:food_care/services/api%20services/food_api_services.dart';

import '../../models/foodPostModel.dart';

class FoodPostAddViewModel extends ChangeNotifier {
  late String id;
  late String userId;
  late String author;
  late String title;
  late String description;
  late String quantity;

  late String category;
  late bool isShared;
  late Location location;
  late AvailableTime availableTime;
  late List<dynamic> requests;
  late List<dynamic> acceptRequests;
  late List<String> imageUrls;
  late DateTime createdAt;
  late DateTime updatedAt;

  Future<int> saveFoodPost() async {
    final foodPost = Food(
        author: author,
        title: title,
        description: description,
        quantity: quantity,

        isShared: isShared,
        requests: requests = [],
        acceptRequests: acceptRequests=[],
        location: location,
        category: category,
        availableTime: availableTime,
        imageUrls: imageUrls,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
    int res = await FoodApiServices.createFoodPost(food: foodPost);

    notifyListeners();
    return res;
  }

  Future<int> updateFoodPost() async {
    imageUrls = imageUrls
        .where((element) => element.contains('com.example.food_care'))
        .toList();
    final foodPost = Food(
        id: id,
        author: author,
        title: title,
        description: description,
        quantity: quantity,

        isShared: isShared,
        requests: requests,
        acceptRequests: acceptRequests ?? [],
        category: category,
        availableTime: availableTime,
        location: location,
        imageUrls: imageUrls,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());

    int res = await FoodApiServices.updateFoodPost(food: foodPost);
    notifyListeners();
    return res;
  }
}
