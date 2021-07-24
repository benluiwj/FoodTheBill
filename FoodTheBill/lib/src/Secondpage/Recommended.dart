import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:url_launcher/url_launcher.dart';

import '../HomePageForm/FoodQuery.dart';
import '.././ErrorPage.dart';

/// This class initialises the state that deals with user input from the form

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

/// This class contains the logic for dealing with the input from the user,
/// as well as displaying the info, based on whether the user prefers a single
/// recommendation or a list of recommendations

class RecommendedState extends State<Recommended> {
  final String apiKey = "AIzaSyAso_tOsxE6y4X7fPcpWiwUZt6SiDPstO8";
  FoodQuery? query;
  late GoogleMapsPlaces googlePlace;
  late GoogleMapsGeocoding geocoding;
  late Future<PlacesSearchResponse> restaurants;
  late Future<GeocodingResponse> currLocation;
  List<PlacesSearchResult>? listOfRestaurants;

  /// Begins the logic handling by initialising the relevant APIs, as well as
  /// obtaining the current locations and the list of restaurants

  @override
  void initState() {
    super.initState();
    googlePlace = GoogleMapsPlaces(apiKey: apiKey);
    geocoding = GoogleMapsGeocoding(apiKey: apiKey);
    currLocation = fetchCoords();
    restaurants = fetchRestaurants();
  }

  /// Returns a future containing a list of restaurants based on the user
  /// input from the form. If there are no results, an exception is thrown

  Future<PlacesSearchResponse> fetchRestaurants() async {
    try {
      Location coords = await currLocation
          .then((value) => value.results.first.geometry.location);
      PlacesSearchResponse placesResponse = await googlePlace
          .searchNearbyWithRadius(coords, query!.distance!.getDistance(),
              type: "restaurant",
              maxprice: PriceLevel.values[query!.price!.getPriceLevel()],
              keyword: "${query!.cuisine!.curr!.toLowerCase()} restaurants");
      return placesResponse;
    } catch (exception) {
      return PlacesSearchResponse(status: "hasNoResults");
    }
  }

  /// Returns a future of the location input by the user

  Future<GeocodingResponse> fetchCoords() async {
    GeocodingResponse result =
        await geocoding.searchByAddress(query!.location!);
    return result;
  }

  /// Builds a list tile that contains a result from the list of restaurant results.
  /// The index parameter indicates the index of the results to be returned in the tile.
  /// The snapshot parameter contains the list of results.

  Widget buildTile(int index, AsyncSnapshot<PlacesSearchResponse> snapshot) {
    PlacesSearchResult result = snapshot.data!.results[index];
    return Column(children: [
      ListTile(
          title: Text(result.name),
          onTap: () async {
            String destinationEncode = Uri.encodeComponent(result.name);
            String currLocationEncode = await currLocation.then((value) =>
                Uri.encodeComponent(value.results.first.formattedAddress!));
            print(currLocationEncode);
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

  /// Returns a widget containing a single recommendation. Currently,
  /// the layout of the widget is a single recommendation displayed as a list tile,
  /// and a button "Others" that allows users to view the list of recommendations instead

  Widget randomOption() {
    return Column(children: [
      FutureBuilder<PlacesSearchResponse>(
          future: restaurants,
          builder: (context, snapshot) {
            Random index = Random();
            if (snapshot.data == null) {
              return Text("Loading...");
            } else if (snapshot.data!.results.length == 0) {
              return ErrorPage();
            } else {
              listOfRestaurants = snapshot.data!.results;
              int length = listOfRestaurants!.length;
              int randomNum = index.nextInt(length);
              return buildTile(randomNum, snapshot);
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
    ]);
  }

  /// Returns an app bar for the list of recommendations

  Widget appBar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      flexibleSpace: FlexibleSpaceBar(
        background:
            Image.asset("assets/HomePageBackGround.jpg", fit: BoxFit.cover),
        title: Text("Recommended for you!",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
      ),
      expandedHeight: 100,
    );
  }

  /// Returns a widget that displays the list of recommendations based on the
  /// user input

  Widget resultList() {
    if (listOfRestaurants == null || listOfRestaurants!.length == 0)
      return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Text("no result");
      }, childCount: 1));
    else
      return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return FutureBuilder<PlacesSearchResponse>(
            future: restaurants,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Text("Loading...");
              } else {
                return buildTile(index, snapshot);
              }
            });
      }, childCount: listOfRestaurants!.length));
  }

  /// Returns a widget that contains the app bar for the list of recommendations,
  /// as well as the list itself

  Widget listOfRecommendations() {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[appBar(), resultList()]));
  }

  @override
  Widget build(BuildContext context) {
    return randomOption();
  }
}
