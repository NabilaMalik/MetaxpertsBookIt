import 'package:flutter/material.dart';
import 'package:order_booking_app/screens/location_screen.dart';
class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Get screen size and orientation
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
          Container(
            color: Colors.blue,
            width: screenWidth,
            height: screenHeight,
          ),
          // Add Camera Icon at the center top
          Positioned(
            top: screenHeight * 0.15, // Position the icon relative to screen height
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                child: Icon(
                  Icons.camera_alt,
                  size: screenWidth * 0.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.42,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.64,
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
                    'Camera Permission',
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
                      'Granting permission for the camera to take a selfie makes your login secure with AI integration in the tool, which minimizes the chances of someone else going through your data.',
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
            bottom: screenHeight * 0.05,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                // Navigate to SplashScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LocationScreen()),
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
