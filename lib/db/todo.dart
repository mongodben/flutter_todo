import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../todo.dart';

class TodoDb {
  Database db;
  String tableName;

  TodoDb(this.db, this.tableName);

  Future<bool> insert(Todo todo) async {
    await db.insert(
      tableName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;
  }

  Future<List<Todo>?> getAll() async {
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        name: maps[i]['name'],
        status: getTodoStatus(maps[i]['status']),
      );
    });
  }

  Future<bool> update(Todo todo) async {
    await db.update(
      tableName,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
    return true;
  }

  Future<bool> delete(String id) async {
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return true;
  }
}
