import 'dart:ui';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;
  DatabaseHelper._internal();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'eventify.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE events (
        id INTEGER PRIMARY KEY,
        title TEXT,
        date TEXT,
        time TEXT,
        location TEXT,
        description TEXT,
        category TEXT,
        reminderTime TEXT,
        reminderFrequency TEXT
      )
    ''');
  }
}
