import 'package:flutter/material.dart';
import 'package:order_booking_app/widgets/text_field_container.dart';

import '../constants.dart';
class RoundedInputField extends StatelessWidget {
  const RoundedInputField({super.key, this.hintText, this.icon = Icons.person});
  final String? hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(fontFamily: 'OpenSans'),
            border: InputBorder.none),
      ),
    );
  }
}