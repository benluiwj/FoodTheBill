import 'package:flutter/material.dart';
import 'package:milestone1/src/HomePageForm/FoodQuery.dart';
import 'package:milestone1/src/ProfilePage/ProfileScreen.dart';
import 'package:milestone1/src/Secondpage/SecondPageHeader.dart';
//import 'package:milestone1/src/Secondpage/Recommendation.dart';
import 'RecommendationSingle.dart';
import 'RecommendationList.dart';

/// This class contains the layout of the second page of the app.

class SecondPage extends StatelessWidget {
  final FoodQuery? query;
  SecondPage({Key? key, this.query}) : super(key: key);

  /// Returns a widget that brings the user to their profile page

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

  Widget singleRecommend(BuildContext context) {
    return ElevatedButton(
        child: Text(
          "single recommend",
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
            return RecommendationSingle(query: query);
          }));
        });
  }

  Widget listRecommend(BuildContext context) {
    return ElevatedButton(
        child: Text(
          "list recommend",
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
            return RecommendationList(query: query);
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
              singleRecommend(context),
              listRecommend(context),
              //Recommended(query: this.query),
              //profileButton(context)
            ]),
          ),
        ));
  }
}
