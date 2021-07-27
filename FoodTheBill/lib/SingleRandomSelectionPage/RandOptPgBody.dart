// import 'package:flutter/material.dart';
// import '../UniversalWidgets/SettingsWidget.dart';
// import '../InputPage/HomePageForm/FoodQuery.dart';
// import '../../ProfilePage/ProfileScreen.dart';
// import '../InputPage/InputPageLayout/SecondPageHeader.dart';
// import 'RecommendationSingle.dart';
//
// import '../../UniversalWidgets/SizeConfig.dart';
//
// class RandOptPgBody extends StatelessWidget {
//   final FoodQuery? query;
//
//   RandOptPgBody({Key? key, this.query}) : super(key: key);
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
//     SizeConfig().init(context);
//     return Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.transparent,
//             iconTheme: IconThemeData(color: Colors.black),
//             actions: <Widget>[
//               SettingsWidget(),
//             ]),
//         body: SingleChildScrollView(
//           clipBehavior: Clip.none,
//           child: SafeArea(
//             top: false,
//             child: Column(children: [
//               Header(),
//               RandomOptionPageWidget(query: this.query),
//               //profileButton(context)
//             ]),
//           ),
//         ));
//   }
// }
