import 'package:flutter/material.dart';

class BackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.only(top: 40, left: 20),
      child: InkWell(
        child: SizedBox(
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "< Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ))),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
