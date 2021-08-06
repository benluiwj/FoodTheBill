import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:milestone1/src/Secondpage/RecommendationLogic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  late FirebaseFirestore db;

  @override
  void initState() {
    super.initState();
    favRest = info!.favRest;
    db = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference ref = db.collection('data').doc(result!.placeId);
    return FutureBuilder<DocumentSnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Icon(null);
          else {
            if (snapshot.data!.exists) {
              return IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  setState(() {
                    ref.delete();
                  });
                },
                color: Colors.red,
              );
            } else {
              return IconButton(
                  icon: Icon(Icons.favorite),
                  color: null,
                  onPressed: () {
                    setState(() {
                      ref.set({
                        'name of place': result!.name,
                        'location': result!.vicinity
                      });
                    });
                  });
            }
          }
        });
    /*IconButton(
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
  }*/
  }
}
