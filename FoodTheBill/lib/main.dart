import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ForgotPasswordPage/ForgetPasswordPageWidget.dart';
import 'RandomOrInputPage/RandomOrInputPageWidget.dart';
import 'InputPage/InputPageWidget.dart';
import 'RecommendationPage/RecommendedListPageWidget.dart';
import 'SingleRandomSelectionPage/RandomOptionPageWidget.dart';
import 'LoginPage/LoginPageWidget.dart';
import 'CreateAccountPage/CreateAccountPageWidget.dart';
import 'UniversalWidgets/UserState.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  AppState createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error occurred'),
              ),
            ),
          );
        }
        return MaterialApp(
          //initialRoute: '/',
          home: UserState(),
          routes: {
            // '/': (context) => LoginPageWidget(),
            '/second': (context) => InputPageWidget(),
            '/third': (context) => RandomOrInputPageWidget(),
            '/four': (context) => RandomOptionPageWidget(),
            '/five': (context) => RecommendedListPageWidget(),
            '/six': (context) => CreateAccountPageWidget(),
            '/seven': (context) => ForgetPasswordPageWidget(),
          },
        );
      },
    );
  }
}
