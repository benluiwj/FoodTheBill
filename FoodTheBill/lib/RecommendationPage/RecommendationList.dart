import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../FavouriteRestaurant/FavouriteButton.dart';
import '../UniversalWidgets/SettingsWidget.dart';
import 'package:google_maps_webservice/places.dart';
import '../UniversalWidgets/ErrorPage.dart';
import '../UniversalWidgets/RecommendationLogic.dart';

import '../InputPage/HomePageForm/FoodQuery.dart';

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
  List<PlacesSearchResult>? favRest;

  // final FirebaseFirestore db = FirebaseFirestore.instance;
  // CollectionReference users = FirebaseFirestore.instance.collection('users');

  /// Initialising the state together with the processing logic
  @override
  void initState() {
    super.initState();
    favRest = info!.favRest;
    Firebase.initializeApp();
    //favRest = [];
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   Firebase.initializeApp();
  //   setState(() {
  //     //build(context);
  //   });
  // }

  Widget buildTile(int index, AsyncSnapshot<PlacesSearchResponse> snapshot) {
    PlacesSearchResult result = snapshot.data!.results[index];

    return Column(children: [
      ListTile(
          title: Text(result.name),
          subtitle: Text(result.vicinity!),
          trailing: FavoriteButton(result: result, info: info,),
          onTap: () async {
            String destinationEncode = Uri.encodeComponent(result.name);
            String currLocationEncode = await info!.currLocation.then((value) =>
                Uri.encodeComponent(value.results.first.formattedAddress!));
            String url =
                'https://www.google.com/maps/dir/?api=1&origin=$currLocationEncode&destination=$destinationEncode';
            if (await canLaunch(url))
              await launch(url);
            else
              throw Exception('Did not launch');
          }),
      Divider(
        color: Colors.black54,
      )
    ]);
  }

  /// Returns a list that contains the options available
  Widget resultList() {
    //return SliverList(delegate: SliverChildBuilderDelegate((context, index) {
    return FutureBuilder<PlacesSearchResponse>(
        future: info!.restaurants, //information when future is completed
        builder: (context, snapshot) { //snapshot information when the future is completed
          if (!snapshot.hasData) {
            return Text("Loading...");
          } else if (snapshot.data!.results.length == 0) { //snapshot.data!.results is an array, so if 0 means nothing in the array
            return ErrorPage();
          } else {
            return ListView.builder(
                itemBuilder: (context, index) {
                  return buildTile(index, snapshot);
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
              "Recommendation List",
              style: TextStyle(
                  fontFamily: "Caveat",
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Colors.black),
            ),
            actions: <Widget>[
              SettingsWidget(),
            ],
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            flexibleSpace: Image(
                image: AssetImage("assets/HomePageBackGround.jpg"),
                fit: BoxFit.fill)),
        body: resultList()
        );
  }
}
