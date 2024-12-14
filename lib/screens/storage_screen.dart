import 'package:flutter/material.dart';
import 'package:order_booking_app/screens/record_audio_screen.dart';
class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // Define a list of colors for the ellipses
    List<Color> ellipseColors = [
      Colors.grey,
      Colors.grey,
      Colors.grey,
      Colors.grey,
      Colors.blue,
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
            height: screenHeight,
          ),
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            right: 0,
            child: Center(
              child: Icon(
                Icons.storage_outlined,
                size: screenWidth * 0.5,
                color: Colors.white,
              ),
            ),
          ), Positioned(
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
                  SizedBox(height: screenHeight * 0.03), // Space between ellipses and text
                  const Text(
                    'Storage Permission',
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
                      'We need permission to store images files or upload documents/images. We respect your privacy and we will make sure to not upload ant of your personal data.',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecordAudioScreen()),
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