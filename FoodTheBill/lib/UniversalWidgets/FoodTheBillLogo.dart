import 'package:flutter/material.dart';

class FoodTheBillLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 80),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Text(
                    "FoodTheBill",
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: "Caveat",
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
