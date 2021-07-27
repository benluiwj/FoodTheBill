import 'package:flutter/material.dart';
import '../UniversalWidgets/LogoBackButtonWidget.dart';
import './CreateAccountForm.dart';

class CreateAccountPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LogoBackButton(),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Creating Account',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            //FoodTheBillLogo(),
            CreateAccountForm(),
          ],
        ),
      ),
    );
  }
}
