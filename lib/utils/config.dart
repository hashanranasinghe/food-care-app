class Config {
  //user
  static const String appName = "FoodCare App";
  static const String apiURL = "10.0.2.2:5001";
  static const String socketUrl = "http://10.0.2.2:8900";
  //static const String apiURL = "192.168.0.101:5001";
  static const String loginUserAPI = "/api/users/login";
  static const String registerUserAPI = "/api/users/register";
  static const String currentUserAPI = "/api/users/current";
  static const String users = "/api/users/users";
  static const String emailUrl = "http://localhost:5001";
  static const String emailApi =
      "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";

  static String verifyUser({required String verificationToken}) {
    String path = "/api/users/verify/$verificationToken";
    return path;
  }

  static String resetPassword({required String id, required String token}) {
    String path = "/api/users/resetpassword/$id/$token";
    return path;
  }

  static const String forgetPasswordApi = "/api/users/forgetpassword";

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

  static String requestFood({required String id}) {
    String path = "api/food/$id/request";
    return path;
  }

  //chat- conversation
  static String getConversationsOfUser = "api/conversation/chats";

  static String getConversation(
      {required String senderId, required String receiverId}) {
    String path = "api/conversation/$senderId/$receiverId";
    return path;
  }

  static const String createConversation = "api/conversation";

  //chat- message
  static String getMessages({required String id}) {
    String path = "api/message/$id";
    return path;
  }

  static const String sendMessage = "/api/message";

  //image
  static String imageUrl({required String imageUrl}) {
    String url = 'http://${'$apiURL\\$imageUrl'}'.replaceAll('\\', '/');
    return url;
  }
}
