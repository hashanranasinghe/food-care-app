import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List<QAItem> questionsAndAnswers = [
    QAItem(
      question: "What is Food-Care, and how does it work?",
      answer:
          "Food-Care is a mobile app designed for food sharing. Users with surplus food can create posts, specifying the location and details of available food. Those in need can browse these posts, request food, and the food owner can accept the request to facilitate the donation.",
    ),
    QAItem(
      question: "What information do you collect from users?",
      answer:
          "We collect name, email address, and location when creating food posts. Usage data is collected to enhance the app's functionality.",
    ),
    QAItem(
      question: "What should I do if I see an inappropriate food post?",
      answer:
          "If you come across an inappropriate food post, you can report it within the app. Our administrators will review the report and take suitable actions.",
    ),
    QAItem(
      question: "Are there any fees for using Food-Care?",
      answer:
          "Food-Care is a free app. There are no fees associated with using our platform.",
    ),
    QAItem(
      question: "Is Food-Care available in my area?",
      answer:
          "Food-Care aims to expand its reach. Currently, the app is only available in Sri Lanka, so please check the app to see if it's active in your area.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQ',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.01, vertical: size.height * 0.01),
        child: ListView.builder(
          itemCount: questionsAndAnswers.length,
          itemBuilder: (context, index) {
            QAItem item = questionsAndAnswers[index];
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.01, vertical: size.height * 0.01),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Text(
                    item.question,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.02),
                      child: Text(
                        item.answer,
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class QAItem {
  final String question;
  final String answer;

  QAItem({required this.question, required this.answer});
}
