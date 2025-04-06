// import 'package:flutter/material.dart';
// import 'event_model.dart';
// import 'database_helper.dart';
// import 'dart:io';
//
// class PastEventsPage extends StatefulWidget {
//   const PastEventsPage({Key? key}) : super(key: key);
//
//   @override
//   State<PastEventsPage> createState() => _PastEventsPageState();
// }
//
// class _PastEventsPageState extends State<PastEventsPage> {
//   List<Event> _pastEvents = [];
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadPastEvents();
//   }
//
//   Future<void> _loadPastEvents() async {
//     setState(() => _isLoading = true);
//
//     try {
//       _pastEvents = await DatabaseHelper.instance.getEventsByStatus(
//           [EventStatus.completed, EventStatus.closed]
//       );
//
//       if (_pastEvents.isEmpty) {
//         _pastEvents = _getDefaultPastEvents();
//       }
//     } catch (e) {
//       _pastEvents = _getDefaultPastEvents();
//     }
//
//     if (mounted) {
//       setState(() => _isLoading = false);
//     }
//   }
//
//   List<Event> _getDefaultPastEvents() {
//     return [
//       Event(
//         id: '3',
//         title: 'Beach Cleanup Drive',
//         date: '15th August 2023',
//         imageUrl: 'assets/beach_cleanup.jpg',
//         location: 'Dadar Beach, Mumbai',
//         organizer: 'Green Mumbai Initiative',
//         creditPoints: '75',
//         status: EventStatus.completed,
//       ),
//       Event(
//         id: '4',
//         title: 'Tree Plantation Drive',
//         date: '5th June 2023',
//         imageUrl: 'assets/tree_plantation.jpg',
//         location: 'Sanjay Gandhi National Park',
//         organizer: 'Eco-Connect Team',
//         creditPoints: '60',
//         status: EventStatus.completed,
//       ),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'History',
//           style: TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFFD0E8D0),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _buildPastEventsList(),
//       backgroundColor: const Color(0xFFD0E8D0),
//     );
//   }
//
//   Widget _buildPastEventsList() {
//     if (_pastEvents.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.history, size: 64, color: Colors.grey),
//             const SizedBox(height: 16),
//             const Text(
//               'No past events found',
//               style: TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Your completed events will appear here',
//               style: TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Text(
//             'Your Past Events',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF4D8B55),
//             ),
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             itemCount: _pastEvents.length,
//             itemBuilder: (context, index) {
//               final event = _pastEvents[index];
//               return PastEventCard(event: event);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class PastEventCard extends StatelessWidget {
//   final Event event;
//
//   const PastEventCard({
//     Key? key,
//     required this.event,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: _buildEventImage(),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         event.title,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         event.date,
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           const Icon(Icons.location_on, size: 14, color: Colors.grey),
//                           const SizedBox(width: 4),
//                           Expanded(
//                             child: Text(
//                               event.location,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey.shade600,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             const Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Icon(Icons.person, size: 14, color: Colors.grey.shade600),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         child: Text(
//                           event.organizer,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey.shade600,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF4D8B55).withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.check_circle, size: 14, color: Color(0xFF4D8B55)),
//                       const SizedBox(width: 4),
//                       Text(
//                         '${event.creditPoints} points earned',
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Color(0xFF4D8B55),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEventImage() {
//     if (event.imageUrl.startsWith('file://')) {
//       return Image.file(
//         File(event.imageUrl.replaceFirst('file://', '')),
//         height: 80,
//         width: 80,
//         fit: BoxFit.cover,
//         errorBuilder: (context, error, stackTrace) {
//           return _buildPlaceholderImage();
//         },
//       );
//     } else {
//       return Image.asset(
//         event.imageUrl,
//         height: 80,
//         width: 80,
//         fit: BoxFit.cover,
//         errorBuilder: (context, error, stackTrace) {
//           return _buildPlaceholderImage();
//         },
//       );
//     }
//   }
//
//   Widget _buildPlaceholderImage() {
//     return Container(
//       height: 80,
//       width: 80,
//       color: Colors.grey.shade200,
//       child: const Icon(Icons.event, color: Colors.grey),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     title: 'Past Events Demo',
//     home: const PastEventsPage(),
//     debugShowCheckedModeBanner: false,
//     theme: ThemeData(
//       primarySwatch: Colors.green,
//       scaffoldBackgroundColor: const Color(0xFFD0E8D0),
//       appBarTheme: const AppBarTheme(
//         backgroundColor: Color(0xFFD0E8D0),
//         elevation: 0,
//         centerTitle: true,
//         iconTheme: IconThemeData(color: Colors.black87),
//         titleTextStyle: TextStyle(
//           color: Colors.black87,
//           fontWeight: FontWeight.bold,
//           fontSize: 22,
//         ),
//       ),
//     ),
//   ));
// }

















import 'package:flutter/material.dart';
import 'event_model.dart';
import 'database_helper.dart';
import 'dart:io';
import 'profile_screen.dart';
import 'home_screen.dart';
import 'recycling_center.dart';

class PastEventsPage extends StatefulWidget {
  const PastEventsPage({Key? key}) : super(key: key);

  @override
  State<PastEventsPage> createState() => _PastEventsPageState();
}

class _PastEventsPageState extends State<PastEventsPage> {
  List<Event> _pastEvents = [];
  bool _isLoading = true;
  int _selectedIndex = 2; // Set initial index to 2 for History tab

  @override
  void initState() {
    super.initState();
    _loadPastEvents();
  }

  Future<void> _loadPastEvents() async {
    setState(() => _isLoading = true);

    try {
      _pastEvents = await DatabaseHelper.instance.getEventsByStatus(
          [EventStatus.completed, EventStatus.closed]
      );

      if (_pastEvents.isEmpty) {
        _pastEvents = _getDefaultPastEvents();
      }
    } catch (e) {
      _pastEvents = _getDefaultPastEvents();
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  List<Event> _getDefaultPastEvents() {
    return [
      Event(
        id: '3',
        title: 'Beach Cleanup Drive',
        date: '15th August 2023',
        imageUrl: 'assets/beach_cleanup.jpg',
        location: 'Dadar Beach, Mumbai',
        organizer: 'Green Mumbai Initiative',
        creditPoints: '75',
        status: EventStatus.completed,
      ),
      Event(
        id: '4',
        title: 'Tree Plantation Drive',
        date: '5th June 2023',
        imageUrl: 'assets/tree_plantation.jpg',
        location: 'Sanjay Gandhi National Park',
        organizer: 'Eco-Connect Team',
        creditPoints: '60',
        status: EventStatus.completed,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFD0E8D0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildPastEventsList(),
      backgroundColor: const Color(0xFFD0E8D0),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          // Navigate to the appropriate screen based on the tapped item
          if (index == 0) {
            // Home icon
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false, // This removes all previous routes
            );
          } else if (index == 1 ) {
            // Map or Profile icon
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
          }
          else if (index == 3 ) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
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

  Widget _buildPastEventsList() {
    if (_pastEvents.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.history, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'No past events found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your completed events will appear here',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Your Past Events',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4D8B55),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _pastEvents.length,
            itemBuilder: (context, index) {
              final event = _pastEvents[index];
              return PastEventCard(event: event);
            },
          ),
        ),
      ],
    );
  }
}

class PastEventCard extends StatelessWidget {
  final Event event;

  const PastEventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildEventImage(),
                ),
                const SizedBox(width: 12),
                Expanded(
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
                      Text(
                        event.date,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.location,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 14, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.organizer,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D8B55).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, size: 14, color: Color(0xFF4D8B55)),
                      const SizedBox(width: 4),
                      Text(
                        '${event.creditPoints} points earned',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF4D8B55),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventImage() {
    if (event.imageUrl.startsWith('file://')) {
      return Image.file(
        File(event.imageUrl.replaceFirst('file://', '')),
        height: 80,
        width: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholderImage();
        },
      );
    } else {
      return Image.asset(
        event.imageUrl,
        height: 80,
        width: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholderImage();
        },
      );
    }
  }

  Widget _buildPlaceholderImage() {
    return Container(
      height: 80,
      width: 80,
      color: Colors.grey.shade200,
      child: const Icon(Icons.event, color: Colors.grey),
    );
  }
}
