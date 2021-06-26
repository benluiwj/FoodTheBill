import 'package:flutter/material.dart';
import '../InputPage/HomePageForm/FoodQuery.dart';
import '../SingleRandomSelectionPage/RandomOptionPageWidget.dart';

class QuickSelectButton extends StatelessWidget {

  final FoodQuery? query;
 QuickSelectButton({Key? key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(40),
      padding: EdgeInsets.only(
        top: 30,
        bottom: 30,
      ),
      child: ElevatedButton(
        child: Text(
          "Single Recommendation",
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
                builder: (context) => RandomOptionPageWidget(
                  query: query,
                )),
          );
        },
      ),
    );
  }
}
