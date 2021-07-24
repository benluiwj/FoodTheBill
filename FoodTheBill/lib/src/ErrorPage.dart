import 'package:flutter/material.dart';

/// This class contains a widget that is displayed when there is an error.
/// It is mainly used when the no results are found for the user input location.
/// A dialog is presented and closing it brings the user back to the form page,
/// to re-enter another location

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
