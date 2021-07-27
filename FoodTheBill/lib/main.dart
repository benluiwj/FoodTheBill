import 'package:flutter/material.dart';
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
      home: FirstPage(),
      //home: ProfileScreen(),
    );
  }
}
