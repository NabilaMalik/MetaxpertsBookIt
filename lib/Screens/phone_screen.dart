import 'package:flutter/material.dart';
import 'package:order_booking_app/screens/reconfirm_order_screen.dart';
import 'package:order_booking_app/screens/storage_screen.dart';
class PhoneScreen extends StatelessWidget {
  const PhoneScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    List<Color> ellipseColors = [
      Colors.grey,
      Colors.grey,
      Colors.grey,
      Colors.blue,
      Colors.grey,
      Colors.grey,
      Colors.grey,
    ];
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue, // Set the background color to blue
            width: screenWidth, // Use full screen width
            height: screenHeight, // Use full screen height
          ),
          Positioned(
            top: screenHeight * 0.15, // Position the icon relative to screen height
            left: 0,
            right: 0,
            child: Center(
              child: Icon(
                Icons.phone, // Use the camera icon
                size: screenWidth * 0.5, // Adjust size relative to screen width
                color: Colors.white, // Set the color of the icon to white
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.42,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.65,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              padding: EdgeInsets.only(
                top: screenHeight * 0.01,
                bottom: screenHeight * 0.3,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(7, (index) {
                      return Container(
                        width: screenWidth * 0.035,
                        height: screenWidth * 0.035,
                        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                        decoration: BoxDecoration(
                          color: ellipseColors[index],
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  const Text(
                    'Phone Permission',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.03,
                    ),
                    child: const Text(
                      'We need permission to detect incoming/Outgoing/Missed calls, to enable intelligent status updation. We respect your privacy and we will make sure to not upload any of your personal contacts.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.15,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReconfirmOrderScreen(),
                  ),
                );
              },

              child: const Text(
                "Go to New Screen",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.05, // Position button relative to screen height
            left: screenWidth * 0.1, // Fixed left position
            right: screenWidth * 0.1, // Fixed right position
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StorageScreen()), // Replace with your desired screen
                );
              },
              child: const Text(
                'ALLOW',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}