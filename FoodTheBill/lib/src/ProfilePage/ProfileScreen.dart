import 'package:flutter/material.dart';
import '../ProfilePage/ProfileScreenBody.dart';

/// This class contains the basic layout of the profile page of the user

class ProfileScreen extends StatelessWidget {
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
      body: ProfileScreenBody(),
    );
  }
}
