import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:milestone1/src/ErrorPage.dart';
import 'package:milestone1/src/Secondpage/FavoriteButton.dart';
import 'package:milestone1/src/Secondpage/SecondPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
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
          trailing: FavoriteButton(info: info, result: result),
          /*trailing: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                setState(() {
                  if (favRest!.contains(result))
                    favRest!.remove(result);
                  else
                    favRest!.add(result);
                });
              },
              color: favRest!.contains(result) ? Colors.red : null),*/
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
                  return buildTile(index, snapshot);
                },
                itemCount: snapshot.data!.results.length);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    //RecommendationSingle(query: query, info: info).createState().build(context); // naive
    //FavoriteButton(info: info).createState().build(context);
    print("built list");
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "FoodTheBill",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          flexibleSpace: Image(
              image: AssetImage("assets/HomePageBackGround.jpg"),
              fit: BoxFit.fill),
          actions: [SecondPage(query: query).profileButton(context)],
        ),
        body: resultList()
        //Recommended(query: this.query),
        //profileButton(context)
        );
  }
}
