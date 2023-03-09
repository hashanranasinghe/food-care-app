import 'dart:convert';
import 'package:food_care/services/store_token.dart';
import 'package:http/http.dart' as http;
import '../../models/foodPostModel.dart';
import '../../utils/config.dart';

class FoodApiServices {
  static var client = http.Client();

  static Future<List<Food>> getFoodPosts() async {
    // Get the JWT token from secure storage
    String? token = await StoreToken.getToken();

    // Send a GET request to the API with the token in the Authorization header
    final response = await client.get(
      Uri.http(Config.apiURL, Config.getFoodPosts),
      headers: {'Authorization': 'Bearer $token'},
    );

    // Check if the response was successful and parse the forum information
    if (response.statusCode == 200) {
      final List<dynamic> foodJsonList = json.decode(response.body);
      List<Food> foodList =
          foodJsonList.map((foodJson) => Food.fromJson(foodJson)).toList();
      print(foodList);
      return foodList;
    } else {
      throw Exception('Failed to get forums');
    }
  }

  static Future<void> createFoodPost({required Food food}) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.http(Config.apiURL, Config.getFoodPosts));
      String? token = await StoreToken.getToken();
      request.headers.addAll({'Authorization': 'Bearer $token'});
      request.fields['title'] = food.title;
      request.fields['description'] = food.description;
      request.fields['quantity'] = food.quantity.toString();
      request.fields['other'] = food.other.toString();
      request.fields['pickupTimes'] = food.pickupTimes;
      request.fields['listDays'] = food.listDays;
      request.fields['location[lan]'] = food.location.lan.toString();
      request.fields['location[lon]'] = food.location.lon.toString();
      for (var file in food.imageUrls) {
        request.files
            .add(await http.MultipartFile.fromPath('imageUrls', file.path));
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Food post uploaded.');
      } else {
        print('Failed to upload food post.');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
