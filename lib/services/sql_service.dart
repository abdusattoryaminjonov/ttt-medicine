import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/pill_sql_model.dart';


class SqlPillDatabase {
  static final SqlPillDatabase instance = SqlPillDatabase._init();
  static Database? _database;

  SqlPillDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pills (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        totalNumber TEXT,
        dayNumber TEXT,
        startDate TEXT,
        consumptionDay TEXT,
        dayTime TEXT,
        dayOfWeekAndTime TEXT
      )
    ''');
  }

  // Add Pill
  static Future<int> insertPill(SqlPill pill) async {
    final db = await instance.database;
    return await db.insert(
        'pills', pill.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get Pills
  static Future<List<SqlPill>> getPills() async {
    final db = await instance.database;
    final result = await db.query('pills');
    return result.map((json) => SqlPill.fromMap(json)).toList();
  }

  // Update Pill
  static Future<int> updatePill(SqlPill pill) async {
    final db = await instance.database;
    return await db.update(
      'pills',
      pill.toMap(),
      where: 'id = ?',
      whereArgs: [pill.id],
    );
  }

  // Delete Pill
  static Future<int> deletePill(int id) async {
    final db = await instance.database;
    return await db.delete('pills', where: 'id = ?', whereArgs: [id]);
  }
}