import 'package:flutter/cupertino.dart';
import 'package:food_care/services/api%20services/food_api_services.dart';
import 'food_post_view_model.dart';

enum Status { loading, empty, success }

class FoodPostListViewModel extends ChangeNotifier {
  List<FoodPostViewModel> foods = <FoodPostViewModel>[];
  Status status = Status.empty;

  Future<void> getAllFoodPosts() async {
    status = Status.loading;
    final results = await FoodApiServices.getFoodPosts();
    results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    foods = results
        .where(
            (food) => food.isShared == false) // filter for true elements only
        .map((food) => FoodPostViewModel(food: food))
        .toList();
    status = foods.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }

  Future<void> getAllOwnFoodPosts() async {
    status = Status.loading;
    final results = await FoodApiServices.getOwnFoodPosts();
    results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    foods = results.map((food) => FoodPostViewModel(food: food)).toList();
    status = foods.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }
}
