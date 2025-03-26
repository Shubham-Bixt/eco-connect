import 'package:flutter/material.dart';
import 'profile_screen.dart'; // Import ProfileScreen
import 'events.dart'; // Import EventsScreen
import 'chatBot.dart'; // Add this import for the ChatBot screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 3) { // Navigate to Profile
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatBotInterface()),
      );

    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _onServiceItemTapped(String label) {
    if (label == 'Events') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EcoConnectHomePage()),
      );
    } else if (label == 'Mark Location') {
      // Add functionality for marking location
      print('Mark Location clicked');
    } else if (label == 'FAQ') {
      // Add functionality for FAQ
      print('FAQ clicked');
    } else if (label == 'Payment') {
      // Add functionality for Payment
      print('Payment clicked');
    } else if (label == 'Profile') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } else if (label == 'On Demand Pickup') {
      // Add functionality for On Demand Pickup
      print('On Demand Pickup clicked');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/map.jpg',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.menu,
                                color: Color(0xFF4D8D6E),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Eco Connect',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.3),
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.search,
                                color: Color(0xFF4D8D6E),
                              ),
                            ),
                            SizedBox(width: 12),
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.notifications_none,
                                color: Color(0xFF4D8D6E),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10), // Reduced from 20 to 10

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Reduced vertical padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: TextStyle(
                      color: Color(0xFF4D8D6E),
                      fontSize: 30, // Increased from 22 to 26
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'What can we do for you?',
                    style: TextStyle(
                      color: Color(0xFF4D8D6E),
                      fontSize: 21, // Increased from 16 to 18
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 5), // Reduced from 10 to 5

            Expanded(
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          _buildServiceItem(Icons.location_pin, 'Map'),
                          _buildServiceItem(Icons.event, 'Events'),
                          _buildServiceItem(Icons.local_shipping, 'On Demand Pickup'),
                          _buildServiceItem(Icons.help_outline, 'FAQ'),
                          _buildServiceItem(Icons.credit_card, 'Payment'),
                          _buildServiceItem(Icons.person, 'Profile'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Modified FloatingActionButton to navigate to ChatBot
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatBotInterface()),

          );
        },
        child: Icon(
          Icons.message_outlined,
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFF4D8D6E),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(IconData icon, String label) {
    return GestureDetector(
      onTap: () => _onServiceItemTapped(label),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
            child: Icon(
              icon,
              color: Colors.black,
              size: 24,
            ),
          ),
          if (label.isNotEmpty) ...[
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ]
        ],
      ),
    );
  }
}