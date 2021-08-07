import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class FavouriteRest {

  List<PlacesSearchResult> favourite = <PlacesSearchResult>[];

  @override
  String toString() {
    // TODO: implement toString
    List<String> res = <String>[];
    for (int i = 0; i < favourite.length; i++) {
      res.add(favourite[i].name);
    }
    return res.toString();
  }

}
