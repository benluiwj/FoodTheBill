import 'package:flutter/material.dart';

class HoriDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
          ),
          Text(
            'Continue With',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade800,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
