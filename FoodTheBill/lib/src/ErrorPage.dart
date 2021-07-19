import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("No results"),
        content: Text(
            "The location you have entered yielded no results, try entering another location"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text("Ok"))
        ]);
  }
}
