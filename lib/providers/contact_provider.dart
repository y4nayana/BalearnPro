// providers/contact_provider.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/contact_model.dart';
import 'package:path/path.dart';

class ContactProvider with ChangeNotifier {
  late Database _db;
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  Future<void> initDatabase() async {
    final dbPath = await getDatabasesPath();
    _db = await openDatabase(
      join(dbPath, 'contacts.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE contacts(id TEXT PRIMARY KEY, name TEXT, phoneNumber TEXT, email TEXT)',
        );
      },
      version: 1,
    );
    await fetchContacts();
  }

  Future<void> fetchContacts() async {
    final List<Map<String, dynamic>> maps = await _db.query('contacts');
    _contacts = maps.map((map) => Contact.fromMap(map)).toList();
    notifyListeners();
  }

  Future<void> addContact(Contact contact) async {
    await _db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _contacts.add(contact);
    notifyListeners();
  }

  Future<void> updateContact(Contact contact) async {
    await _db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
    final index = _contacts.indexWhere((c) => c.id == contact.id);
    if (index != -1) {
      _contacts[index] = contact;
      notifyListeners();
    }
  }

  Future<void> deleteContact(String id) async {
    await _db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
    _contacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
  }
}
