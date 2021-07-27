import 'package:flutter/material.dart';
import 'package:milestone1/src/HomePageForm/FoodQuery.dart';
import 'package:milestone1/src/Secondpage/RecommendationLogic.dart';
import '../ProfilePage/ProfileScreenBody.dart';

/// This class contains the basic layout of the profile page of the user
/// Modified to contain the recommendation logic as well as the food query

class ProfileScreen extends StatelessWidget {
  final RecommendationLogic? info;
  final FoodQuery? query;
  ProfileScreen({this.query, this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white10,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ProfileScreenBody(info: info, query: query),
    );
  }
}
