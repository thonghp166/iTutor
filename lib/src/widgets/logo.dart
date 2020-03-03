import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "i",
        style: TextStyle(fontSize: 30, color: Colors.red,fontWeight: FontWeight.bold),
        children: [
          TextSpan(
              text: "Tutor",
              style: TextStyle(fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold)
          )
        ],
      ),
    );
  }
}
