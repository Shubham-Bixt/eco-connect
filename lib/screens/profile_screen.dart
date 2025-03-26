import 'package:flutter/material.dart';
import 'signup_screen.dart'; // Ensure correct import

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with logo
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFE8F0EC),
                    child: Image.asset(
                      'assets/logo.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: Color(0xFF4D8D6E),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'green. connect. grow',
                        style: TextStyle(
                          color: Color(0xFF4D8D6E),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 20),

            // Profile card with initials
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFF4D8D6E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'EC',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Eco Connect',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'ecoconnect@gmail.com',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Points section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFE8F0EC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Points:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '1,000',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Help & Support button
            _buildOptionButton(Icons.help_outline, 'Help & Support'),

            SizedBox(height: 16),

            // Security & Privacy button
            _buildOptionButton(Icons.shield_outlined, 'Security & Privacy'),

            Spacer(),

            // Log out button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  // Navigate to Signup Screen & Clear Navigation Stack
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                        (route) => false, // Clears navigation history
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F0EC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Log out',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom navigation bar
            Container(
              height: 60,
              color: Color(0xFF4D8D6E),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.home, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.eco, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.white54),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function for option buttons
  Widget _buildOptionButton(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Color(0xFFE8F0EC),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Color(0xFF4D8D6E).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Color(0xFF4D8D6E),
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
