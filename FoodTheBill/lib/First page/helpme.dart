import 'package:flutter/material.dart';

class HelpMe extends StatelessWidget {
  //final Function selectHandler;
  // final String locationText;
  // final String cuisineText;
  // final String priceRangeText;

  //HelpMe(this.locationText, this.cuisineText, this.priceRangeText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(40),
      padding: EdgeInsets.only(
          top: 30
      ),
      child: ElevatedButton(
        child: Text(
          "HELP ME!!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            letterSpacing: 2.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,

        ),
        onPressed: () {
          Navigator.pushNamed(context, '/second');
        },
      ),
    );
  }
}
