// services/database_service.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/contact_model.dart';

class DatabaseService {
  static Future<Database> _openDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'contacts.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE contacts(id TEXT PRIMARY KEY, name TEXT, phoneNumber TEXT, email TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<int> insertContact(Contact contact) async {
    final db = await _openDatabase();
    return await db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Contact>> getContacts() async {
    final db = await _openDatabase();
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return List.generate(maps.length, (i) {
      return Contact.fromMap(maps[i]);
    });
  }

  static Future<int> updateContact(Contact contact) async {
    final db = await _openDatabase();
    return await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  static Future<int> deleteContact(String id) async {
    final db = await _openDatabase();
    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}