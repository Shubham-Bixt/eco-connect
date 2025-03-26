// import 'package:flutter/material.dart';
//
// class EventsPage extends StatelessWidget {
//   const EventsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Events'),
//         backgroundColor: const Color(0xFF4D8B55),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         children: [
//           EventCard(
//             imageUrl: 'assets/skrap_event.jpg',
//             title: 'Skrap Event @Juhu, Mumbai',
//             date: '1st September 2023',
//           ),
//           const SizedBox(height: 15),
//           EventCard(
//             imageUrl: 'assets/clean_india_show.jpg',
//             title: 'Clean India Show (CIS)',
//             date: '13th-15th September 2023',
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class EventCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String date;
//
//   const EventCard({
//     super.key,
//     required this.imageUrl,
//     required this.title,
//     required this.date,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => EventDetailPage(title: title, imageUrl: imageUrl, date: date),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//               child: Image.asset(
//                 imageUrl,
//                 height: 150,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     date,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey.shade700,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class EventDetailPage extends StatelessWidget {
//   final String title;
//   final String imageUrl;
//   final String date;
//
//   const EventDetailPage({
//     super.key,
//     required this.title,
//     required this.imageUrl,
//     required this.date,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         backgroundColor: const Color(0xFF4D8B55),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Image.asset(imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
//             const SizedBox(height: 20),
//             Text(
//               title,
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               date,
//               style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Detailed event information will be displayed here.',
//               style: TextStyle(fontSize: 16),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }















import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date and time formatting

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eco Connect',
      theme: ThemeData(
        primaryColor: const Color(0xFF4D8B55),
        scaffoldBackgroundColor: const Color(0xFFD0E8D0),
      ),
      home: const EcoConnectHomePage(),
    );
  }
}

class EcoConnectHomePage extends StatefulWidget {
  const EcoConnectHomePage({super.key});

  @override
  State<EcoConnectHomePage> createState() => _EcoConnectHomePageState();
}

class _EcoConnectHomePageState extends State<EcoConnectHomePage> {
  int _selectedIndex = 0;

  void _openChatbot() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eco-Connect Assistant'),
          content: const Text('How can I help you today with sustainable living?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToCreateEvent() {
    // Navigate to the "Create New Event" page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateEventPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Eco-Connect',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFD0E8D0),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: _selectedIndex == 0
                                ? const Color(0xFF4D8B55)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: _selectedIndex == 0
                                ? null
                                : Border.all(color: const Color(0xFF4D8B55)),
                          ),
                          child: Center(
                            child: Text(
                              'Events',
                              style: TextStyle(
                                color: _selectedIndex == 0
                                    ? Colors.white
                                    : Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // Location or Page Info
              Text(
                'Location: Mumbai, India',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 15),
              // Content based on selected tab
              Expanded(
                child: _buildEventsTab(),
              ),
            ],
          ),
          // "+" button for creating a new event
          Positioned(
            left: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: _navigateToCreateEvent,
              backgroundColor: const Color(0xFF4D8B55),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          // Chat bot button
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: _openChatbot,
              backgroundColor: const Color(0xFF4D8B55),
              child: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF4D8B55),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Eco',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle bottom navigation tap
        },
      ),
    );
  }

  Widget _buildEventsTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        EventCard(
          imageUrl: 'assets/skrap_event.jpg',
          title: 'Skrap Event @Juhu, Mumbai',
          date: '1st September 2023',
          onTap: () {
            // Navigate to Join Event Page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const JoinEventPage(
                  eventName: 'Skrap Event @Juhu, Mumbai',
                  dateTime: '1st September 2023, 10:00 AM',
                  creditPoints: '50',
                  organizerName: 'Eco-Connect Team',
                  location: 'Juhu Beach, Mumbai',
                  status: 'Active',
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 15),
        EventCard(
          imageUrl: 'assets/clean_india_show.png',
          title: 'Clean India Show (CIS)',
          date: '13th-15th September 2023',
          onTap: () {
            // Navigate to Previous Event Page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviousEventPage(
                  eventName: 'Clean India Show (CIS)',
                  date: '13th-15th September 2023',
                  creditPoints: '100',
                  status: 'Closed',
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class EventCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey.shade300,
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: Center(
                        child: Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Event info
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _creditPointsController = TextEditingController();
  final TextEditingController _organizerNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _dateTimeController.text =
          '${DateFormat('dd/MM/yyyy').format(pickedDate)} ${pickedTime.format(context)}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Event'),
        backgroundColor: const Color(0xFF4D8B55),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _eventNameController,
                decoration: const InputDecoration(
                  labelText: 'Name of Event',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the event name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateTimeController,
                decoration: const InputDecoration(
                  labelText: 'Date & Time',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => _selectDateTime(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select date and time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _creditPointsController,
                decoration: const InputDecoration(
                  labelText: 'Credit Points',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter credit points';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _organizerNameController,
                decoration: const InputDecoration(
                  labelText: 'Organizer Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter organizer name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location (Google Maps)',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.location_on),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save event details and navigate back
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4D8B55),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Create Event',
                  style: TextStyle(fontSize: 16, color: Colors.white), // Text color changed to white
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class JoinEventPage extends StatelessWidget {
  final String eventName;
  final String dateTime;
  final String creditPoints;
  final String organizerName;
  final String location;
  final String status;

  const JoinEventPage({
    super.key,
    required this.eventName,
    required this.dateTime,
    required this.creditPoints,
    required this.organizerName,
    required this.location,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Event'),
        backgroundColor: const Color(0xFF4D8B55),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Date & Time: $dateTime',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Credit Points: $creditPoints',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Organizer: $organizerName',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Location: $location',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: $status',
              style: TextStyle(
                fontSize: 16,
                color: status == 'Active' ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Handle joining the event
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4D8B55),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Join Event',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PreviousEventPage extends StatelessWidget {
  final String eventName;
  final String date;
  final String creditPoints;
  final String status;

  const PreviousEventPage({
    super.key,
    required this.eventName,
    required this.date,
    required this.creditPoints,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previous Event'),
        backgroundColor: const Color(0xFF4D8B55),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Date: $date',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Credit Points: $creditPoints',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: $status',
              style: TextStyle(
                fontSize: 16,
                color: status == 'Closed' ? Colors.orange : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}