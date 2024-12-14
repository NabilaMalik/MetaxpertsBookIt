import 'package:flutter/material.dart';

import '../constants.dart';
class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key, this.press, this.textColor = Colors.white, required this.text});
  final String text;
  final Function()? press;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 9),
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 12),
          textStyle: TextStyle(
              letterSpacing: 1,
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'
          )
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white,fontSize: 28),
      ),
    );
  }


}