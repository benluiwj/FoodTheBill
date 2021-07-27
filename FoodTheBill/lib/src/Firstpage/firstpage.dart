//THIS IS THE FIRST PAGE OF THE APP
import 'package:flutter/material.dart';
import '../HomePageForm/HomePageForm.dart';

import 'foodthebill.dart';

///FirstPage consists of the form as well as the title, "FoodTheBill" to be filled in by the user.
/// This is the main page the user will go to after they have signed into the app.

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
