import 'dart:convert';

import 'package:food_care/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../models/map model/placeDetails.dart';
import '../../models/map model/placeModel.dart';

class MapServices {
  static Future<List<Place>> fetchPlacesByKeyword(
      {required String placeKeyword}) async {
    final url = Config.urlForFindPlace(place: placeKeyword);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final Iterable results = jsonResponse['candidates'];

      return results.map((places) => Place.fromJson(places)).toList();
    } else {
      throw ('Unable to perform request.');
    }
  }

  static Future<String>? placeAutoComplete(String query) async {
    final url = Config.urlForSearchPlace(searchPlace: query);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ('Unable to perform request.');
    }
  }

  static Future<PlaceDetails> getPlaceDetails(String placeId) async {
    final url = Config.getPlaceDetails(placeId: placeId);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decodedBody =
          jsonDecode(response.body) as Map<String, dynamic>;
      return PlaceDetails.fromJson(decodedBody);
    } else {
      throw ('Unable to perform request.');
    }
  }

  static void openMapApp(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
