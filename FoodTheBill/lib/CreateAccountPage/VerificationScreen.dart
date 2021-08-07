import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodthebillv2/UniversalWidgets/FoodTheBillLogo.dart';

import '../LoginPage/LoginPageWidget.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  @override
  void initState() {
    user = _auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = _auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer!.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPageWidget()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          FoodTheBillLogo(),
          Image.asset("assets/free-send-mail-icon-2574-thumb.png", colorBlendMode: BlendMode.darken,),
          Center(
            child: Text(
              'An email has been sent to',
              style: TextStyle(fontSize: 20, ),
            ),
          ),
          Center(
            child: Text(
              '${user!.email}.',
              style: TextStyle(fontSize: 20, color: Colors.blueAccent, ),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: Text(
              "Please verify your email.",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
