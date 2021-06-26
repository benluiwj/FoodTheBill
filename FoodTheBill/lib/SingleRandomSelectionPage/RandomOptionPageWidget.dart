import 'dart:math';

import 'package:flutter/material.dart';
import '../InputPage/HomePageForm/FoodQuery.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

class RandomOptionPageWidget extends StatefulWidget {
  final FoodQuery? query;

  RandomOptionPageWidget({Key? key, this.query}) : super(key: key);

  @override
  RandomOptionPageWidgetState createState() {
    RandomOptionPageWidgetState res = RandomOptionPageWidgetState();
    res.query = this.query;
    return res;
  }
}

class RandomOptionPageWidgetState extends State<RandomOptionPageWidget> {
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
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
                  return Text(
                    snapshot.data!.results[index.nextInt(19)].name,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  );
                }
              }),
        ],
      ),
    );
  }
}
