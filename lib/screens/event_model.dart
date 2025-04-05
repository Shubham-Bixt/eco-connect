import 'dart:convert';

class Event {
  final String id;
  final String title;
  final String date;
  final String imageUrl;
  final String location;
  final String organizer;
  final String creditPoints;
  final String status;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.location,
    required this.organizer,
    required this.creditPoints,
    this.status = EventStatus.active,
  });

  Event copyWith({
    String? id,
    String? title,
    String? date,
    String? imageUrl,
    String? location,
    String? organizer,
    String? creditPoints,
    String? status,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      organizer: organizer ?? this.organizer,
      creditPoints: creditPoints ?? this.creditPoints,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'image_url': imageUrl,
      'location': location,
      'organizer': organizer,
      'credit_points': creditPoints,
      'status': status,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] as String,
      title: map['title'] as String,
      date: map['date'] as String,
      imageUrl: map['image_url'] as String,
      location: map['location'] as String,
      organizer: map['organizer'] as String,
      creditPoints: map['credit_points'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(id: $id, title: $title, date: $date, location: $location, organizer: $organizer, creditPoints: $creditPoints, status: $status)';
  }
}

class EventStatus {
  static const active = 'Active';
  static const completed = 'Completed';
  static const closed = 'Closed';
  static const cancelled = 'Cancelled';
}

class WasteLocation {
  final String id;
  final double latitude;
  final double longitude;
  final String name;
  final String? description;
  final String? type;
  final String? status;
  final String createdAt;

  WasteLocation({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    this.description,
    this.type,
    this.status,
    required this.createdAt,
  });

  WasteLocation copyWith({
    String? id,
    double? latitude,
    double? longitude,
    String? name,
    String? description,
    String? type,
    String? status,
    String? createdAt,
  }) {
    return WasteLocation(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'description': description,
      'type': type,
      'status': status,
      'created_at': createdAt,
    };
  }

  factory WasteLocation.fromMap(Map<String, dynamic> map) {
    return WasteLocation(
      id: map['id'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      name: map['name'] as String,
      description: map['description'] as String?,
      type: map['type'] as String?,
      status: map['status'] as String?,
      createdAt: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WasteLocation.fromJson(String source) => WasteLocation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WasteLocation(id: $id, latitude: $latitude, longitude: $longitude, name: $name, description: $description, type: $type, status: $status, createdAt: $createdAt)';
  }
}