import 'package:flutter/material.dart';

class IntroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Helping to make the food decision for you!',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}