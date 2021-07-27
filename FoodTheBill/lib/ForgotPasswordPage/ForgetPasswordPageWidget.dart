import 'package:flutter/material.dart';
import '../UniversalWidgets/LogoBackButtonWidget.dart';
import 'ForgetPasswordForm.dart';
import 'ForgetPasswordText.dart';

class ForgetPasswordPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LogoBackButton(),
            ForgetPasswordText(),
            ForgetPasswordForm(),
          ],
        ),
      ),
    );
  }
}