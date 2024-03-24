import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../utils/constraints.dart';

class PopupDialog {
  static showPopupDialog(BuildContext context, String titel, String description,
      Function actionFun) {
    AwesomeDialog(
            desc: description,
            title: titel,
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.scale,
            btnCancelText: "Cancel",
            btnOkText: "Ok",
            btnCancelOnPress: () {
              Navigator.pop(context);
            },
            btnOkOnPress: () {
              actionFun();
            },
            btnOkColor: kPrimaryColorDark,
            btnCancelColor: Colors.grey)
        .show();
  }

  // static choosecallDilog(BuildContext context, UserModel userModel) {
  //   AwesomeDialog(
  //     context: context,
  //     dialogType: DialogType.QUESTION,
  //     animType: AnimType.BOTTOMSLIDE,
  //     title: "Choose call type",
  //     desc: "Do you want to get which type call ? ",
  //     btnCancelText: "Voice",
  //     btnOkText: "Video",
  //     btnCancelOnPress: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) {
  //             return DialScreen(
  //               iurl: userModel.imageurl,
  //               name: userModel.name,
  //             );
  //           },
  //         ),
  //       );
  //     },
  //     btnOkOnPress: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) {
  //             return DialScreen(
  //               iurl: userModel.imageurl,
  //               name: userModel.name,
  //             );
  //           },
  //         ),
  //       );
  //     },
  //     btnOkColor: Colors.green,
  //     btnCancelColor: kPrimaryColordark,
  //   ).show();
  // }

  static showPopupWarning(BuildContext context, String titel,
      String description, Function actionFun) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: titel,
      btnCancelText: "No",
      btnOkText: "Yes",
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        actionFun();
      },
    ).show();
  }

  static showPopuplogout(BuildContext context, String titel, String description,
      Function actionFun) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: titel,
      desc: description,
      btnCancelText: "No",
      btnOkText: "Yes",
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        actionFun();
      },
    ).show();
  }

  static showPopupErorr(
    BuildContext context,
    String titel,
    String description,
  ) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.BOTTOMSLIDE,
      title: titel,
      desc: description,
      btnOkText: "Ok",
      btnCancel: null,
      btnOkOnPress: () {},
    ).show();
  }
}

/*static Future<void> showMyDialog(BuildContext context, String titel,
      String description, Function actionFun) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titel),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes , did'),
              onPressed: () {
                /// actionFun();
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.INFO,
                  animType: AnimType.LEFTSLIDE,
                  title: 'Dialog Title',
                  desc: 'Dialog description here.............',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                )..show();
              },
            ),
            TextButton(
              child: const Text('Not yet'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } */
