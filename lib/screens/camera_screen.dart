import 'package:flutter/material.dart';
import 'package:order_booking_app/screens/login_screen.dart';
import 'package:order_booking_app/screens/splash_screen.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a list of colors for the ellipses
    List<Color> ellipseColors = [
      Colors.blue,
      Colors.grey,
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
            width: double.infinity, // Fill the entire width of the screen
            height: double.infinity, // Fill the entire height of the screen
            child: Column(
              children: [
                const SizedBox(height: 100), // Add spacing from the top
                Center(
                  child: Image.asset(
                    'assets/images/camera-removebg-preview.png', // Replace with your image path
                    width: 200,
                    height: 200,
                  ),
                ),
              ],
            ),
          ),

          // White container with top padding and border radius
          Positioned(
            top: 364, // Position the white container from the top
            left: 0,
            right: 0,
            child: Container(
              height: 770, // Set height of the white container
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              padding: const EdgeInsets.only(top: 10, bottom: 409), // Padding inside the white container
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add seven ellipses in a row with different colors, before the text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(7, (index) {
                      return Container(
                        width: 14,
                        height: 14,
                        margin: const EdgeInsets.symmetric(horizontal: 5), // Add space between ellipses
                        decoration: BoxDecoration(
                          color: ellipseColors[index], // Use the color from the list
                          shape: BoxShape.circle, // Make each shape an ellipse (circle)
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 30), // Space between ellipses and text

                  // Existing Text
                  const Text(
                    'Camera Permission',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black, // Text color
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // New Text with padding
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 49.0, vertical: 45.0), // Add padding here
                    child: Text(
                      'Granting permission for camera to take selfie makes your login secure with AI integration in the tool, which minimizes the chances of someone else going through your data.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black, // Slightly lighter text color
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
            bottom: 50, // Position button 50 pixels from the bottom
            left: 50, // Fixed left position
            right: 50, // Fixed right position
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                // Navigate to SplashScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()), // Replace with your desired screen
                );
              },
              child: const Text(
                'Go to Login Screen',
                style: TextStyle(
                  color: Colors.white, // Text color
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
