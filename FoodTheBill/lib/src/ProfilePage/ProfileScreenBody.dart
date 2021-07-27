import 'package:flutter/material.dart';
import 'package:milestone1/src/HomePageForm/FoodQuery.dart';
import 'package:milestone1/src/ProfilePage/ProfilePic.dart';
import 'package:milestone1/src/Secondpage/RecommendationLogic.dart';
import 'ProfileMenu.dart';
import '../Secondpage/SavedRestaurants.dart';

/// This class contains the options that the user can select on their profile page.
/// Such options include their favorited locations as well as logging out of the app

class ProfileScreenBody extends StatelessWidget {
  final RecommendationLogic? info;
  final FoodQuery? query;

  ProfileScreenBody({this.info, this.query});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
              text: "Favourites",
              icon: "assets/Heart Icon_2.svg",
              press: () => {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return SavedRestaurants(info: info);
                    }))
                  }),
          ProfileMenu(
              text: "Log out", icon: "assets/Log out.svg", press: () => {})
        ]));
  }
}
