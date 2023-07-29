import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_care/models/map%20model/placeAutoCompleteModel.dart';

import 'package:food_care/view%20models/map_view/place_list_view_model.dart';
import 'package:food_care/widgets/buttons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/foodPostModel.dart';
import '../../models/map model/autoCompletePredictionModel.dart';
import '../../models/map model/placeDetails.dart';
import '../../services/api services/map_services.dart';
import '../../view models/food post view/food_post_add_view_model.dart';
import '../../view models/map_view/place_view_model.dart';

class MapScreen extends StatefulWidget {
  Location? location;
  MapScreen({Key? key, this.location}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<AutocompletePrediction> placePredictions = [];
  bool isListViewVisible = false;
  late FoodPostAddViewModel fm;
  final Completer<GoogleMapController> _controller = Completer();
  TextEditingController searchController = TextEditingController();
  PlaceDetails? selectedPlace;
  String? id;
  late Position position;
  LatLng? selectedLocation;

  @override
  void initState() {
    fm = Provider.of<FoodPostAddViewModel>(context, listen: false);
    super.initState();
  }

  void autoComplete(String query) async {
    final response = await MapServices.placeAutoComplete(query);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
          isListViewVisible = true;
        });
      }
    }
  }

  Future<void> _onMapCreated(GoogleMapController googleMapController) async {
        _controller.complete(googleMapController);
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (selectedLocation != null) {
      googleMapController.animateCamera(
        CameraUpdate.newLatLng(selectedLocation!),
      );
    } else {
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 14,
          ),
        ),
      );
    }
  }

  void _handleMapTap(LatLng tappedLocation) {
    setState(() {
      selectedLocation = tappedLocation;
    });
  }

  Set<Marker> _getPlaceMarkers(List<PlaceViewModel> places) {
    final markers = places.map((place) {
      return Marker(
        markerId: MarkerId(place.placeId),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: place.name),
        position: LatLng(place.latitude, place.longitude),
      );
    }).toSet();

    if (selectedPlace != null) {
      markers.add(
        Marker(
          markerId: MarkerId(id.toString()),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(title: selectedPlace?.name),
          position: LatLng(selectedPlace!.latitude, selectedPlace!.longitude),
        ),
      );
    }
    if (selectedLocation != null) {
      markers.add(
        Marker(
          markerId: MarkerId(id.toString()),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          position:
              LatLng(selectedLocation!.latitude, selectedLocation!.longitude),
        ),
      );
    }
    if (widget.location!.lan != "0.0") {
      markers.add(
        Marker(
          markerId: MarkerId('passed_location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: 'Passed Location'),
          position: LatLng(double.parse(widget.location!.lan),
              double.parse(widget.location!.lon)),
        ),
      );
    }
    return markers;
  }

  void onPlaceSelected(PlaceDetails place) async {
    setState(() {
      selectedPlace = place;
      isListViewVisible = false;
    });
    final controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newLatLng(LatLng(place.latitude, place.longitude)));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final vm = Provider.of<PlaceListViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      if (value.isEmpty || value == "") {
                        setState(() {
                          placePredictions = [];
                          isListViewVisible = false;
                        });
                      } else {
                        autoComplete(value);
                        isListViewVisible = true;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Search Here..",
                        fillColor: Colors.white,
                        filled: true),
                  ),
                ),
                Visibility(
                  visible: isListViewVisible,
                  child: Expanded(
                    child: ListView.builder(
                        itemCount: placePredictions.length,
                        itemBuilder: (context, index) {
                          print(placePredictions.length);
                          return ListTile(
                            onTap: () async {
                              id = placePredictions[index].placeId.toString();
                              final place = await MapServices.getPlaceDetails(
                                  placePredictions[index].placeId.toString());
                              onPlaceSelected(place);
                              print(place.longitude);
                            },
                            title: Text(
                                placePredictions[index].description.toString()),
                          );
                        }),
                  ),
                ),
                Expanded(
                  child: GoogleMap(
                    onTap: (latLng) {
                      _handleMapTap(latLng);
                    },
                    markers: _getPlaceMarkers(vm.places),
                    myLocationEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(37.4247821285061, -122.08401404332771),
                        zoom: 14),
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 0.0,
                left: screenWidth * 0.3,
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                  child: Genaralbutton(
                    onpress: () {
                      if (selectedLocation != null) {
                        fm.location = Location(
                            lan: selectedLocation != null
                                ? selectedLocation!.latitude.toString()
                                : position.latitude.toString(),
                            lon: selectedLocation != null
                                ? selectedLocation!.longitude.toString()
                                : position.longitude.toString());
                      } else {
                        fm.location = Location(
                            lan: selectedPlace != null
                                ? selectedPlace!.latitude.toString()
                                : position.latitude.toString(),
                            lon: selectedPlace != null
                                ? selectedPlace!.longitude.toString()
                                : position.longitude.toString());
                      }

                      Navigator.pop(context);
                    },
                    text: "Set up pickup location",
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
