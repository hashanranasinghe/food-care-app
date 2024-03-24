import 'package:flutter/cupertino.dart';
import 'package:food_care/models/filterModel.dart';
import 'package:food_care/services/api%20services/food_api_services.dart';
import 'package:food_care/services/api%20services/user_api_services.dart';
import 'package:food_care/services/date.dart';
import 'package:food_care/utils/config.dart';
import 'package:geolocator/geolocator.dart';
import 'food_post_view_model.dart';

enum Status { loading, empty, success }

class FoodPostListViewModel extends ChangeNotifier {
  List<FoodPostViewModel> foods = <FoodPostViewModel>[];
  List<FoodPostViewModel> ownFoods = <FoodPostViewModel>[];
  List<FoodPostViewModel> requetedFoods = <FoodPostViewModel>[];
  List<FoodPostViewModel> acceptedFoods = <FoodPostViewModel>[];
  List<FoodPostViewModel> completedFoods = <FoodPostViewModel>[];
  List<FoodPostViewModel> requetedMyFoods = <FoodPostViewModel>[];
  List<FoodPostViewModel> acceptedMyFoods = <FoodPostViewModel>[];
  List<FoodPostViewModel> completedMyFoods = <FoodPostViewModel>[];
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
          return distanceInMeters <= maxDistanceInMeters && !food.isComplete;
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
          return distanceInMeters <= maxDistanceInMeters && !food.isComplete;
        })
        .map((food) => FoodPostViewModel(food: food))
        .toList();
    if (filterModel.sortByCloset == true) {
      foods.sort((a, b) => calculateDistance(a, currentPosition)
          .compareTo(calculateDistance(b, currentPosition)));
    }

    if (filterModel.category != null) {
      foods =
          foods.where((food) => food.category == filterModel.category).toList();
    }
    if (filterModel.hours != null) {
      foods = foods
          .where((food) =>
              Date.parseHours(filterModel.hours.toString()) >
              Date.calculateTimeDifference(
                  food.availableTime.startTime, food.availableTime.endTime))
          .toList();
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
    ownFoods = results.map((food) => FoodPostViewModel(food: food)).toList();
    status = ownFoods.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }

  Future<void> getAllRequestedFood() async {
    status = Status.loading;
    final results =
        await FoodApiServices.getRequestFoodPosts(Config.getRequestsFood);
    results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    requetedFoods =
        results.map((food) => FoodPostViewModel(food: food)).toList();
    status = requetedFoods.isEmpty ? Status.empty : Status.success;
    notifyListeners();
  }

  Future<void> getAllMyRequestedFood() async {
    status = Status.loading;
    final results = await UserAPiServices.getRequestsFood(
        path: Config.getUserRequest, complete: "NO", permission: "PENDING");
    results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    requetedMyFoods =
        results.map((food) => FoodPostViewModel(food: food)).toList();
    status = requetedMyFoods.isEmpty ? Status.empty : Status.success;
    notifyListeners();
  }

  Future<void> getAcceptFoodPosts() async {
    status = Status.loading;
    final results =
        await FoodApiServices.getRequestFoodPosts(Config.getAcceptFood);
    results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    acceptedFoods =
        results.map((food) => FoodPostViewModel(food: food)).toList();
    status = acceptedFoods.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }

  Future<void> getMyAcceptFoodPosts() async {
    status = Status.loading;
    final results = await UserAPiServices.getRequestsFood(
        path: Config.getUserRequest, complete: "NO", permission: "ACCEPT");
    results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    acceptedMyFoods =
        results.map((food) => FoodPostViewModel(food: food)).toList();
    status = acceptedMyFoods.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }

  Future<void> getCompleteFoodPosts() async {
    status = Status.loading;
    final results =
        await FoodApiServices.getRequestFoodPosts(Config.getCompleteFood);
    results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    completedFoods =
        results.map((food) => FoodPostViewModel(food: food)).toList();
    status = completedFoods.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }

  Future<void> getMyCompleteFoodPosts() async {
    status = Status.loading;
    final results = await UserAPiServices.getRequestsFood(
        path: Config.getUserRequest,
        complete: "COMPLETE",
        permission: "ACCEPT");
    results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    completedMyFoods =
        results.map((food) => FoodPostViewModel(food: food)).toList();
    status = completedMyFoods.isEmpty ? Status.empty : Status.success;

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
          return distanceInMeters <= maxDistanceInMeters && !food.isComplete;
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
