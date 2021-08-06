import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:milestone1/src/Secondpage/FavoriteButton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
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
  List<PlacesSearchResult>? favRest;

  /// Initialising the state together with the processing logic

  @override
  void initState() {
    super.initState();
    favRest = info!.favRest;
    Firebase.initializeApp();
  }

  Widget buildTile(int index, AsyncSnapshot<PlacesSearchResponse> snapshot) {
    PlacesSearchResult result = snapshot.data!.results[index];
    return Column(children: [
      ListTile(
          title: Text(result.name),
          subtitle: Text(result.vicinity!),
          trailing: FavoriteButton(result: result, info: info),
          onTap: () async {
            String destinationEncode = Uri.encodeComponent(result.name);
            String currLocationEncode = await info!.currLocation.then((value) =>
                Uri.encodeComponent(value.results.first.formattedAddress!));
            String url =
                'https://www.google.com/maps/dir/?api=1&origin=$currLocationEncode&destination=$destinationEncode';
            if (await canLaunch(url))
              await launch(url);
            else
              throw Exception('Dint launch');
          }),
      Divider(
        color: Colors.black54,
      )
    ]);
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
                return buildTile(randomNum, snapshot);
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
