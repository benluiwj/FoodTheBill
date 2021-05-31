import 'package:flutter/material.dart';
import 'First page/firstpage.dart';
import 'Second page/recommended.dart';

void main() => runApp(App());

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
        '/second': (context) => Recommended(),
      },
    );
  }
}
