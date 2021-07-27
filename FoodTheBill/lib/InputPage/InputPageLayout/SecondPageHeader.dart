import 'package:flutter/material.dart';

/// This class contains the header for the second page of the app
class Header extends StatelessWidget {
  final double coverImageHeight = 315;
  final double titleBoxHeight = 80;
  final double titleFontSize = 70;
  final double padding = 25;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: padding),
        child: Column(children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/HomePageBackGround.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: coverImageHeight,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: titleBoxHeight),
                  Text(
                    "FoodTheBill",
                    style: TextStyle(
                        fontSize: titleFontSize,
                        fontFamily: "Caveat",
                        fontWeight: FontWeight.w700,
                        height: 0.5),
                  ),
                  Text(
                    "Making the decision for you!",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ],
          ),
        ]));
  }
}