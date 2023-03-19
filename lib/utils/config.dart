class Config {
  //user
  static const String appName = "FoodCare App";
  static const String apiURL = "10.0.2.2:5001";
  //static const String apiURL ="192.168.0.101:5001";
  static const String loginUserAPI = "/api/users/login";
  static const String registerUserAPI = "/api/users/register";
  static const String currentUserAPI = "/api/users/current";
  static const String users = "/api/users/users";

  static String updateUser({required String id}) {
    String path = "api/users/update/$id";
    return path;
  }

  static String getUser(String id) {
    String path = "api/users/user/$id";
    return path;
  }

  //forum
  static const String getApostForums = "/api/forums";
  static const String getOwnForums = "/api/forums/ownforums";

  static String getOwnForum({required String id}) {
    String path = "/api/forums/ownforums/$id";
    return path;
  }
  static String deleteOwnForumImage({required String id}) {
    String path = "/api/forums/ownforums/$id/image";
    return path;
  }

  static String likeForum({required String id}) {
    String path = "/api/forums/$id/like";
    return path;
  }

  static String commentForum({required String id}) {
    String path = "/api/forums/$id/comment";
    return path;
  }

  //food
  static const String getFoodPosts = "/api/food";
  static const String getOwnFoods = "api/food/ownfood";

  static String getOwnFoodPost({required String id}) {
    String path = "api/food/ownfood/$id";
    return path;
  }

  static String getOwnFoodPostImages({required String id}) {
    String path = "api/food/ownfood/$id/images";
    return path;
  }

  static String getFoodPost({required String id}) {
    String path = "api/food/$id";
    return path;
  }

  //image
  static String imageUrl({required String imageUrl}) {
    String url = 'http://${'$apiURL\\$imageUrl'}'.replaceAll('\\', '/');
    return url;
  }
}
