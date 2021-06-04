// THIS IS THE SECOND PAGE OF THE APP
import 'package:flutter/material.dart';
import '../HomePageForm/FoodQuery.dart';
import './backpage.dart';

class Recommended extends StatelessWidget {
  final FoodQuery? query;

  Recommended({Key? key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            BackPage(),
            Text(
              "Recommended for you!",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Text(query.toString(),
                style: TextStyle(fontSize: 15), textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
