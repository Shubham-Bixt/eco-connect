import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'events.dart';
import 'chatBot.dart';
import 'waste_classification_screen.dart';
import 'past_event.dart';
import 'faq.dart';
import 'dictionary.dart';
import 'recycling_center.dart';
import 'under_process.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      // Home icon
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      // Map icon - Navigate to recycling_center.dart
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RecyclingHomePage()),
      );
    } else if (index == 2) {
      // History icon
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PastEventsPage()),
      );
    } else if (index == 3) {
      // Profile icon
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _openWasteClassification() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WasteClassificationScreen()),
    );
  }

  void _onServiceItemTapped(String label) {
    if (label == 'Events') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EcoConnectHomePage()),
      );
    }
    else if (label == 'Map') {
      // Map service - Navigate to recycling_center.dart
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RecyclingHomePage()),
      );
    }
    else if (label == 'FAQ') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FAQPage()),
      );
    }
    else if (label == 'Payment') {
      // Navigate to UnderProcess page instead of printing
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UnderDevelopmentPage()),
      );
    }
    else if (label == 'Profile') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
    else if (label == 'Dictionary') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WasteDictionary()),
      );
    } else if (label == 'On Demand Pickup') {
      // Navigate to UnderProcess page instead of printing
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UnderDevelopmentPage()),
      );
    } else if (label == 'Rewards') {
      // Navigate to UnderProcess page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UnderDevelopmentPage()),
      );
    } else if (label == 'Classify Waste') {
      _openWasteClassification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverPadding(
            padding: const EdgeInsets.all(15),          //classify waste padding
            sliver: SliverToBoxAdapter(
              child: _buildQuickActions(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),     //box padding
            sliver: SliverToBoxAdapter(
              child: _buildServiceGrid(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF4D8D6E),
        elevation: 4,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatbotScreen()),
          );
        },
        child: Text(
          '💬',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 220,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Color(0xFF4D8D6E),
      // Removed the actions (search and notification icons)
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/map.jpg',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Color(0xFF4D8D6E).withOpacity(0.8),
                  ],
                ),
              ),
            ),
            // Added Eco Connect text at the top
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Eco Connect',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            // Added the Hello text at the bottom left of the image
            Positioned(
              bottom: 16,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'What can we do for you?',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 31,
                      fontWeight: FontWeight.w500,
                      // fontFamily:
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }

  Widget _buildQuickActions() {
    // Define the quick actions with emojis instead of icons
    List<Map<String, dynamic>> actions = [
      {'emoji': '🚮', 'label': 'Classify Waste', 'onTap': _openWasteClassification},
      {'emoji': '📅', 'label': 'Create Event', 'onTap': () => _onServiceItemTapped('Events')},
      {'emoji': '❓', 'label': 'FAQ', 'onTap': () => _onServiceItemTapped('FAQ')},
      {'emoji': '🚚', 'label': 'Request Pickup', 'onTap': () => _onServiceItemTapped('On Demand Pickup')},
    ];

    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // This makes the list scroll infinitely
        itemCount: null, // Set to null for infinite scrolling
        itemBuilder: (context, index) {
          // Calculate the actual index by taking modulo of the length
          final actionIndex = index % actions.length;
          final action = actions[actionIndex];

          return _buildQuickActionItem(
            action['emoji'],
            action['label'],
            action['onTap'],
          );
        },
      ),
    );
  }

  Widget _buildQuickActionItem(String emoji, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4D8D6E),
              Color(0xFF5EA58A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF4D8D6E).withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                emoji,
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildServiceGrid() {
    List<Map<String, dynamic>> services = [
      {'emoji': '🗺', 'label': 'Map'},
      {'emoji': '💳', 'label': 'Payment'},
      {'emoji': '📚', 'label': 'Dictionary'},
      {'emoji': '💰', 'label': 'Rewards'},
    ];

    return Card(
      elevation: 0,
      // shadowColor: (Color(0xFF4D8D6E)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 12, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'Services',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return _buildServiceCard(
                  services[index]['emoji'],
                  services[index]['label'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String emoji, String label) {
    return InkWell(
      onTap: () => _onServiceItemTapped(label),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF4D8D6E).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Text(
                emoji,
                style: TextStyle(fontSize: 27),
              ),
            ),
            SizedBox(height: 15),
            Text(
              label,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    List<Map<String, dynamic>> navItems = [
      {'emoji': '🏠', 'label': 'Home', 'index': 0},
      {'emoji': '🗺', 'label': 'Map', 'index': 1},
      {'emoji': '🕒', 'label': 'History', 'index': 2},
      {'emoji': '👤', 'label': 'Profile', 'index': 3},
    ];

    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(24),
        //   topRight: Radius.circular(24),
        // ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _buildNavBarItem(navItems[0]['emoji'], navItems[0]['label'], navItems[0]['index'])),
              Expanded(child: _buildNavBarItem(navItems[1]['emoji'], navItems[1]['label'], navItems[1]['index'])),
              Expanded(child: SizedBox()), // Center space for the camera button
              Expanded(child: _buildNavBarItem(navItems[2]['emoji'], navItems[2]['label'], navItems[2]['index'])),
              Expanded(child: _buildNavBarItem(navItems[3]['emoji'], navItems[3]['label'], navItems[3]['index'])),
            ],
          ),
          Positioned(
            top: -15,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF5EA58A),
                    Color(0xFF4D8D6E),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF4D8D6E).withOpacity(0.4),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: _openWasteClassification,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(String emoji, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
          // color: Color(0xFF4D8D6E).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Color(0xFF4D8D6E) : Colors.grey,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

