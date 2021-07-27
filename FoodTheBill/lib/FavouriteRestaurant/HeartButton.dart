// import 'package:flutter/material.dart';
// import 'package:google_maps_webservice/places.dart';
//
// import 'FavouriteRest.dart';
//
// class HeartButton extends StatefulWidget {
//   final PlacesSearchResult? result;
//
//   HeartButton({Key? key, this.result}) : super(key: key)
//
//   @override
//   _HeartButtonState createState() {
//     _HeartButtonState hbs =_HeartButtonState();
//     hbs.res = result;
//     hbs.lst = favRest;
//   }
// }
//
// class _HeartButtonState extends State<HeartButton> {
//   PlacesSearchResult? res;
//   List<PlacesSearchResult>? lst;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           setState(() {
//             if (lst!.contains(res!)) {
//               lst!.remove(res!);
//             } else {
//               lst!.add(res!);
//             }
//           });
//         },
//         icon: Icon(
//           lst!.contains(res!) ? Icons.favorite : Icons.favorite_outline_rounded,
//           color: lst!.contains(res!) ? Colors.red : null,
//         ),
//     );
//   }
// }
