import 'package:flutter/material.dart';
import 'package:foodthebillv2/FavouriteRestaurant/FavouriteRest.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:url_launcher/url_launcher.dart';

import '../InputPage/HomePageForm/FoodQuery.dart';

/// This class contains the logic of processing the food query object
class RecommendationLogic {
  final String apiKey = "AIzaSyAso_tOsxE6y4X7fPcpWiwUZt6SiDPstO8";
  late FoodQuery? query;
  late GoogleMapsPlaces googlePlace;
  late GoogleMapsGeocoding geocoding;
  late Future<PlacesSearchResponse> restaurants;
  late Future<GeocodingResponse> currLocation;
  late List<PlacesSearchResult> favRest;

  RecommendationLogic({FoodQuery? query}) {
    this.query = query;
    googlePlace = GoogleMapsPlaces(apiKey: apiKey);
    geocoding = GoogleMapsGeocoding(apiKey: apiKey);
    favRest = FavouriteRest().favourite;
    currLocation = fetchCoords();
    restaurants = fetchRestaurants();

  }

  /// Returns a future that contains the list of restaurants on completion
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

  /// Returns a future that contains the coordinates of the user input location
  Future<GeocodingResponse> fetchCoords() async {
    GeocodingResponse result =
    await geocoding.searchByAddress(query!.location!);
    return result;
  }

  /// Returns a widget that displays the restaurant name together with a divider
  /// below it
  Widget buildTile(int index, AsyncSnapshot<PlacesSearchResponse> snapshot) {
    PlacesSearchResult result = snapshot.data!.results[index];
    return Column(children: [
      ListTile(
          title: Text(result.name),
          subtitle: Text(result.vicinity!),
          trailing: IconButton(icon: Icon(Icons.favorite), onPressed: () {
            print(favRest.contains(result));
            print (favRest.toString());
            if (favRest.contains(result)) favRest.remove(result);
            print(favRest.toString());
            favRest.add(result);
          },
          color: favRest.contains(result) ? Colors.red : null),
          onTap: () async {
            String destinationEncode = Uri.encodeComponent(result.name);
            String currLocationEncode = await currLocation.then((value) =>
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

  /// Returns a string representation to show that the logic was initialised
  @override
  String toString() {
    return "logic initialised";
  }
}