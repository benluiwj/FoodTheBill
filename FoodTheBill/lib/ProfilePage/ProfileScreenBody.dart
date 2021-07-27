import 'package:flutter/material.dart';
import '../UniversalWidgets/FoodTheBillLogo.dart';
import './ChangePassword.dart';
import './ProfilePic.dart';
import 'LogOut.dart';
import 'ProfileMenu.dart';

class ProfileScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        //padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(children: [
          FoodTheBillLogo(),
          //ProfilePic(),
          SizedBox(height: 40),
          ProfileMenu(
              text: "Favourites",
              icon: "assets/Heart Icon_2.svg",
              press: () => {}),
          ProfileMenu(
              text: "Change Password",
              icon: "assets/house-key.svg",
              press: () {Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChangePassword();
                  },
                ),
              );}),
          LogOut(),
        ]));
  }
}
