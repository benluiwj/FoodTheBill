import 'package:flutter/material.dart';

class ForgetPasswordText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Forget Password',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}