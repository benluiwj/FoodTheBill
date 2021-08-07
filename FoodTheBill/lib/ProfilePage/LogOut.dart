import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogOut extends StatefulWidget {
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> authErrorHandling(String text, BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 6.0),
                child: Image.network(
                  'https://image.flaticon.com/icons/png/128/1828/1828304.png',
                  width: 30,
                  height: 30,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Sign Out'),
              )
            ],
          ),
          content: Text(
            text,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await _auth.signOut().then((value) =>
                    Navigator.popUntil(context, ModalRoute.withName("/")));
              },
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.grey[300],
        ),
        onPressed: () async {
          authErrorHandling("Do you want to Sign Out?", context);
        },
        child: Row(children: [
          SvgPicture.asset(
            "assets/Log out.svg",
            width: 22,
            color: Colors.black,
          ),
          SizedBox(width: 20),
          Expanded(
              child: Text(
            "Log out",
            style: Theme.of(context).textTheme.bodyText1,
          )),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          )
        ]),
      ),
    );
  }
}
