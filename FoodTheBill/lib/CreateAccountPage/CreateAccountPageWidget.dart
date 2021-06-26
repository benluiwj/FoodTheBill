import 'package:flutter/material.dart';
import '../UniversalWidgets/LogoBackButtonPopUp.dart';
import '../UniversalWidgets/LogoPopUpWidget.dart';
import './CreateAccountForm.dart';

class CreateAccountPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LogoBackButtonPopUp(),
            //FoodTheBillLogo(),
            CreateAccountForm(),
          ],
        ),
      ),
    );
  }
}