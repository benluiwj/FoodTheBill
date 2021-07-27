// import 'package:flutter/material.dart';
// import '../InputPage/HomePageForm/FoodQuery.dart';
// import '../../ProfilePage/ProfileScreen.dart';
// import '../InputPage/InputPageLayout/SecondPageHeader.dart';
// import 'RecommendationList.dart';
//
// import '../../UniversalWidgets/SizeConfig.dart';
//
// class RecommendListPgBody extends StatelessWidget {
//   final FoodQuery? query;
//   RecommendListPgBody({Key? key, this.query}) : super(key: key);
//
//   Widget profileButton(BuildContext context) {
//     return ElevatedButton(
//         child: Text(
//           "profile",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             letterSpacing: 2.0,
//             fontStyle: FontStyle.italic,
//           ),
//         ),
//         style: ElevatedButton.styleFrom(
//           primary: Colors.black,
//         ),
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return ProfileScreen();
//           }));
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RecommendedListPageWidget(query: this.query,);
//   }
// }