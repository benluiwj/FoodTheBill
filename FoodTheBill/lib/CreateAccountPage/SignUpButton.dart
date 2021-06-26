import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.only(top: 10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  letterSpacing: 2.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              // Icon(
              //   Feather.user_plus,
              //   size: 20,
              // )
            ],
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
    );
  }
}
