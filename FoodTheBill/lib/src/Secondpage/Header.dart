import 'package:flutter/material.dart';
import './/SizeConfig.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: getProportionateScreenWidth(25)),
        child: Column(children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/HomePageBackGround.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: getProportionateScreenHeight(315),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getProportionateScreenHeight(80)),
                  Text(
                    "FoodTheBill",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(55),
                        fontWeight: FontWeight.bold,
                        height: 0.5),
                  ),
                  Text(
                    "Making the decision for you!",
                  )
                ],
              ),
            ],
          ),
        ]));
  }
}
