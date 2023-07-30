import '../../models/foodPostModel.dart';

class FoodPostViewModel {
  final Food food;

  FoodPostViewModel({required this.food});

  String? get id {
    return food.id;
  }

  String? get author {
    return food.author;
  }

  String? get userId {
    return food.userId;
  }

  String get title {
    return food.title;
  }

  String get description {
    return food.description;
  }

  String get quantity {
    return food.quantity;
  }

  String get category {
    return food.category;
  }

  List<dynamic> get imageUrls {
    return food.imageUrls;
  }

  String? get listDays {
    return food.listDays;
  }

  bool get isShared {
    return food.isShared;
  }

  List<dynamic> get requests {
    return food.requests;
  }

  List<dynamic> get acceptRequest {
    return food.acceptRequests;
  }

  Location get location {
    return food.location;
  }

  AvailableTime get availableTime {
    return food.availableTime;
  }

  DateTime get createdAt {
    return food.createdAt;
  }

  DateTime get updatedAt {
    return food.updatedAt;
  }
}
