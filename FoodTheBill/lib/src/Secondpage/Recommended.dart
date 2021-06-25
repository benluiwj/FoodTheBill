import 'dart:math';

import 'package:flutter/material.dart';
import '../HomePageForm/FoodQuery.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

class Recommended extends StatefulWidget {
  final FoodQuery? query;
  Recommended({Key? key, this.query}) : super(key: key);

  @override
  RecommendedState createState() {
    RecommendedState res = RecommendedState();
    res.query = this.query;
    return res;
  }
}

class RecommendedState extends State<Recommended> {
  final String apiKey = "AIzaSyAso_tOsxE6y4X7fPcpWiwUZt6SiDPstO8";
  FoodQuery? query;
  late GoogleMapsPlaces googlePlace;
  late GoogleMapsGeocoding geocoding;
  late Future<PlacesSearchResponse> restaurants;
  late Future<GeocodingResponse> currLocation;

  @override
  void initState() {
    super.initState();
    googlePlace = GoogleMapsPlaces(apiKey: apiKey);
    geocoding = GoogleMapsGeocoding(apiKey: apiKey);
    currLocation = fetchCoords();
    restaurants = fetchRestaurants();
  }

  Future<PlacesSearchResponse> fetchRestaurants() async {
    Location coords = await currLocation
        .then((value) => value.results.first.geometry.location);
    PlacesSearchResponse placesResponse =
        await googlePlace.searchNearbyWithRankBy(coords, "distance",
            type: "restaurant",
            keyword: "${query!.cuisine!.curr!.toLowerCase()} restaurants");
    return placesResponse;
  }

  Future<GeocodingResponse> fetchCoords() async {
    GeocodingResponse result =
        await geocoding.searchByAddress(query!.location.toString());
    return result;
  }

  Widget buildTile(int index, AsyncSnapshot<PlacesSearchResponse> snapshot) {
    return Column(children: [
      ListTile(title: Text(snapshot.data!.results[index].name)),
      Divider(
        color: Colors.black54,
      )
    ]);
  }

  Widget randomOption() {
    return Scaffold(
        body: Column(children: [
      AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "FoodTheBill",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          )),
      FutureBuilder<PlacesSearchResponse>(
          future: restaurants,
          builder: (context, snapshot) {
            Random index = Random();
            if (snapshot.data == null) {
              return Text("Loading...I");
            } else {
              return Text(snapshot.data!.results[index.nextInt(19)].name);
            }
          }),
      ElevatedButton(
          child: Text(
            "Others",
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
              return listOfRecommendations();
            }));
          })
    ]));
  }

  Widget listOfRecommendations() {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
          floating: false,
          pinned: false,
          snap: false,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Recommended for you!",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center)),
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return FutureBuilder<PlacesSearchResponse>(
              future: restaurants,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                } else {
                  return buildTile(index, snapshot);
                }
              });
        }, childCount: 20),
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return randomOption();
  }
}
