import 'package:flutter/material.dart';
import 'package:food_care/services/api%20services/map_services.dart';
import 'package:food_care/view%20models/map_view/place_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceListViewModel extends ChangeNotifier {
  var places = <PlaceViewModel>[];
  // var mapType = MapType.normal;
  //
  // void toggleMapType() {
  //   mapType = mapType == MapType.normal ? MapType.satellite : MapType.normal;
  //   notifyListeners();
  // }

  Future<void> fetchPlacesByKeywordAndPosition(String keyword) async {
    final results =
        await MapServices.fetchPlacesByKeyword(placeKeyword: keyword);

    places = results.map((place) => PlaceViewModel(place: place)).toList();
    notifyListeners();
  }
}
