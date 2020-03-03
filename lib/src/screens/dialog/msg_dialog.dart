import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MsgDialog {
  static void showMsgDialog(BuildContext context, String title, String msg){
    showDialog(context: context, barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(MsgDialog);
              },
              child: Text("OK"),
            )
          ],
        ));
  }
}