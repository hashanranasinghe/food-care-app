import 'package:food_care/models/conversationModel.dart';
import 'package:food_care/view%20models/chat%20view/conversation/conversation_view_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/chatModel.dart';
import '../../utils/config.dart';
import '../store_token.dart';

class ChatApiServices {

  static var client = http.Client();

  //get conversations of user
  static Future<List<dynamic>> getConversationsListOfUser(
      {required String userId}) async {
    String? token = await StoreToken.getToken();

    final response = await client.get(
      Uri.http(Config.apiURL, Config.getConversationsOfUser),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> conversationJsonList = json.decode(response.body);
      List<Conversation> conversationList = conversationJsonList
          .map((conversationJson) => Conversation.fromJson(conversationJson))
          .toList();
      return conversationList;
    } else if (response.statusCode == 404) {
      throw Exception('Conversation not found');
    } else {
      throw Exception('Failed to load conversations');
    }
  }

  //get a conversation
  static Future<ConversationViewModel> getConversation({required String senderId,required String receiverId}) async {
    String? token = await StoreToken.getToken();
    final response = await client.get(
      Uri.http(Config.apiURL, Config.getConversation(senderId: senderId, receiverId: receiverId)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final conversationJson = jsonDecode(response.body);
      final conversation = Conversation.fromJson(conversationJson);
      final vm  = ConversationViewModel(conversation: conversation);
      return vm;
    } else if (response.statusCode == 404) {
      throw Exception('conversation not found');
    } else {
      throw Exception('Failed to get conversation');
    }
  }

  //create a conversation
  static Future<void> createConversation({required Conversation conversation})async{
    print(conversation.members);
    String? token = await StoreToken.getToken();
    final conversationData = jsonEncode({
      'senderId': conversation.members[0],
      'receiverId':conversation.members[1],
    });

    final url = Uri.http(Config.apiURL, Config.createConversation);
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final response = await http.post(url, headers: headers, body: conversationData);
    // Check the response status code
    if (response.statusCode == 200) {
      // Update successful
      print('create conversation successfully.');
    } else {
      // Update failed
      print('creating failed with status code ${response.statusCode}.');
    }
  }


  //get all messages of conversation
  static Future<List<dynamic>> getMessageList(
      {required String conversationId}) async {
    String? token = await StoreToken.getToken();

    final response = await client.get(
      Uri.http(Config.apiURL, Config.getMessages(id: conversationId)),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> chatJsonList = json.decode(response.body);
      List<Chat> chatList =
          chatJsonList.map((chatJson) => Chat.fromJson(chatJson)).toList();
      return chatList;
    } else if (response.statusCode == 404) {
      throw Exception('Chats not found');
    } else {
      throw Exception('Failed to load chats');
    }
  }

  //send message
  static Future<void> sendMessage({required Chat chat}) async {
    String? token = await StoreToken.getToken();
    // Encode the user data as JSON
    final userData = jsonEncode({
      'conversationId': chat.conversationId,
      'sender_id': chat.senderId,
      'message': chat.message,
    });

    // Create a new HTTP request
    final url = Uri.http(Config.apiURL, Config.sendMessage);
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final response = await http.post(url, headers: headers, body: userData);

    // Check the response status code
    if (response.statusCode == 200) {
      // Update successful
      print('send message successfully.');
    } else {
      // Update failed
      print('Sending failed with status code ${response.statusCode}.');
    }
  }

}
