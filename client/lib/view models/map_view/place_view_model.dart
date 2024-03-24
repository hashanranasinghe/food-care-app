import '../../models/map model/placeModel.dart';

class PlaceViewModel {
  final Place place;

  PlaceViewModel({required this.place});

  String get placeId {
    return place.placeId;
  }

  String get name {
    return place.name;
  }

  double get latitude {
    return place.latitude;
  }

  double get longitude {
    return place.longitude;
  }
}
