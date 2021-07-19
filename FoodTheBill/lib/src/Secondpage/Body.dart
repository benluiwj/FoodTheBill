import 'package:flutter/material.dart';
import 'package:milestone1/src/HomePageForm/FoodQuery.dart';
import 'package:milestone1/src/Secondpage/Header.dart';
import 'package:milestone1/src/Secondpage/Recommended.dart';

import '../../SizeConfig.dart';

class Body extends StatelessWidget {
  final FoodQuery? query;
  Body({Key? key, this.query}) : super(key: key);

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white10,
            iconTheme: IconThemeData(color: Colors.black)),
        body: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: SafeArea(
            top: false,
            child: Column(children: [Header(), Recommended(query: this.query)]),
          ),
        ));
  }
}
