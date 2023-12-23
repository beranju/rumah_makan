import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:rumah_makan/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String _tableName = "restaurant";
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(join(path, 'rumah_makan.db'),
        onCreate: (db, version) async {
      await db.execute(
        '''CREATE TABLE $_tableName 
        (
           id VARCHAR PRIMARY KEY,
           name VARCHAR, 
           description TEXT,
           pictureId VARCHAR,
           city VARCHAR,
           rating DECIMAL
        )''',
      );
    }, version: 2);

    return db;
  }

  Future<void> insertRestaurant(Restaurant restaurant) async {
    final Database db = await database;
    await db.insert(_tableName, restaurant.toMap());
    if (kDebugMode) {
      print('Data saved');
    }
  }

  Future<List<Restaurant>> getRestaurants() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => Restaurant.fromMap(res)).toList();
  }

  Future<bool> isFavorite(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName,
        where: 'id = ?',
        whereArgs: [id]);
    if (results.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> deleteRestaurant(String id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}