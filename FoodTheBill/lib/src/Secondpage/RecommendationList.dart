import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:milestone1/src/ErrorPage.dart';
import 'RecommendationLogic.dart';

import '../HomePageForm/FoodQuery.dart';

/// This class contains the output for the list of recommendations

class RecommendationList extends StatefulWidget {
  final FoodQuery? query;
  final RecommendationLogic? info;
  RecommendationList({Key? key, this.query, this.info}) : super(key: key);

  @override
  RecommendationListState createState() {
    RecommendationListState res = RecommendationListState();
    res.query = query;
    res.info = info;
    return res;
  }
}

/// This class handles all the output of the list of recommendation

class RecommendationListState extends State<RecommendationList> {
  FoodQuery? query;
  late RecommendationLogic? info;
  int res = 0;

  /// Initialising the state together with the processing logic

  @override
  void initState() {
    super.initState();
  }

  /// Returns a list that contains the options available

  Widget resultList() {
    //return SliverList(delegate: SliverChildBuilderDelegate((context, index) {
    return FutureBuilder<PlacesSearchResponse>(
        future: info!.restaurants,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading...");
          } else if (snapshot.data!.results.length == 0) {
            return ErrorPage();
          } else {
            return ListView.builder(
                itemBuilder: (context, index) {
                  return info!.buildTile(index, snapshot);
                },
                itemCount: snapshot.data!.results.length);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Text(
              "FoodTheBill",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            flexibleSpace: Image(
                image: AssetImage("assets/HomePageBackGround.jpg"),
                fit: BoxFit.fill)),
        body: resultList()
        //Recommended(query: this.query),
        //profileButton(context)
        );
  }
}
