import 'package:flutter/material.dart';
import '../UniversalWidgets/FoodTheBillLogo.dart';
import 'ForgotPasswordButton.dart';
import '../UniversalWidgets/LogoPopUpWidget.dart';
import './CreateAccountButton.dart';
import './IntroText.dart';
import './HoriDivider.dart';
import './LoginForm.dart';

class LoginPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FoodTheBillLogo(),
            IntroText(),
            LoginForm(),
            // LoginButton(),
            HoriDivider(),
            CreateAccountButton(),
            ForgotPasswordButton(),
          ],
        ),
      ),
    );
  }
}