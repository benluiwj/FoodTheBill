import 'package:flutter/material.dart';
import './ProfileScreenBody.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
              fontFamily: "Caveat",
              fontWeight: FontWeight.w700,
              fontSize: 25,
              color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white10,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ProfileScreenBody(),
    );
  }
}