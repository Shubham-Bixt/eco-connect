import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'event_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('eco_connect.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE events (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        date TEXT NOT NULL,
        image_url TEXT NOT NULL,
        location TEXT NOT NULL,
        organizer TEXT NOT NULL,
        credit_points TEXT NOT NULL,
        status TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE waste_locations (
        id TEXT PRIMARY KEY,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        type TEXT,
        status TEXT,
        created_at TEXT NOT NULL
      )
    ''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE waste_locations (
          id TEXT PRIMARY KEY,
          latitude REAL NOT NULL,
          longitude REAL NOT NULL,
          name TEXT NOT NULL,
          description TEXT,
          type TEXT,
          status TEXT,
          created_at TEXT NOT NULL
        )
      ''');
    }
  }

  // Event operations
  Future<int> createEvent(Event event) async {
    final db = await instance.database;
    return await db.insert('events', event.toMap());
  }

  Future<List<Event>> getAllEvents() async {
    final db = await instance.database;
    final maps = await db.query('events', orderBy: 'date DESC');
    return maps.map((map) => Event.fromMap(map)).toList();
  }

  Future<List<Event>> getEventsByStatus(List<String> statuses) async {
    final db = await instance.database;
    final maps = await db.query(
      'events',
      where: 'status IN (${List.filled(statuses.length, '?').join(',')})',
      whereArgs: statuses,
      orderBy: 'date DESC',
    );
    return maps.map((map) => Event.fromMap(map)).toList();
  }

  Future<int> updateEventStatus(String id, String status) async {
    final db = await instance.database;
    return await db.update(
      'events',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Waste Location operations
  Future<int> createWasteLocation(WasteLocation location) async {
    final db = await instance.database;
    return await db.insert('waste_locations', location.toMap());
  }

  Future<List<WasteLocation>> getAllWasteLocations() async {
    final db = await instance.database;
    final maps = await db.query('waste_locations', orderBy: 'created_at DESC');
    return maps.map((map) => WasteLocation.fromMap(map)).toList();
  }

  Future<List<WasteLocation>> getWasteLocationsByType(String type) async {
    final db = await instance.database;
    final maps = await db.query(
      'waste_locations',
      where: 'type = ?',
      whereArgs: [type],
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => WasteLocation.fromMap(map)).toList();
  }

  Future<int> updateWasteLocation(WasteLocation location) async {
    final db = await instance.database;
    return await db.update(
      'waste_locations',
      location.toMap(),
      where: 'id = ?',
      whereArgs: [location.id],
    );
  }

  Future<int> deleteWasteLocation(String id) async {
    final db = await instance.database;
    return await db.delete(
      'waste_locations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}