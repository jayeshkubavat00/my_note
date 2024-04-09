// ignore_for_file: avoid_print

import 'package:flutter_task/modules/dashboard/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  DatabaseHelper() {
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'example_database.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, email TEXT, name TEXT)',
        );
        db.execute(
          'CREATE TABLE IF NOT EXISTS items(id INTEGER PRIMARY KEY, title TEXT, subtitle TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<int> insertUserData(String email, String name) async {
    return await _database!.insert('users', {'email': email, 'name': name});
  }

  Future<Map<String, dynamic>?> queryUserData() async {
    List<Map<String, dynamic>> result = await _database!.query('users');
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<int> insertItem(NoteModel item) async {
    try {
      return await _database!.insert(
        'items',
        item.toMap(),
      );
    } catch (e) {
      print('Error inserting item: $e');
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> queryItemList() async {
    try {
      List<Map<String, dynamic>> result = await _database!.query('items');
      return result;
    } catch (e) {
      print('Error querying item list: $e');
      return [];
    }
  }

  Future<int> deleteItem(int id) async {
    try {
      return await _database!.delete(
        'items',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting item: $e');
      return -1;
    }
  }

  Future<int> updateNote(int id, String title, String subtitle) async {
    try {
      return await _database!.update(
        'items',
        {'title': title, 'subtitle': subtitle},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error updating item: $e');
      return -1;
    }
  }
}
