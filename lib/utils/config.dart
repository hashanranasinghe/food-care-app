class Config {
  //user
  static const String appName = "FoodCare App";
  static const String apiURL = "10.0.2.2:5001"; //192.168.0.100
  static const String loginUserAPI = "/api/users/login";
  static const String registerUserAPI = "/api/users/register";
  static const String currentUserAPI = "/api/users/current";

  //forum
  static const String getApostForums = "/api/forums";
  static const String getOwnForums = "/api/forums/ownnforums";
  static String getOwnForum(String id) {
    String path = "/api/forums/ownnforums/:$id";
    return path;
  }


  //food
  static const String getFoodPosts = "/api/food";
}
