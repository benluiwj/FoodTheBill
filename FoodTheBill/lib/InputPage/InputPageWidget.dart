import 'package:flutter/material.dart';
import '../UniversalWidgets/LogoBackButtonPopUp.dart';
import 'HomePageForm/HomePageForm.dart';

import '../UniversalWidgets/LogoPopUpWidget.dart';

class InputPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //LogoBackButtonPopUp(),
            LogoPopUpWidget(),
            HomePageForm(),
          ],
        ),
      ),
    );
  }
}
