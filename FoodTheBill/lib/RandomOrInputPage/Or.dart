import 'package:flutter/material.dart';

class Or extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 25.0, right: 15.0),
            child: Divider(
              color: Colors.black,
            )),
      ),
      Text(
        "OR",
        style: TextStyle(
          fontSize: 25,
          letterSpacing: 2.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 15.0, right: 25.0),
            child: Divider(
              color: Colors.black,
            )),
      ),
    ]);
  }
}
