import 'dart:convert';

import 'package:path/path.dart';
import 'package:solid_todo/sql/todo.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper{
  static const _databaseName = "tododb.db";
  static const _databaseVersion = 1;
  static const table = 'todo_table';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnTasks = 'tasks';
  static const columnCompleted = 'completed';
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnTasks TEXT NOT NULL,
            $columnCompleted TEXT NOT NULL
          )
          ''');
  }
  Future<int> insert(ToDo todo) async {
    Database? db = await instance.database;
    return await db!.insert(table, {'name': todo.name, 'tasks': jsonEncode(todo.tasks),'completed':jsonEncode(todo.completed)});
  }
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }
  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }
  Future<int> update(ToDo todo) async {
    Database? db = await instance.database;
    int id = todo.toMap()['id'];
    return await db!.update(table, todo.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }



}