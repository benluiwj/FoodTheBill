import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:url_launcher/url_launcher.dart';

import '../HomePageForm/FoodQuery.dart';
import '.././ErrorPage.dart';

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
  List<PlacesSearchResult>? listOfRestaurants;

  @override
  void initState() {
    super.initState();
    googlePlace = GoogleMapsPlaces(apiKey: apiKey);
    geocoding = GoogleMapsGeocoding(apiKey: apiKey);
    currLocation = fetchCoords();
    restaurants = fetchRestaurants();
  }

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

  Future<GeocodingResponse> fetchCoords() async {
    GeocodingResponse result =
        await geocoding.searchByAddress(query!.location!);
    return result;
  }

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

  Widget randomOption() {
    //return Scaffold(
    //body:
    return Column(children: [
      /*AppBar(
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
          )),*/
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
              //return Text(snapshot.data!.results[index.nextInt(length)].name);
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

  Widget appBar() {
    return SliverAppBar(
      /*floating: false,
        pinned: false,
        snap: false,*/
      pinned: true,
      //title: Text("this is title"),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      flexibleSpace: FlexibleSpaceBar(
        background:
            Image.asset("assets/HomePageBackGround.jpg", fit: BoxFit.cover),
        title: Text("Recommended for you!",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        //titlePadding:
        //  EdgeInsetsDirectional.only(bottom: 100, start: 40, end: 40),
      ),
      expandedHeight: 100,
    );
  }

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
                /*else if (snapshot.data!.results.length == 0) {
                return LocationErrorScreen();*/
              } else {
                return buildTile(index, snapshot);
              }
            });
      }, childCount: listOfRestaurants!.length));
  }

  Widget listOfRecommendations() {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[appBar(), resultList()]));
  }

  @override
  Widget build(BuildContext context) {
    //return Recommendations(this);
    return randomOption();
  }
}
