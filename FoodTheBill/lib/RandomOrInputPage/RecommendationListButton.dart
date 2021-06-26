import 'package:flutter/material.dart';
import 'package:foodthebillv2/InputPage/HomePageForm/FoodQuery.dart';
import 'package:foodthebillv2/RecommendationPage/RecommendedListPageWidget.dart';

class RecommendationListButton extends StatelessWidget {
  final FoodQuery? query;
  RecommendationListButton({Key? key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(40),
      padding: EdgeInsets.only(
          top: 30,
      ),
      child: ElevatedButton(
        child: Text(
          "List of Recommendations",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            letterSpacing: 2.0,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,

        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecommendedListPageWidget(
                  query: query,
                )),
          );
        },
      ),
    );
  }
}
