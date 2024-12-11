// import 'package:flutter/material.dart';
// import 'package:order_booking_app/widgets/text_field_container.dart';
//
// import '../constants.dart';
//
// class RoundedPasswordField extends StatelessWidget {
//   const RoundedPasswordField({
//     super.key,
//     required bool isPasswordVisible,
//     required Null Function() togglePasswordVisibility,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFieldContainer(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 20.0),  // Horizontal padding for the text field
//         child: TextFormField(
//           obscureText: true, // Keeps password hidden
//           cursorColor: kPrimaryColor,
//           decoration: InputDecoration(
//             icon: const Icon(
//               Icons.lock,
//               color: kPrimaryColor,
//             ),
//             hintText: "Password",
//             hintStyle: const TextStyle(fontFamily: 'OpenSans'),
//             suffixIcon: const Icon(
//               Icons.visibility,
//               color: kPrimaryColor,
//             ),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey, width: 1.5), // Border width when not focused
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: kPrimaryColor, width: 2.0), // Border width when focused
//             ),
//             border: InputBorder.none,
//             contentPadding: const EdgeInsets.only(bottom: 10),  // Padding for content (i.e., text inside)
//           ),
//         ),
//       ),
//     );
//   }
// }
