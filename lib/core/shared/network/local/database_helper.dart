// lib/core/shared/local/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = 'AuthApp.db';

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE User (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            phone TEXT NOT NULL,
            password TEXT NOT NULL,
            dateOfBirth TEXT NOT NULL,
            isVerified INTEGER DEFAULT 0,
            token TEXT
          );
        ''');
      },
      version: _version,
    );
  }

  static Future<int> addUser(Map<String, dynamic> user) async {
    final db = await _getDB();
    return await db.insert('User', user,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<Map<String, dynamic>?> getUser(String email) async {
    final db = await _getDB();
    final result = await db.query(
      'User',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  static Future<int> verifyUser(String email) async {
    final db = await _getDB();
    return await db.update(
      'User',
      {'isVerified': 1},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await _getDB();
    return await db.query('User');
  }
}