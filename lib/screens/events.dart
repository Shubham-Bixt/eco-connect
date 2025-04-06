//
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; // For date and time formatting
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Eco Connect',
//       theme: ThemeData(
//         primaryColor: const Color(0xFF4D8B55),
//         scaffoldBackgroundColor: const Color(0xFFD0E8D0),
//       ),
//       home: const EcoConnectHomePage(),
//     );
//   }
// }
//
// class EcoConnectHomePage extends StatefulWidget {
//   const EcoConnectHomePage({super.key});
//
//   @override
//   State<EcoConnectHomePage> createState() => _EcoConnectHomePageState();
// }
//
// class _EcoConnectHomePageState extends State<EcoConnectHomePage> {
//   int _selectedIndex = 0;
//
//   void _openChatbot() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Eco-Connect Assistant'),
//           content: const Text('How can I help you today with sustainable living?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _navigateToCreateEvent() {
//     // Navigate to the "Create New Event" page
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const CreateEventPage(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Eco-Connect',
//           style: TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFFD0E8D0),
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               const SizedBox(height: 10),
//               // Tabs
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _selectedIndex = 0;
//                           });
//                         },
//                         child: Container(
//                           height: 40,
//                           decoration: BoxDecoration(
//                             color: _selectedIndex == 0
//                                 ? const Color(0xFF4D8B55)
//                                 : Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                             border: _selectedIndex == 0
//                                 ? null
//                                 : Border.all(color: const Color(0xFF4D8B55)),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'Events',
//                               style: TextStyle(
//                                 color: _selectedIndex == 0
//                                     ? Colors.white
//                                     : Colors.black87,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 15),
//               // Location or Page Info
//               Text(
//                 'Location: Mumbai, India',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.black87,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//               const SizedBox(height: 15),
//               // Content based on selected tab
//               Expanded(
//                 child: _buildEventsTab(),
//               ),
//             ],
//           ),
//           // "+" button for creating a new event
//           Positioned(
//             left: 16,
//             bottom: 16,
//             child: FloatingActionButton(
//               onPressed: _navigateToCreateEvent,
//               backgroundColor: const Color(0xFF4D8B55),
//               child: const Icon(
//                 Icons.add,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           // Chat bot button
//           Positioned(
//             right: 16,
//             bottom: 16,
//             child: FloatingActionButton(
//               onPressed: _openChatbot,
//               backgroundColor: const Color(0xFF4D8B55),
//               child: const Icon(
//                 Icons.chat_bubble_outline,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: const Color(0xFF4D8B55),
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white70,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.menu),
//             label: 'Menu',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.eco),
//             label: 'Eco',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         currentIndex: 0,
//         onTap: (index) {
//           // Handle bottom navigation tap
//         },
//       ),
//     );
//   }
//
//   Widget _buildEventsTab() {
//     return ListView(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       children: [
//         EventCard(
//           imageUrl: 'assets/skrap_event.jpg',
//           title: 'Skrap Event @Juhu, Mumbai',
//           date: '1st September 2023',
//           onTap: () {
//             // Navigate to Join Event Page
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const JoinEventPage(
//                   eventName: 'Skrap Event @Juhu, Mumbai',
//                   dateTime: '1st September 2023, 10:00 AM',
//                   creditPoints: '50',
//                   organizerName: 'Eco-Connect Team',
//                   location: 'Juhu Beach, Mumbai',
//                   status: 'Active',
//                 ),
//               ),
//             );
//           },
//         ),
//         const SizedBox(height: 15),
//         EventCard(
//           imageUrl: 'assets/clean_india_show.png',
//           title: 'Clean India Show (CIS)',
//           date: '13th-15th September 2023',
//           onTap: () {
//             // Navigate to Previous Event Page
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const PreviousEventPage(
//                   eventName: 'Clean India Show (CIS)',
//                   date: '13th-15th September 2023',
//                   creditPoints: '100',
//                   status: 'Closed',
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
//
// class EventCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String date;
//   final VoidCallback onTap;
//
//   const EventCard({
//     super.key,
//     required this.imageUrl,
//     required this.title,
//     required this.date,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
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
//             // Image
//             ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//               child: Container(
//                 height: 150,
//                 width: double.infinity,
//                 color: Colors.grey.shade300,
//                 child: Image.asset(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       color: Colors.grey.shade200,
//                       child: Center(
//                         child: Icon(
//                           Icons.image,
//                           size: 50,
//                           color: Colors.grey.shade400,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             // Event info
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
//                       color: Colors.black87,
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
// class CreateEventPage extends StatefulWidget {
//   const CreateEventPage({super.key});
//
//   @override
//   State<CreateEventPage> createState() => _CreateEventPageState();
// }
//
// class _CreateEventPageState extends State<CreateEventPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _eventNameController = TextEditingController();
//   final TextEditingController _dateTimeController = TextEditingController();
//   final TextEditingController _creditPointsController = TextEditingController();
//   final TextEditingController _organizerNameController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//
//   Future<void> _selectDateTime(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//     if (pickedDate != null) {
//       final TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );
//       if (pickedTime != null) {
//         setState(() {
//           _dateTimeController.text =
//           '${DateFormat('dd/MM/yyyy').format(pickedDate)} ${pickedTime.format(context)}';
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create New Event'),
//         backgroundColor: const Color(0xFF4D8B55),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _eventNameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Name of Event',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the event name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _dateTimeController,
//                 decoration: const InputDecoration(
//                   labelText: 'Date & Time',
//                   border: OutlineInputBorder(),
//                   suffixIcon: Icon(Icons.calendar_today),
//                 ),
//                 onTap: () => _selectDateTime(context),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select date and time';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _creditPointsController,
//                 decoration: const InputDecoration(
//                   labelText: 'Credit Points',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter credit points';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _organizerNameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Organizer Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter organizer name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _locationController,
//                 decoration: const InputDecoration(
//                   labelText: 'Location (Google Maps)',
//                   border: OutlineInputBorder(),
//                   suffixIcon: Icon(Icons.location_on),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter location';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Save event details and navigate back
//                     Navigator.pop(context);
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF4D8B55),
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                 ),
//                 child: const Text(
//                   'Create Event',
//                   style: TextStyle(fontSize: 16, color: Colors.white), // Text color changed to white
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class JoinEventPage extends StatelessWidget {
//   final String eventName;
//   final String dateTime;
//   final String creditPoints;
//   final String organizerName;
//   final String location;
//   final String status;
//
//   const JoinEventPage({
//     super.key,
//     required this.eventName,
//     required this.dateTime,
//     required this.creditPoints,
//     required this.organizerName,
//     required this.location,
//     required this.status,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Join Event'),
//         backgroundColor: const Color(0xFF4D8B55),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               eventName,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Date & Time: $dateTime',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Credit Points: $creditPoints',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Organizer: $organizerName',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Location: $location',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Status: $status',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: status == 'Active' ? Colors.green : Colors.red,
//               ),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle joining the event
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF4D8B55),
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//               ),
//               child: const Text(
//                 'Join Event',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class PreviousEventPage extends StatelessWidget {
//   final String eventName;
//   final String date;
//   final String creditPoints;
//   final String status;
//
//   const PreviousEventPage({
//     super.key,
//     required this.eventName,
//     required this.date,
//     required this.creditPoints,
//     required this.status,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Previous Event'),
//         backgroundColor: const Color(0xFF4D8B55),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               eventName,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Date: $date',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Credit Points: $creditPoints',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Status: $status',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: status == 'Closed' ? Colors.orange : Colors.green,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }













import 'package:eco/screens/past_event.dart';
import 'package:eco/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'map.dart';
import 'event_model.dart';
import 'database_helper.dart';

// void main() {
//   runApp(const MyApp());
// }

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
  List<Event> _events = [];
  List<Event> _filteredEvents = [];
  String _sortOption = 'Date (Newest)';
  String _filterOption = 'All';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final events = await DatabaseHelper.instance.getAllEvents();
      if (events.isEmpty) {
        // If no events in database, use default events
        _events = [

        ];

        // Save default events to database
        for (var event in _events) {
          await DatabaseHelper.instance.createEvent(event);
        }
      } else {
        _events = events;
      }

      _applyFilterAndSort();
    } catch (e) {
      // Fallback to default events if database access fails
      _events = [

      ];
      _applyFilterAndSort();
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _applyFilterAndSort() {
    // First apply filters
    if (_filterOption == 'All') {
      _filteredEvents = List.from(_events);
    } else {
      _filteredEvents = _events.where((event) =>
      event.organizer == _filterOption ||
          event.status == _filterOption
      ).toList();
    }

    // Then sort the filtered list
    switch (_sortOption) {
      case 'Date (Newest)':
        _filteredEvents.sort((a, b) => _compareEventDates(b, a)); // Descending
        break;
      case 'Date (Oldest)':
        _filteredEvents.sort((a, b) => _compareEventDates(a, b)); // Ascending
        break;
      case 'Credits (High to Low)':
        _filteredEvents.sort((a, b) =>
            int.parse(b.creditPoints).compareTo(int.parse(a.creditPoints))
        );
        break;
      case 'Credits (Low to High)':
        _filteredEvents.sort((a, b) =>
            int.parse(a.creditPoints).compareTo(int.parse(b.creditPoints))
        );
        break;
      case 'Name (A-Z)':
        _filteredEvents.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Name (Z-A)':
        _filteredEvents.sort((a, b) => b.title.compareTo(a.title));
        break;
    }
  }

  int _compareEventDates(Event a, Event b) {
    // This is a simple implementation - you might need a more sophisticated
    // approach depending on your date format
    return a.date.compareTo(b.date);
  }

  void _showSortFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              // Get unique organizers for filter options
              final organizers = <String>{'All'};
              for (var event in _events) {
                organizers.add(event.organizer);
              }

              return AlertDialog(
                title: const Text('Sort & Filter Events'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Sort by:', style: TextStyle(fontWeight: FontWeight.bold)),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _sortOption,
                        items: [
                          'Date (Newest)',
                          'Date (Oldest)',
                          'Credits (High to Low)',
                          'Credits (Low to High)',
                          'Name (A-Z)',
                          'Name (Z-A)',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _sortOption = newValue;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text('Filter by Organizer:', style: TextStyle(fontWeight: FontWeight.bold)),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _filterOption,
                        items: organizers.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _filterOption = newValue;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      this.setState(() {
                        // Apply the new sort and filter options
                        _applyFilterAndSort();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4D8B55),
                    ),
                    child: const Text('Apply', style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            }
        );
      },
    );
  }

  Future<void> _addNewEvent(Event newEvent) async {
    try {
      await DatabaseHelper.instance.createEvent(newEvent);
      setState(() {
        _events.insert(0, newEvent);
        _applyFilterAndSort();
      });
    } catch (e) {
      // If database fails, at least update UI
      setState(() {
        _events.insert(0, newEvent);
        _applyFilterAndSort();
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add navigation logic here based on the index
    // For example:
    // if (index == 1) {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
    // }
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
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black87),
            onPressed: _showSortFilterDialog,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedIndex = 0),
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
              const Text(
                'Location: Mumbai, India',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _buildEventsTab(),
              ),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateEventPage(),
                  ),
                );
                if (result != null && result is Event) {
                  await _addNewEvent(result);
                }
              },
              backgroundColor: const Color(0xFF4D8B55),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          // Navigate to the appropriate screen based on the tapped item
          if (index == 0) {
            // Home icon
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1 || index == 3) {
            // Map or Profile icon
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ProfileScreen()),
            );
          } else if (index == 2) {
            // History icon
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PastEventsPage()),
            );
          }
        },
        selectedItemColor: const Color(0xFF4D8D6E),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Text('🏠', style: TextStyle(fontSize: 24)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Text('🗺️', style: TextStyle(fontSize: 24)),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Text('⏱️', style: TextStyle(fontSize: 24)),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Text('👤', style: TextStyle(fontSize: 24)),
            label: 'Profile',
          ),
        ],
      ),


    );
  }

  Widget _buildEventsTab() {
    if (_filteredEvents.isEmpty) {
      return const Center(
        child: Text(
          'No events found',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _filteredEvents.length,
      itemBuilder: (context, index) {
        final event = _filteredEvents[index];
        return EventCard(
          event: event,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => event.status == 'Active'
                    ? JoinEventPage(event: event)
                    : PreviousEventPage(event: event),
              ),
            );
          },
        );
      },
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
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
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: _buildEventImage(event.imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Date on left
                      Text(
                        event.date,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      // Status on right
                      Row(
                        children: [
                          Icon(
                              Icons.circle,
                              size: 10,
                              color: event.status == 'Active' ? Colors.green : Colors.orange
                          ),
                          const SizedBox(width: 4),
                          Text(
                            event.status,
                            style: TextStyle(
                              fontSize: 12,
                              color: event.status == 'Active' ? Colors.green : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Organizer on left
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.person, size: 14, color: Colors.grey.shade700),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                event.organizer,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Points on right
                      Row(
                        children: [
                          const Icon(Icons.stars, size: 14, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            '${event.creditPoints} points',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventImage(String imageUrl) {
    if (imageUrl.startsWith('file://')) {
      // Handle file:// URI scheme for images captured from camera
      return Image.file(
        File(imageUrl.replaceFirst('file://', '')),
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholderImage();
        },
      );
    } else {
      // Handle asset images
      return Image.asset(
        imageUrl,
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholderImage();
        },
      );
    }
  }

  Widget _buildPlaceholderImage() {
    return Container(
      height: 150,
      color: Colors.grey.shade200,
      child: const Center(child: Icon(Icons.event)),
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
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();

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

  Future<void> _selectLocation(BuildContext context) async {
    final LatLng? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LocationMarkingPage(isForEvent: true),
      ),
    );
    if (selectedLocation != null && mounted) {
      setState(() {
        _locationController.text =
        '${selectedLocation.latitude.toStringAsFixed(6)}, '
            '${selectedLocation.longitude.toStringAsFixed(6)}';
      });
    }
  }

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _imagePath = 'file://${photo.path}';
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = 'file://${image.path}';
      });
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveEvent() {
    if (_formKey.currentState!.validate()) {
      final newEvent = Event(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _eventNameController.text,
        date: _dateTimeController.text,
        imageUrl: _imagePath ?? 'assets/default_event.jpg',
        location: _locationController.text,
        organizer: _organizerNameController.text,
        creditPoints: _creditPointsController.text,
        status: 'Active', // Default status for new events
      );
      Navigator.pop(context, newEvent);
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
              GestureDetector(
                onTap: _showImageSourceDialog,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: _imagePath != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(_imagePath!.replaceFirst('file://', '')),
                      fit: BoxFit.cover,
                    ),
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text('Tap to add event image'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.map),
                    onPressed: () => _selectLocation(context),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a location';
                  }
                  return null;
                },
                readOnly: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveEvent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4D8B55),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Create Event',
                  style: TextStyle(fontSize: 16, color: Colors.white),
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
  final Event event;

  const JoinEventPage({super.key, required this.event});

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
              event.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Date & Time: ${event.date}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Credit Points: ${event.creditPoints}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Organizer: ${event.organizer}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${event.location}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${event.status}',
              style: TextStyle(
                fontSize: 16,
                color: event.status == 'Active' ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4D8B55),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                  'Join Event',
                  style: TextStyle(fontSize: 16, color: Colors.white)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PreviousEventPage extends StatelessWidget {
  final Event event;

  const PreviousEventPage({super.key, required this.event});

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
              event.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Date: ${event.date}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Credit Points: ${event.creditPoints}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${event.status}',
              style: TextStyle(
                fontSize: 16,
                color: event.status == 'Closed' ? Colors.orange : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}























// bottomNavigationBar: BottomNavigationBar(
//   currentIndex: _selectedIndex,
//   onTap: _onItemTapped,
//   selectedItemColor: const Color(0xFF4D8D6E),
//   unselectedItemColor: Colors.grey,
//   type: BottomNavigationBarType.fixed,
//
//
//   items: const [
//     BottomNavigationBarItem(
//       icon: Icon(Icons.home),
//       label: 'Home',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.location_on),
//       label: 'Map',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.history),
//       label: 'History',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.person),
//       label: 'Profile',
//     ),
//   ],
// ),




