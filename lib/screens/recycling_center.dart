import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const RecyclingFinderApp());

class RecyclingFinderApp extends StatelessWidget {
  const RecyclingFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recycling Finder',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const RecyclingHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RecyclingCenter {
  final String name;
  final String address;
  final double lat;
  final double lng;
  final String type;

  RecyclingCenter({
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.type,
  });

  factory RecyclingCenter.fromJson(Map<String, dynamic> json) {
    return RecyclingCenter(
      name: json['name'],
      address: "${json['city']}, ${json['state']}",
      lat: json['lat'].toDouble(),
      lng: json['lon'].toDouble(),
      type: "General",
    );
  }
}

class RecyclingHomePage extends StatefulWidget {
  const RecyclingHomePage({super.key});

  @override
  State<RecyclingHomePage> createState() => _RecyclingHomePageState();
}

class _RecyclingHomePageState extends State<RecyclingHomePage> {
  final TextEditingController _cityController = TextEditingController();
  bool _isLoading = false;
  String _statusMessage = "Enter a city to find recycling centers";
  List<RecyclingCenter> _centers = [];

  Future<List<RecyclingCenter>> _loadCentersFromJson() async {
    final jsonStr = await rootBundle.loadString('assets/waste_centers.json');
    final jsonData = json.decode(jsonStr);
    final List<dynamic> centersJson = jsonData['waste_centers'];
    return centersJson.map((c) => RecyclingCenter.fromJson(c)).toList();
  }

  Future<void> _searchRecyclingCenters() async {
    final city = _cityController.text.trim().toLowerCase();
    if (city.isEmpty) {
      setState(() => _statusMessage = "Please enter a city name");
      return;
    }

    setState(() {
      _isLoading = true;
      _statusMessage = "Searching in $city...";
    });

    final allCenters = await _loadCentersFromJson();

    setState(() {
      _centers = allCenters
          .where((c) => c.address.toLowerCase().contains(city))
          .toList();

      _statusMessage = _centers.isEmpty
          ? "No recycling centers found in $city"
          : "Found ${_centers.length} centers in $city";
      _isLoading = false;
    });
  }

  Future<void> _openMap(double lat, double lng) async {
    final url =
    Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open Google Maps")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recycling Center Finder"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: _isLoading
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Icon(Icons.search),
                  onPressed: _isLoading ? null : _searchRecyclingCenters,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (_) => _searchRecyclingCenters(),
            ),
            const SizedBox(height: 16),
            Text(
              _statusMessage,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _centers.isEmpty
                  ? const Center(child: Text("No results"))
                  : ListView.builder(
                itemCount: _centers.length,
                itemBuilder: (context, index) {
                  final center = _centers[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () => _openMap(center.lat, center.lng),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(center.name,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text(center.address),
                            const SizedBox(height: 8),
                            Text("Waste Type: ${center.type}"),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                onPressed: () => _openMap(center.lat, center.lng),
                                icon: const Icon(Icons.map, size: 18),
                                label: const Text("Open in Maps"),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.green.shade800,
                                  textStyle: const TextStyle(fontSize: 14),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}