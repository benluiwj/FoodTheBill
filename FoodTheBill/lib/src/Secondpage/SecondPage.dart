import 'package:flutter/material.dart';
import 'package:milestone1/src/HomePageForm/FoodQuery.dart';
import 'package:milestone1/src/ProfilePage/ProfileScreen.dart';
import 'package:milestone1/src/Secondpage/RecommendationLogic.dart';
import 'package:milestone1/src/Secondpage/SecondPageHeader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'RecommendationSingle.dart';
import 'RecommendationList.dart';

/// This class contains the layout of the second page of the app.

class SecondPage extends StatelessWidget {
  final FoodQuery? query;
  late final RecommendationLogic info;

  SecondPage({this.query}) {
    this.info = RecommendationLogic(query: query);
    Firebase.initializeApp();
  }

  /// Returns a widget that brings the user to their profile page

  Widget profileButton(BuildContext context) {
    /*return ElevatedButton(
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
            return ProfileScreen(query: query, info: info);
          }));
        });*/
    return Padding(
      padding: EdgeInsets.only(right: 20.0, bottom: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProfileScreen(
                  query: query,
                  info: info,
                );
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
            return RecommendationSingle(query: query, info: info);
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
            return RecommendationList(query: query, info: info);
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
            actions: [profileButton(context)],
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
