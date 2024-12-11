import 'package:flutter/material.dart';
import 'package:order_booking_app/screens/login_screen.dart';
import 'package:order_booking_app/screens/splash_screen.dart'; // Adjust the import path to your login screen

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Get screen size

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background Container
            Container(
              width: double.infinity,
              height: size.height, // Fill the entire screen
              color: Colors.white, // Background color (same as LoginScreen theme)
            ),
            // Upper section container (blue section, similar to LoginScreen)
            Container(
              width: double.infinity,
              height: 330, // Adjust as per requirement
              color: Colors.red,
            ),
            // Lower section container (white section, similar to LoginScreen)
            Positioned(
              top: 440, // Align with the blue section
              child: Container(
                width: double.infinity,
                height: size.height - 440, // Rest of the screen
                color: Colors.white, // White background
              ),
            ),
            // Navigation Button to Login Screen
            Positioned(
              bottom: 50, // Position button towards the bottom
              left: size.width * 0.25,
              right: size.width * 0.25,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Navigate to LoginScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SplashScreen()),
                  );
                },
                child: const Text(
                  'Go to Login Screen',
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
      ),
    );
  }
}
