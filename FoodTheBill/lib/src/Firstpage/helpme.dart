import 'package:flutter/material.dart';
import 'package:milestone1/src/Secondpage/SecondScreen.dart';

class HelpMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(40),
      padding: EdgeInsets.only(top: 30),
      child: ElevatedButton(
        child: Text(
          "HELP ME!!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            letterSpacing: 2.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SecondScreen();
          }));
        },
      ),
    );
  }
}
