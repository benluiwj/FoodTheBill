import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../InputPage/InputPageWidget.dart';
import '../LoginPage/LoginPageWidget.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapShot) {
        if (userSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (userSnapShot.connectionState == ConnectionState.active) {
          if (userSnapShot.hasData) {
            print('The user is already logged in');
            return InputPageWidget();
          } else {
            print("The user didn't login yet");
            return LoginPageWidget();
          }
        } else if (userSnapShot.hasError) {
          return Center(
            child: Text('Error Occurred'),
          );
        }
        return Center(
          child: Text('Unknown error had occurred'),
        );
      },
    );
  }
}
