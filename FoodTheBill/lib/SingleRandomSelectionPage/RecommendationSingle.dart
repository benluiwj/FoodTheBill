import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodthebillv2/FavouriteRestaurant/HeartButton.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:url_launcher/url_launcher.dart';

import '../UniversalWidgets/RecommendationLogic.dart';
import '../../UniversalWidgets/SettingsWidget.dart';
import '../InputPage/HomePageForm/FoodQuery.dart';
import '../UniversalWidgets/ErrorPage.dart';
import '../InputPage/InputPageLayout/SecondPageHeader.dart';

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
  List<PlacesSearchResult>? favRest;
  int? randomNum;

  /// Initialising the state together with the processing logic
  @override
  void initState() {
    super.initState();
    favRest = info!.favRest;
    randomNum = 0;
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
                randomNum = index.nextInt(length);
                return info!.buildTile(randomNum!, snapshot);
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
            iconTheme: IconThemeData(color: Colors.black),
            actions: <Widget>[
              SettingsWidget(),
            ]),
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