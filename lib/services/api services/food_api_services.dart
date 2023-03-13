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

  static Future<Food> getFoodPost({required String foodId}) async {
    String? token = await StoreToken.getToken();
    final response = await client.get(
      Uri.http(Config.apiURL, Config.getFoodPost(id: foodId)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final foodJson = jsonDecode(response.body);
      final food = Food.fromJson(foodJson);
      return food;
    } else if (response.statusCode == 404) {
      throw Exception('Food post not found');
    } else {
      throw Exception('Failed to get food post');
    }
  }

  static Future<void> createFoodPost({required Food food}) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.http(Config.apiURL, Config.getFoodPosts));
      String? token = await StoreToken.getToken();
      request.headers.addAll({'Authorization': 'Bearer $token'});
      request.fields['title'] = food.title;
      request.fields['author'] = food.author.toString();
      request.fields['description'] = food.description;
      request.fields['quantity'] = food.quantity.toString();
      request.fields['other'] = food.other.toString();
      request.fields['pickupTimes'] = food.pickupTimes;
      request.fields['listDays'] = food.listDays;
      request.fields['location[lan]'] = food.location.lan.toString();
      request.fields['location[lon]'] = food.location.lon.toString();
      for (var file in food.imageUrls) {
        request.files.add(await http.MultipartFile.fromPath('imageUrls', file));
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

  //get own foods
  static Future<List<Food>> getOwnFoodPosts() async {
    String? token = await StoreToken.getToken();
    final response = await client.get(
      Uri.http(Config.apiURL, Config.getOwnFoods),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList.map((json) => Food.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get foods: ${response.statusCode}');
    }
  }

  //get a own food
  static Future<Food> getOwnFoodPost({required String foodId}) async {
    String? token = await StoreToken.getToken();
    final response = await client.get(
      Uri.http(Config.apiURL, Config.getOwnFoodPost(id: foodId)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Forum found
      final foodJson = jsonDecode(response.body);
      final food = Food.fromJson(foodJson);
      return food;
    } else if (response.statusCode == 404) {
      // Forum not found
      throw Exception('Food post not found');
    } else {
      // Other error
      throw Exception('Failed to get food post');
    }
  }

  //delete food
  static Future<void> deleteFoodPost({required String foodId}) async {
    // Get the JWT token from secure storage
    String? token = await StoreToken.getToken();

    final response = await client.delete(
      Uri.http(Config.apiURL, Config.getOwnFoodPost(id: foodId)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Forum deleted successfully
      print('Forum deleted successfully');
    } else {
      // Forum not found or other error
      print('Failed to delete forum');
    }
  }
}
