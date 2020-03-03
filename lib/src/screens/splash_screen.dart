import 'package:flutter/material.dart';
import 'package:itutor/src/widgets/logo.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Logo(),
      ),
    );
  }
}
