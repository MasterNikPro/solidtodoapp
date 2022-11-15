import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

import 'todo.dart';

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        tasks TEXT,
        completed TEXT
      )
      """);
  }

// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'todos.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item
  static Future<int> createItem(ToDo todo) async {
    final db = await DatabaseHelper.db();

    final data = {
      'name': todo.name,
      'tasks': jsonEncode(todo.tasks),
      'completed': jsonEncode(todo.completed)
    };
    final id = await db.insert('todos', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print("add id $id");
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseHelper.db();
    return  db.query('todos', orderBy: "id");
  }

  // Get a single item by id
  //We dont use this method, it is for you if you want it.
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('todos', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(ToDo todo) async {
    final db = await DatabaseHelper.db();

    final data = {
      'name': todo.name,
      'tasks': jsonEncode(todo.tasks),
      'completed': jsonEncode(todo.completed)
    };

    final result =
        await db.update('todos', data, where: "id = ?", whereArgs: [todo.id]);

    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {

    final db = await DatabaseHelper.db();
    try {
      await db.delete("todos", where: "id = ?", whereArgs: [id]);

    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
