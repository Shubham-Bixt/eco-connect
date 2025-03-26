import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Connect',
      theme: ThemeData(
        primaryColor: Color(0xFF4D8D6E),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF4D8D6E),
          secondary: Color(0xFF4D8D6E),
        ),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

//
//
//
//
//
//
//
//
//
//
//
//






























//
//
//
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
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
//       title: 'Flutter Current Location',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MapPage(),
//     );
//   }
// }
//
// class MapPage extends StatefulWidget {
//   const MapPage({super.key});
//
//   @override
//   State<MapPage> createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   late Location _locationController = Location();
//   LatLng? _currentPosition;
//   final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
//
//   @override
//   void initState() {
//     super.initState();
//     getLocationUpdates();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Current Location on Map'),
//       ),
//       body: _currentPosition == null
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//         onMapCreated: (GoogleMapController controller) {
//           _mapController.complete(controller);
//         },
//         initialCameraPosition: CameraPosition(
//           target: _currentPosition ?? const LatLng(0, 0), // Fallback to (0,0) if _currentPosition is null
//           zoom: 13, // Set zoom level to 13
//         ),
//         markers: {
//           if (_currentPosition != null)
//             Marker(
//               markerId: const MarkerId('currentLocation'),
//               icon: BitmapDescriptor.defaultMarker,
//               position: _currentPosition!,
//             ),
//         },
//       ),
//     );
//   }
//
//   Future<void> getLocationUpdates() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;
//
//     // Check if location services are enabled
//     serviceEnabled = await _locationController.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _locationController.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }
//
//     // Check and request location permissions
//     permissionGranted = await _locationController.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _locationController.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//
//     // Listen for location updates
//     _locationController.onLocationChanged.listen((LocationData currentLocation) {
//       if (currentLocation.latitude != null && currentLocation.longitude != null) {
//         setState(() {
//           _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
//         });
//         cameraToPosition(_currentPosition!); // Move camera to the current location
//       }
//     });
//   }
//
//   Future<void> cameraToPosition(LatLng pos) async {
//     final GoogleMapController controller = await _mapController.future;
//     final CameraPosition newCameraPosition = CameraPosition(
//       target: pos,
//       zoom: 13, // Set zoom level to 13
//     );
//     await controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
//   }
// }