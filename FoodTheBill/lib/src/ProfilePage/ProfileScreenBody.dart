import 'package:flutter/material.dart';
import 'package:milestone1/src/ProfilePage/ProfilePic.dart';

class ProfileScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [ProfilePic()],
        ));
  }
}
