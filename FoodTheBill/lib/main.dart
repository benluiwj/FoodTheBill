import 'package:flutter/material.dart';
import 'package:milestone1/src/Secondpage/SecondPage.dart';
import 'src/Firstpage/firstpage.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/second': (context) => SecondPage()
      },
    );
  }
}
