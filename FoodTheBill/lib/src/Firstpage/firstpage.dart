//THIS IS THE FIRST PAGE OF THE APP
import 'package:flutter/material.dart';
import '../HomePageForm/HomePageForm.dart';

import 'foodthebill.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FoodTheBill(),
          HomePageForm(),
        ],
      ),
    );
  }
}
