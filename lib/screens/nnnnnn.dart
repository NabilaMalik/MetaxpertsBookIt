import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                        SizedBox(width: 10),
                        Text(
                          "BookIT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      // Profile Details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "John Doe",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "john.doe@example.com",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "+123 456 789",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),

                      const SizedBox(width: 20), // Add some space between image and text content

                      // Profile Image
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your image path
                      ),
                    ],
                  ),
                ),
              ),

              // Action Buttons Section
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the column content
                    children: [
                      // First Row of Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center the row items horizontally
                        children: [
                          _buildActionBox(
                            color: Colors.white,
                            icon: Icons.add_shopping_cart,
                            label: 'Add Shop',
                          ),
                          _buildActionBox(
                            color: Colors.white,
                            icon: Icons.business,
                            label: 'Shop Visit',
                          ),
                          _buildActionBox(
                            color: Colors.white,
                            icon: Icons.assignment,
                            label: 'Return Form',
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      // Second Row of Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center the row items horizontally
                        children: [
                          _buildActionBox(
                            color: Colors.white,
                            icon: Icons.remove_circle,
                            label: 'Recovery',
                          ),
                          _buildActionBox(
                            color: Colors.white,
                            icon: Icons.book,
                            label: 'Booking Status',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 0),
              // Overview Text
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Overview",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 0),
              // Summary Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
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
                        Text("Total Bookings", style: TextStyle(fontSize: 12)),
                        Text("Total Shops", style: TextStyle(fontSize: 12)),
                        Text("Total Returns", style: TextStyle(fontSize: 12)),
                        Text("Total Visits", style: TextStyle(fontSize: 12)),
                      ],
                    ),
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
                        Text("Monthly Attendance", style: TextStyle(fontSize: 12)),
                        Text("Daily Bookings", style: TextStyle(fontSize: 12)),
                        Text("Recovery", style: TextStyle(fontSize: 12)),
                      ],
                    ),
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
                        Text("Total Order Dispatched", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Small Box Widget
  Widget _buildSmallBox(int number, Color color) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(29),
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
  }) {
    return Container(
      width: 100,
      height: 90,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
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
