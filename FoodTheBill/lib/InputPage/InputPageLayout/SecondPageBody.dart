import 'package:flutter/material.dart';
import '../HomePageForm/FoodQuery.dart';
import '../../ProfilePage/ProfileScreen.dart';
import './SecondPageHeader.dart';
//import 'package:milestone1/src/Secondpage/Recommended.dart';

class Body extends StatelessWidget {
  final FoodQuery? query;
  Body({Key? key, this.query}) : super(key: key);

  Widget profileButton(BuildContext context) {
    return ElevatedButton(
        child: Text(
          "profile",
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
            return ProfileScreen();
          }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black)),
        body: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: SafeArea(
            top: false,
            child: Column(children: [
              Header(),
              //Recommended(query: this.query),
              profileButton(context)
            ]),
          ),
        ));
  }
}