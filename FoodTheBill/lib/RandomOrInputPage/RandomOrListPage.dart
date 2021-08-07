import 'package:flutter/material.dart';
import 'package:foodthebillv2/UniversalWidgets/SettingsWidget.dart';
import '../InputPage/HomePageForm/FoodQuery.dart';
import '../ProfilePage/ProfileScreen.dart';
import '../UniversalWidgets/RecommendationLogic.dart';
import '../InputPage/InputPageLayout/SecondPageHeader.dart';

import '../SingleRandomSelectionPage/RecommendationSingle.dart';
import '../RecommendationPage/RecommendationList.dart';

/// This class contains the layout of the second page of the app.
class RandomOrListPage extends StatelessWidget {
  final FoodQuery? query;
  late final RecommendationLogic info;

  RandomOrListPage({this.query}) {
    this.info = RecommendationLogic(query: query);
  }

  Widget singleRecommend(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: ElevatedButton(
        child: Text(
          "Single Recommendation",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            letterSpacing: 2.0,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
        ),
        onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RecommendationSingle(query: query, info: info);
            }));
          },
      ),
    );
  }

  Widget listRecommend(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: ElevatedButton(
        child: Text(
          "List of Recommendations",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            letterSpacing: 2.0,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,

        ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RecommendationList(query: query, info: info);
            }));
          }
      ),
    );
  }

  Widget Or(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 25.0, right: 15.0),
            child: Divider(
              color: Colors.black,
            )),
      ),
      Text(
        "OR",
        style: TextStyle(
          fontSize: 25,
          letterSpacing: 2.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 15.0, right: 25.0),
            child: Divider(
              color: Colors.black,
            )),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            actions: <Widget>[
              SettingsWidget(),
            ],
        ),
        body: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: SafeArea(
            top: false,
            child: Column(children: [
              Header(),
              singleRecommend(context),
              Or(context),
              listRecommend(context),
              //Recommended(query: this.query),
              //profileButton(context)
            ]),
          ),
        ));
  }
}