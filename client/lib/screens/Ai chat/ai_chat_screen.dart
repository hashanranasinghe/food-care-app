// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:math';

import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class AIChatView extends StatefulWidget {
  const AIChatView({
    super.key,
  });

  @override
  State<AIChatView> createState() => _AIChatViewState();
}

class _AIChatViewState extends State<AIChatView> {
  final List<types.Message> _messages = [];
  final List<OpenAIChatCompletionChoiceMessageModel> _aiMessages = [];
  late types.User ai;
  late types.User user;
  late String appBarTitle;

  var chatResponseId = '';
  var chatResponseContent = '';

  bool isAiTyping = false;
  String welcomeMessage =
     "🌟 Welcome to FoodCare Chat! 🍲\n Hey, 👋\n Meet CulinaryGuide, your food companion! 🌿 Ready to explore surplus food spots, confirm orders, and get tips for sustainable cooking? Let's cook up something awesome together! 🍀\n Ask me anything! 🍽";

  final trainedpormt =
      "act as a knowledgeable person who knows about food-related topics. you should provide information about foods, recipes, and ways to reduce food waste or anything related to foods. If the question is not related to food recipes or preservation methods then reply something like this, 'Please ask a question related to foods and food-related fields like recipes and food reservation techniques'.  If anyone asks about you, reply something like this, you can change the reply to a similar one: 'I am CulinaryGuide, your food companion in the digital realm.  I'm powered by GPT-3.5 Turbo, and I'm here to unravel all the food-related problems with snappy responses. If it's any food-related knowledge you seek, look no further. Ask away, and let's navigate the world of Food! .'";
  @override
  void initState() {
    super.initState();
    setApiKeyOnStartup();
    ai = const types.User(id: 'ai', firstName: 'AI');
    user = const types.User(id: 'user', firstName: 'You');

    appBarTitle = 'Chat with FoodCare AI';

    // read chat history from Hive

    // Add to chat view
    final textMessage = types.TextMessage(
      author: ai,
      createdAt: DateTime.now().microsecondsSinceEpoch,
      id: randomString(),
      text: welcomeMessage,
    );

    _messages.insert(0, textMessage);

    // construct chatgpt messages
    // ignore: prefer_const_constructors
    _aiMessages.add(OpenAIChatCompletionChoiceMessageModel(
        content: 'Hi Please ask me?', role: OpenAIChatMessageRole.assistant));
    _completeChat(trainedpormt, istrianed: false);

    setState(() {});
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  setApiKeyOnStartup() {
    OpenAI.apiKey = "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";
  }

  void _completeChat(String prompt, {bool istrianed = true}) async {
    _aiMessages.add(OpenAIChatCompletionChoiceMessageModel(
      content: prompt,
      role: OpenAIChatMessageRole.user,
    ));

    Stream<OpenAIStreamChatCompletionModel> chatStream =
        OpenAI.instance.chat.createStream(
      model: "gpt-3.5-turbo",
      messages: _aiMessages,
    );

    chatStream.listen((chatStreamEvent) {
      debugPrint(chatStreamEvent.toString());
      // existing id: just update to the same text bubble
      if (chatResponseId == chatStreamEvent.id) {
        chatResponseContent +=
            chatStreamEvent.choices.first.delta.content ?? '';

        if (istrianed) {
          _addMessageStream(chatResponseContent);
        }

        if (chatStreamEvent.choices.first.finishReason == "stop") {
          isAiTyping = false;
          _aiMessages.add(OpenAIChatCompletionChoiceMessageModel(
            content: chatResponseContent,
            role: OpenAIChatMessageRole.assistant,
          ));
          // _saveMessage(chatResponseContent, MessageRole.ai);
          chatResponseId = '';
          chatResponseContent = '';
        }
      } else {
        // new id: create new text bubble
        if (istrianed) {
          chatResponseId = chatStreamEvent.id;
          chatResponseContent =
              chatStreamEvent.choices.first.delta.content ?? '';
          onMessageReceived(id: chatResponseId, message: chatResponseContent);
          isAiTyping = true;
        }
      }
    });
  }

  void onMessageReceived({String? id, required String message}) {
    var newMessage = types.TextMessage(
      author: ai,
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      text: message,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    _addMessage(newMessage);
  }

  // add new bubble to chat
  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  // /// Save message to Hive database
  // void _saveMessage(String message, MessageRole role) {
  //   final messageItem = MessageItem(message, role, DateTime.now());
  //   messageBox.add(messageItem);
  //   widget.chatItem.messages.add(messageItem);
  //   widget.chatItem.save();
  // }

  // modify last bubble in chat
  void _addMessageStream(String message) {
    setState(() {
      _messages.first =
          (_messages.first as types.TextMessage).copyWith(text: message);
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
    // _saveMessage(message.text, MessageRole.user);
    _completeChat(message.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Chat(
    

        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: user,
        theme: DefaultChatTheme(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}