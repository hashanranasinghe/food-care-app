import 'package:flutter/material.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';

class ChatListCard extends StatelessWidget {
  const ChatListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      child: ListTile(
        onTap: (){
          openMessaging(context);
        },
        leading: CircleAvatar(
          backgroundColor: kPrimaryColorlight,
          child: Image.asset(icon),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Hashan Ranasinghe",style: TextStyle(

                fontWeight: FontWeight.bold
            ),),
            Text("18.31"),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("hi............"),
            CircleAvatar(
              radius: 12,
              backgroundColor: kPrimaryColordark,
              child: Text("6",style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),),
            )
          ],
        ),
      ),
    );
  }
}
