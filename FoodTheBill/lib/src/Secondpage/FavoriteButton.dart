import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:milestone1/src/Secondpage/RecommendationLogic.dart';

/// This class contains the favorited button for the standard recommendations
/// This class was created specifically for the single recommendation

class FavoriteButton extends StatefulWidget {
  final PlacesSearchResult? result;
  final RecommendationLogic? info;

  FavoriteButton({Key? key, this.result, this.info}) : super(key: key);

  @override
  FavoriteButtonState createState() {
    FavoriteButtonState state = FavoriteButtonState();
    state.result = result;
    state.info = info;
    return state;
  }
}

class FavoriteButtonState extends State<FavoriteButton> {
  PlacesSearchResult? result;
  RecommendationLogic? info;
  List<PlacesSearchResult>? favRest;

  @override
  void initState() {
    super.initState();
    favRest = info!.favRest;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.favorite),
        onPressed: () {
          setState(() {
            if (favRest!.contains(result))
              favRest!.remove(result);
            else
              favRest!.add(result!);
          });
        },
        color: favRest!.contains(result) ? Colors.red : null);
  }
}
