import 'package:flutter/material.dart';
import 'package:order_booking_app/screens/contact_screen.dart';


class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size and orientation
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Define a list of colors for the ellipses
    List<Color> ellipseColors = [
      Colors.grey,
      Colors.blue,
      Colors.grey,
      Colors.grey,
      Colors.grey,
      Colors.grey,
      Colors.grey,
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Blue background container
          Container(
            color: Colors.blue, // Set the background color to blue
            width: screenWidth, // Use full screen width
            height: screenHeight, // Use full screen height
          ),

          // Add Camera Icon at the center top
          Positioned(
            top: screenHeight * 0.15, // Position the icon relative to screen height
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Maintain circular shape
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.black.withOpacity(0.3), // Shadow color with opacity
                  //       blurRadius: 10, // Amount of blur
                  //       spreadRadius: 2, // Spread of the shadow
                  //       offset: Offset(0, 5), // Offset to create a bottom shadow
                  //     ),
                  //   ],
                ),
                child: Icon(
                  Icons.location_on, // Use the camera icon
                  size: screenWidth * 0.4, // Adjust size relative to screen width
                  color: Colors.white, // Set the color of the icon to white
                ),
              ),
            ),
          ),

          // White container with top padding and border radius
          Positioned(
            top: screenHeight * 0.42, // Position the white container relative to screen height
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.69, // Set height relative to screen height
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
                  // Add seven ellipses in a row with different colors, before the text
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
                  SizedBox(height: screenHeight * 0.03), // Space between ellipses and text

                  // Existing Text
                  const Text(
                    'Location Permission',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // New Text with padding
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.03,
                    ),
                    child: const Text(
                      'We would like to access and store your location, only when you are logged into the app. Background Location access is only to measure the distance traveled, to fill the locations in the forms, these data are only stored on the device storage and our server and can be deleted at any time.',
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

          // Button for navigation
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
                // Navigate to SplashScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactScreen()), // Replace with your desired screen
                );
              },
              child: const Text(
                'ALLOW',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
