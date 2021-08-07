
import 'package:flutter/material.dart';
import '../ProfilePage/ProfileScreen.dart';

class SettingsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.0, bottom: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProfileScreen();
              },
            ),
          );
        },
        child: Icon(
          Icons.settings,
          size: 30,
        ),
      ),
    );
  }
}
