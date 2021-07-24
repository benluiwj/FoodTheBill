import 'package:flutter/material.dart';

/// This class contains the basic formatting of the profile image of the user

class ProfilePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://picsum.photos/id/10/200/300")),
              ],
            )));
  }
}
