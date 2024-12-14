import 'package:flutter/material.dart';
import 'package:order_booking_app/screens/addshop_screen.dart';
import 'package:order_booking_app/screens/location_screen.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
          MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
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
          // Background container
          Container(
            color: Colors.black,
            width: screenWidth,
            height: screenHeight,
          ),

          // Blue container with camera icon
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.66,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              padding: EdgeInsets.only(bottom: 160),
              child: Center(
                child: Icon(
                  Icons.camera_alt,
                  size: screenWidth * 0.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // White container
          Positioned(
            top: screenHeight * 0.4,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
                horizontal: screenWidth * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ellipses row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(7, (index) {
                      return Container(
                        width: screenWidth * 0.033,
                        height: screenWidth * 0.033,
                        margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: ellipseColors[index],
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: screenHeight * 0.04),

                  // Title
                  Text(
                    'Camera Permission',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Description
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                    ),
                    child: Text(
                      'Granting permission for the camera to take a selfie makes your login secure with AI integration in the tool, which minimizes the chances of someone else going through your data.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Responsive button
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocationScreen(),
                  ),
                );
              },
              child: Text(
                'ALLOW',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // TextButton to navigate to AddshopScreen
          Positioned(
            bottom: screenHeight * 0.15,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddshopScreen(),
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
        ],
      ),
    );
  }
}
