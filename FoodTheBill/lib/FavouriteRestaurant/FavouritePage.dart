import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodthebillv2/RecommendationPage/RecommendationList.dart';
import 'package:foodthebillv2/SingleRandomSelectionPage/RecommendationSingle.dart';
import 'package:foodthebillv2/UniversalWidgets/RecommendationLogic.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:url_launcher/url_launcher.dart';
import '../UniversalWidgets/SettingsWidget.dart';

class FavouritePage extends StatefulWidget {
  final RecommendationLogic? info;
  FavouritePage({this.info});

  @override
  FavouritePageState createState() {
    FavouritePageState state = FavouritePageState();
    state.info = info;
    return state;
  }
}

class FavouritePageState extends State<FavouritePage> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore db = FirebaseFirestore.instance;
  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  RecommendationLogic? info;
  List<PlacesSearchResult> favList = [];
  late FirebaseFirestore db;
  late FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    db = FirebaseFirestore.instance;
    auth = FirebaseAuth.instance;

    Firebase.initializeApp();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            // leading: Back,
            title: Text(
              "Favourites",
              style: TextStyle(
                  fontFamily: "Caveat",
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Colors.black),
            ),
            actions: <Widget>[
              SettingsWidget(),
            ],
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            flexibleSpace: Image(
                image: AssetImage("assets/HomePageBackGround.jpg"),
                fit: BoxFit.fill)),
        body: Center(
          child: StreamBuilder(
            stream: db.collection('users')
                .doc(auth.currentUser!.uid)
                .collection("restaurants")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("Loading..."),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map(
                  (restaurant) {
                    return Column(children: [
                      ListTile(
                        title: Text(restaurant['name of restaurant']),
                        subtitle: Text(restaurant['location of restaurant']),
                        trailing: IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () {
                            setState(() {
                              restaurant.reference.delete();
                            });
                          },
                          color: Colors.red,
                        ),
                        onTap: () async {
                          String destinationEncode = Uri.encodeComponent(
                              restaurant["name of restaurant"]);
                          String url =
                              'https://www.google.com/maps/dir/?api=1&origin=&destination=$destinationEncode';
                          if (await canLaunch(url))
                            await launch(url);
                          else
                            throw Exception('Did not launch');
                        },
                      ),
                      Divider(
                        color: Colors.black54,
                      ),
                    ]);
                  },
                ).toList(),
              );
            },
          ),
        ),

    );
  }
}
