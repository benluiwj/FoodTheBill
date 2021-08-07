import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import '../UniversalWidgets/RecommendationLogic.dart';

/// This class contains the favorite button for the standard recommendations
/// This class was created specifically for the single recommendation
///
class FavoriteButton extends StatefulWidget {
  final PlacesSearchResult? result;
  final RecommendationLogic? info;
  //final AsyncSnapshot<PlacesSearchResponse>? snapshot;

  FavoriteButton({Key? key, this.result, this.info}) : super(key: key);

  @override
  FavoriteButtonState createState() {
    FavoriteButtonState state = FavoriteButtonState();
    state.result = result;
    state.info = info;
    //state.snapshot = snapshot;
    return state;
  }
}

class FavoriteButtonState extends State<FavoriteButton> {
  PlacesSearchResult? result;
  RecommendationLogic? info;
  List<PlacesSearchResult>? favRest;
  //AsyncSnapshot<PlacesSearchResponse>? snapshot;
  late FirebaseFirestore db;

  late FirebaseAuth _auth;
  // final FirebaseFirestore db = FirebaseFirestore.instance;
  // CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    favRest = info!.favRest;
    db = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentReference currentUser = users.doc(_auth.currentUser!.uid);
    DocumentReference querySnapshot = currentUser.collection("restaurants").doc(result!.placeId);

    return StreamBuilder<DocumentSnapshot<Object?>>(
      stream: querySnapshot.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.data!.exists) {
            return IconButton(
              icon: Icon(Icons.favorite),
              color: Colors.red,
              onPressed: () {
                setState(() {
                  querySnapshot.delete();
                });
              },
            );
          } else {
            return IconButton(
              icon: Icon(Icons.favorite_border),
              color: null,
              onPressed: () {
                setState(() {
                  querySnapshot.set({
                    "name of restaurant": result!.name,
                    "location of restaurant": result!.vicinity
                  });
                });
              },
            );
          }
        }
      },
    );
  }
}