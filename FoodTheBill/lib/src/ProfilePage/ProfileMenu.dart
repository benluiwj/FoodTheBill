import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// This class contains the format for the profile menu items

class ProfileMenu extends StatelessWidget {
  const ProfileMenu(
      {Key? key, required this.text, required this.icon, required this.press})
      : super(key: key);
  final String text, icon;
  final Function()? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.grey[300],
        ),
        onPressed: press,
        child: Row(children: [
          SvgPicture.asset(
            icon,
            width: 22,
            color: Colors.black,
          ),
          SizedBox(width: 20),
          Expanded(
              child: Text(
            text,
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
