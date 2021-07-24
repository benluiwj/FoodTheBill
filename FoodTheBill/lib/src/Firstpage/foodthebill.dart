import 'package:flutter/material.dart';

/// This widget contains the title text of the initial
/// page after a user has logged into app.

class FoodTheBill extends StatelessWidget {
  FoodTheBill();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 80),
      child: Text(
        "FoodTheBill",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
