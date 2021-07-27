import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:milestone1/src/Secondpage/RecommendationLogic.dart';
import 'package:url_launcher/url_launcher.dart';

/// This class displays the saved restaurants based on what the user favorited

class SavedRestaurants extends StatefulWidget {
  final RecommendationLogic? info;
  SavedRestaurants({this.info});

  @override
  SavedRestaurantsState createState() {
    SavedRestaurantsState state = SavedRestaurantsState();
    state.info = info;
    return state;
  }
}

class SavedRestaurantsState extends State<SavedRestaurants> {
  RecommendationLogic? info;

  @override
  void initState() {
    super.initState();
  }

  /// Returns the individual tile of the favorite restaurant

  Widget buildTile(PlacesSearchResult result) {
    return ListTile(
        title: Text(result.name),
        subtitle: Text(result.vicinity!),
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
        });
  }

  /// Returns a list view of the favorited restaurants. If nothing is favorited,
  /// the list is empty

  List<Widget> divided() {
    Iterable<Widget> tiles = info!.favRest.map((e) => buildTile(e));
    return tiles.isNotEmpty
        ? ListTile.divideTiles(
                tiles: tiles, context: context, color: Colors.black54)
            .toList()
        : <Widget>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Restaurants", style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white10,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: divided(),
      ),
    );
  }
}
