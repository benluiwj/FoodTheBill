import 'package:flutter/material.dart';
import '../UniversalWidgets/LogoBackButtonPopUp.dart';
import '../../InputPage/HomePageForm/FoodQuery.dart';
import '../UniversalWidgets/LogoPopUpWidget.dart';
import './QuickSelectButton.dart';
import './RecommendationListButton.dart';
import './Or.dart';

class RandomOrInputPageWidget extends StatelessWidget {

  final FoodQuery? query;
  RandomOrInputPageWidget({Key? key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //FoodTheBillLogo(),
          LogoBackButtonPopUp(),
          QuickSelectButton(query: query,),
          Or(),
          RecommendationListButton(query: query,),
        ],
      ),
    );
  }
}