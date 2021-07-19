import 'package:flutter/material.dart';
import 'package:milestone1/src/Secondpage/Body.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Body(),
    );
  }
}
