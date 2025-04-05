import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'event_model.dart';
import 'database_helper.dart';

// Re-export the LocationMarkingPage so it can be imported from map.dart
export 'events.dart';

class MapView extends StatefulWidget {
  final List<WasteLocation>? wasteLocations;
  final List<Event>? events;
  final bool showWastePoints;
  final bool showEvents;
  final Function(WasteLocation)? onWasteLocationTap;
  final Function(Event)? onEventTap;

  const MapView({
    Key? key,
    this.wasteLocations,
    this.events,
    this.showWastePoints = true,
    this.showEvents = true,
    this.onWasteLocationTap,
    this.onEventTap,
  }) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  LatLng? currentLocation;
  bool _isLoading = true;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) _showSnackBar('Please enable location services');
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) _showSnackBar('Location permissions are denied');
          if (mounted) setState(() => _isLoading = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) _showSnackBar('Location permissions are permanently denied');
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (mounted) {
        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) _showSnackBar('Error getting location: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _goToCurrentLocation() {
    if (currentLocation != null) {
      _mapController.move(currentLocation!, 15);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: currentLocation ?? const LatLng(19.0760, 72.8777), // Default to Mumbai
            initialZoom: 13,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
            ),
            // Waste Location Markers
            if (widget.showWastePoints && widget.wasteLocations != null)
              MarkerLayer(
                markers: widget.wasteLocations!.map((location) {
                  return Marker(
                    point: LatLng(location.latitude, location.longitude),
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        if (widget.onWasteLocationTap != null) {
                          widget.onWasteLocationTap!(location);
                        }
                      },
                      child: Icon(
                        Icons.delete,
                        color: _getColorForWasteType(location.type),
                        size: 40,
                      ),
                    ),
                  );
                }).toList(),
              ),
            // Event Markers
            if (widget.showEvents && widget.events != null)
              MarkerLayer(
                markers: widget.events!.map((event) {
                  // Try to parse location string to get LatLng
                  LatLng? eventLocation = _parseEventLocation(event.location);
                  if (eventLocation != null) {
                    return Marker(
                      point: eventLocation,
                      width: 40,
                      height: 40,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.onEventTap != null) {
                            widget.onEventTap!(event);
                          }
                        },
                        child: const Icon(
                          Icons.event,
                          color: Color(0xFF4D8B55),
                          size: 40,
                        ),
                      ),
                    );
                  }
                  return Marker(
                    point: currentLocation ?? const LatLng(0, 0),
                    width: 0,
                    height: 0,
                    child: Container(),
                  );
                }).toList(),
              ),
            // Current Location Marker
            if (currentLocation != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: currentLocation!,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                ],
              ),
          ],
        ),
        // Current Location Button
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            heroTag: "locationBtn",
            onPressed: _goToCurrentLocation,
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.my_location,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Color _getColorForWasteType(String? type) {
    switch (type) {
      case 'plastic':
        return Colors.blue;
      case 'paper':
        return Colors.green;
      case 'metal':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  LatLng? _parseEventLocation(String locationString) {
    try {
      // Try to parse location in format "latitude, longitude"
      if (locationString.contains(',')) {
        final parts = locationString.split(',');
        if (parts.length == 2) {
          final lat = double.tryParse(parts[0].trim());
          final lng = double.tryParse(parts[1].trim());
          if (lat != null && lng != null) {
            return LatLng(lat, lng);
          }
        }
      }
      // For named locations (like "Mumbai Convention Center"), return null
      // In a real app, you might use geocoding here
      return null;
    } catch (e) {
      return null;
    }
  }
}

// Re-export the LocationMarkingPage component with modifications to work with event.dart
class LocationMarkingPage extends StatefulWidget {
  final bool isForEvent;
  final Function(LatLng)? onLocationSelected;
  final WasteLocation? existingLocation;

  const LocationMarkingPage({
    Key? key,
    this.isForEvent = false,
    this.onLocationSelected,
    this.existingLocation,
  }) : super(key: key);

  @override
  State<LocationMarkingPage> createState() => _LocationMarkingPageState();
}

class _LocationMarkingPageState extends State<LocationMarkingPage> {
  LatLng? currentLocation;
  LatLng? selectedLocation;
  bool _isLoading = true;
  bool _isSaving = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    if (widget.existingLocation != null) {
      _nameController.text = widget.existingLocation!.name;
      _descController.text = widget.existingLocation!.description ?? '';
      _selectedType = widget.existingLocation!.type;
      selectedLocation = LatLng(
        widget.existingLocation!.latitude,
        widget.existingLocation!.longitude,
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) _showSnackBar('Please enable location services');
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) _showSnackBar('Location permissions are denied');
          if (mounted) setState(() => _isLoading = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) _showSnackBar('Location permissions are permanently denied');
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (mounted) {
        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
          selectedLocation = currentLocation;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) _showSnackBar('Error getting location: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _saveLocation() async {
    if (_isSaving) return;

    setState(() => _isSaving = true);

    try {
      if (selectedLocation == null) {
        _showSnackBar('Please select a location on the map');
        setState(() => _isSaving = false);
        return;
      }

      if (widget.isForEvent) {
        if (widget.onLocationSelected != null) {
          widget.onLocationSelected!(selectedLocation!);
        }
        if (mounted) {
          Future.microtask(() => Navigator.of(context).pop(selectedLocation));
        }
        return;
      }

      if (_nameController.text.isEmpty) {
        _showSnackBar('Please enter a location name');
        setState(() => _isSaving = false);
        return;
      }

      final location = WasteLocation(
        id: widget.existingLocation?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        latitude: selectedLocation!.latitude,
        longitude: selectedLocation!.longitude,
        name: _nameController.text,
        description: _descController.text,
        type: _selectedType,
        status: 'active',
        createdAt: widget.existingLocation?.createdAt ?? DateTime.now().toString(),
      );

      if (widget.existingLocation != null) {
        await DatabaseHelper.instance.updateWasteLocation(location);
        _showSnackBar('Location updated successfully');
      } else {
        await DatabaseHelper.instance.createWasteLocation(location);
        _showSnackBar('Location saved successfully');
      }

      if (mounted) {
        Future.microtask(() => Navigator.of(context).pop(true));
      }
    } catch (e) {
      _showSnackBar('Error saving location: $e');
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isSaving;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isForEvent ? 'Select Event Location' :
          widget.existingLocation != null ? 'Edit Waste Point' : 'Add Waste Point'),
          backgroundColor: const Color(0xFF4D8B55),
          actions: [
            IconButton(
              icon: _isSaving
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Icon(Icons.save),
              onPressed: _isSaving ? null : _saveLocation,
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            if (!widget.isForEvent) ...[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Location Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _descController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Waste Type',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'plastic', child: Text('Plastic')),
                        DropdownMenuItem(value: 'paper', child: Text('Paper')),
                        DropdownMenuItem(value: 'metal', child: Text('Metal')),
                        DropdownMenuItem(value: 'general', child: Text('General Waste')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
            Expanded(
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: widget.existingLocation != null
                      ? LatLng(widget.existingLocation!.latitude, widget.existingLocation!.longitude)
                      : currentLocation ?? const LatLng(0.0, 0.0),
                  initialZoom: 15,
                  onTap: (tapPosition, point) {
                    setState(() {
                      selectedLocation = point;
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      if (selectedLocation != null)
                        Marker(
                          point: selectedLocation!,
                          width: 50,
                          height: 50,
                          child: Icon(
                            widget.isForEvent ? Icons.event : Icons.delete,
                            color: widget.isForEvent
                                ? const Color(0xFF4D8B55)
                                : _getColorForWasteType(_selectedType),
                            size: 50,
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
    );
  }

  Color _getColorForWasteType(String? type) {
    switch (type) {
      case 'plastic':
        return Colors.blue;
      case 'paper':
        return Colors.green;
      case 'metal':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }
}

// Extension method to convert WasteLocation to LatLng
extension WasteLocationExtension on WasteLocation {
  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}