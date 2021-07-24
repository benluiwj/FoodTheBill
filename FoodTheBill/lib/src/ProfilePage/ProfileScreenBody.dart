import 'package:flutter/material.dart';
import 'package:milestone1/src/ProfilePage/ProfilePic.dart';
import 'ProfileMenu.dart';

/// This class contains the options that the user can select on their profile page.
/// Such options include their favorited locations as well as logging out of the app

class ProfileScreenBody extends StatelessWidget {
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
              press: () => {}),
          ProfileMenu(
              text: "Log out", icon: "assets/Log out.svg", press: () => {})
        ]));
  }
}
