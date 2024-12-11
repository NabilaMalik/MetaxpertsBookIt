import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView( // Add scrollable functionality
          child: Container(
            color: Colors.blue, // Blue background color for the body
            child: Column(
              children: [
                // Navbar with Bottom Box Shadow
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[900]!.withOpacity(0.8), // Dark blue shadow
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.menu, color: Colors.white, size: 30),
                          SizedBox(width: 118),
                          Text(
                            "BookIT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 29,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.search, color: Colors.white, size: 28),
                          SizedBox(width: 20),
                          Icon(Icons.notifications, color: Colors.white, size: 28),
                        ],
                      ),
                    ],
                  ),
                ),

                // Profile Section
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20, top: 30, bottom: 40),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        // Profile Details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [

                            Text(
                              "BOOKIT",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "User Name",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "LOGIN",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Designation",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(width: 155), // Add some space between image and text content

                        // Profile Image
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/download (1).png'), // Replace with your image path
                        ),
                      ],
                    ),
                  ),
                ),

                // Action Buttons Section
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 15,top: 30,right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // First Row of Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildActionBox(
                            color: Colors.white,
                            icon: Icons.add_shopping_cart,
                            label: 'Add Shop',
                            width: screenWidth * 0.25,
                            // Responsive width
                          ),
                          _buildActionBox(
                            color: Colors.white,
                            icon: Icons.business,
                            label: 'Shop Visit',
                            width: screenWidth * 0.25, // Responsive width
                          ),
                          _buildActionBox(
                            color: Colors.white,
                            icon: Icons.assignment,
                            label: 'Return Form',
                            width: screenWidth * 0.25, // Responsive width
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      // Second Row of Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildActionBox(
                            color: Colors.white,
                            icon: Icons.remove_circle,
                            label: 'Recovery',
                            width: screenWidth * 0.25, // Responsive width
                          ),
                          _buildActionBox(
                            color: Colors.white,
                            icon: Icons.book,
                            label: 'Booking Status',
                            width: screenWidth * 0.25, // Responsive width
                          ),
                          Text("                                   ",
                            style: TextStyle(fontSize: 12),),
                        ],
                      ),
                      const SizedBox(height: 27),
                      // Overview Text
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Overview",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Summary Section
                      Container(
                        padding: const EdgeInsets.only(left: 20,right: 20, top: 25,bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(29),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.8),
                              spreadRadius: 3,
                              blurRadius: 9,
                              offset: const Offset(0, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Row 1
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSmallBox(70, Colors.white),
                                _buildSmallBox(80, Colors.white),
                                _buildSmallBox(90, Colors.white),
                                _buildSmallBox(100, Colors.white),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("  Total",
                                  style: TextStyle(fontSize: 12),),
                                Text("Total",
                                  style: TextStyle(fontSize: 12),),
                                Text("Total",
                                  style: TextStyle(fontSize: 12),),
                                Text("Total ",
                                  style: TextStyle(fontSize: 12),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Bookings",
                                  style: TextStyle(fontSize: 12),),
                                Text("Shops",
                                  style: TextStyle(fontSize: 12),),
                                Text("Returns",
                                  style: TextStyle(fontSize: 12),),
                                Text("Visits",
                                  style: TextStyle(fontSize: 12),),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSmallBox(70, Colors.white),
                                _buildSmallBox(80, Colors.white),
                                _buildSmallBox(90, Colors.white),
                                _buildSmallBox(100, Colors.white),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Monthly",
                                  style: TextStyle(fontSize: 12),),
                                Text("Daily",
                                  style: TextStyle(fontSize: 12),),
                                Text("Total",
                                  style: TextStyle(fontSize: 12),),
                                Text("Recovery",
                                  style: TextStyle(fontSize: 12),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Attendance",
                                  style: TextStyle(fontSize: 12),),
                                Text("Bookings",
                                  style: TextStyle(fontSize: 12),),
                                Text("Orders",
                                  style: TextStyle(fontSize: 12),),
                                Text("                   ",
                                  style: TextStyle(fontSize: 12),),

                              ],
                            ),
                            const SizedBox(height: 35),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSmallBox(70, Colors.white),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Total Order", style: TextStyle(fontSize: 12),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Dispatched", style: TextStyle(fontSize: 12),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable Small Box Widget
  Widget _buildSmallBox(int number, Color color) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$number',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  // Reusable Action Box Widget
  Widget _buildActionBox({
    required Color color,
    required IconData icon,
    required String label,
    required double width,
  }) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 9,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
