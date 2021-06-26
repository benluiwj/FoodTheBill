import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PopUpMenuWidget extends StatefulWidget {
  @override
  _PopUpMenuWidgetState createState() => _PopUpMenuWidgetState();
}

class _PopUpMenuWidgetState extends State<PopUpMenuWidget> {
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
              )
              ,
            )
            ,
          ]
          ,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopupMenuButton(
        onSelected: null,
        itemBuilder: (context) {
          return List.generate(1, (index) {
            return PopupMenuItem(
              child: InkWell(
                child: ListTile(
                  onTap: () async {
                    authErrorHandling("Do you want to Sign Out?", context);
                  },
                  title: Text("Sign Out"),
                  leading: Icon(Icons.logout),
                ),
              ),
            );
          });
        });
  }

}