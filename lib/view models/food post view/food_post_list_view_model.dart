import 'package:flutter/cupertino.dart';
import 'package:food_care/models/filterModel.dart';
import 'package:food_care/services/api%20services/food_api_services.dart';
import 'package:geolocator/geolocator.dart';
import 'food_post_view_model.dart';

enum Status { loading, empty, success }

class FoodPostListViewModel extends ChangeNotifier {
  List<FoodPostViewModel> foods = <FoodPostViewModel>[];
  Status status = Status.empty;

  // Future<void> getAllFoodPosts() async {
  //   status = Status.loading;
  //   final results = await FoodApiServices.getFoodPosts();
  //   results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  //   foods = results
  //       .where(
  //           (food) => (food.isShared == false)) // filter for true elements only
  //       .map((food) => FoodPostViewModel(food: food))
  //       .toList();
  //   status = foods.isEmpty ? Status.empty : Status.success;
  //
  //   notifyListeners();
  // }

  Future<void> getAllFoodPosts() async {
    status = Status.loading;

    // Get the current location
    Position currentPosition = await Geolocator.getCurrentPosition();

    final results = await FoodApiServices.getFoodPosts();

    // Sort the food posts by creation time
    results.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    foods = results
        .where((food) {
          // Calculate the distance between the current location and the food post's location
          double distanceInMeters = Geolocator.distanceBetween(
            currentPosition.latitude,
            currentPosition.longitude,
            double.parse(food.location.lan),
            double.parse(food.location.lon),
          );

          // Filter for food posts within a certain radius (e.g., 25 kilometers)
          double maxDistanceInMeters = 25000; // Adjust this value as needed
          return distanceInMeters <= maxDistanceInMeters && !food.isShared;
        })
        .map((food) => FoodPostViewModel(food: food))
        .toList();

    status = foods.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }

  Future<void> getAllFilterFoodPosts(FilterModel filterModel) async {
    status = Status.loading;

    // Get the current location
    Position currentPosition = await Geolocator.getCurrentPosition();

    final results = await FoodApiServices.getFoodPosts();

    // Sort the food posts by creation time
    results.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    foods = results
        .where((food) {
          // Calculate the distance between the current location and the food post's location
          double distanceInMeters = Geolocator.distanceBetween(
            currentPosition.latitude,
            currentPosition.longitude,
            double.parse(food.location.lan),
            double.parse(food.location.lon),
          );

          // Filter for food posts within a certain radius (e.g., 25 kilometers)
          double maxDistanceInMeters = 25000; // Adjust this value as needed
          return distanceInMeters <= maxDistanceInMeters && !food.isShared;
        })
        .map((food) => FoodPostViewModel(food: food))
        .toList();
    if (filterModel.sortByCloset == true) {
      foods.sort((a, b) => calculateDistance(a, currentPosition)
          .compareTo(calculateDistance(b, currentPosition)));
    }

    status = foods.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }

  double calculateDistance(FoodPostViewModel food, Position currentPosition) {
    return Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      double.parse(food.location.lan),
      double.parse(food.location.lon),
    );
  }

  Future<void> getAllRequestedFoodPosts({required String id}) async {
    status = Status.loading;
    final results = await FoodApiServices.getFoodPosts();

    // Sort the food posts by creation time
    results.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    foods = results
        .where((food) => food.requests.contains(id))
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

  Future<void> getSearchFood({required String query}) async {
    status = Status.loading;
    // Get the current location
    Position currentPosition = await Geolocator.getCurrentPosition();

    final results = await FoodApiServices.getFoodPosts();

    // Sort the food posts by creation time
    results.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    foods = results
        .where((food) {
          // Calculate the distance between the current location and the food post's location
          double distanceInMeters = Geolocator.distanceBetween(
            currentPosition.latitude,
            currentPosition.longitude,
            double.parse(food.location.lan),
            double.parse(food.location.lon),
          );

          // Filter for food posts within a certain radius (e.g., 25 kilometers)
          double maxDistanceInMeters = 25000; // Adjust this value as needed
          return distanceInMeters <= maxDistanceInMeters && !food.isShared;
        })
        .map((food) => FoodPostViewModel(food: food))
        .toList();
    foods = foods
        .where((food) => food.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    status = foods.isEmpty ? Status.empty : Status.success;
    notifyListeners();
  }
}
