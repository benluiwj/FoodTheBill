import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'RecommendationLogic.dart';

import '../HomePageForm/FoodQuery.dart';
import '.././ErrorPage.dart';
import 'SecondPageHeader.dart';

/// This class contains the output for the single recommendations

class RecommendationSingle extends StatefulWidget {
  final FoodQuery? query;
  final RecommendationLogic? info;
  RecommendationSingle({Key? key, this.query, this.info}) : super(key: key);

  @override
  RecommendationSingleState createState() {
    RecommendationSingleState res = RecommendationSingleState();
    res.query = query;
    res.info = info;
    return res;
  }
}

/// This class handles all the output of the single recommendation

class RecommendationSingleState extends State<RecommendationSingle> {
  FoodQuery? query;
  late RecommendationLogic? info;

  /// Initialising the state together with the processing logic

  @override
  void initState() {
    super.initState();
  }

  /// Returns a list tile that contains the random option

  Widget randomOption() {
    return Column(children: [
      FutureBuilder<PlacesSearchResponse>(
          future: info!.restaurants,
          builder: (context, snapshot) {
            Random index = Random();
            if (snapshot.data == null) {
              return Text("Loading...");
            } else {
              if (snapshot.data!.results.length == 0) {
                return ErrorPage();
              } else {
                List<PlacesSearchResult> listOfRestaurants =
                    snapshot.data!.results;
                int length = listOfRestaurants.length;
                int randomNum = index.nextInt(length);
                return info!.buildTile(randomNum, snapshot);
              }
            }
          })
    ]);
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
              randomOption()
              //Recommended(query: this.query),
              //profileButton(context)
            ]),
          ),
        ));
  }
}
